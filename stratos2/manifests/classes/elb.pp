class stratos::elb ( $version, 
		     $services, 
		     $maintenance_mode=true, 
		     $auto_scaler=false, 
		     $auto_failover=false,
		     $owner=root,
		     $group=root,
		     $target="/mnt" ) {

	$deployment_code        = "elb"

	$stratos_version 	= $version
	$service_code 		= "elb"
	$carbon_home            = "${target}/wso2${service_code}-${stratos_version}"

	$service_templates	= [
					"conf/loadbalancer.conf",
					"conf/datasources/master-datasources.xml",
                                        "conf/user-mgt.xml",
					"conf/tenant-mgt.xml",
					
				]

	$common_templates	= []

	tag ("elb")


        define push_templates ( $directory, $target ) {

                file { "${target}/repository/${name}":
                        owner   => $owner,
                        group   => $group,
                        mode    => 755,
                        content => template("${directory}/${name}.erb"),
                        ensure  => present,
                }
        }

	clean { $deployment_code:
                mode            => $maintenance_mode,
                target          => $carbon_home,
        }

	initialize { $deployment_code:
                repo            => $package_repo,
                version         => $stratos_version,
                mode            => $maintenance_mode,
                service         => $service_code,
                local_dir       => $local_package_dir,
		owner		=> $owner,
                target          => $target,
                require         => Stratos::Clean[$deployment_code],
        }

	deploy { $deployment_code:
                service         => $service_code,
		security	=> "true",
		owner		=> $owner,
		group		=> $group,
                target          => $carbon_home,
                require         => Stratos::Initialize[$deployment_code],
        }

	push_templates {
                $service_templates:
                target          => $carbon_home,
                directory       => $service_code,
                require         => Stratos::Deploy[$deployment_code];
        }

#	exec {"Wait for Cloud Controller":
#                command => "/usr/bin/wget --spider --tries 100 --retry-connrefused  http://cc.$stratos_domain:5673",
#        }   

	start { $deployment_code:
		owner		=> $owner,
                target          => $carbon_home,
                require         => [ Stratos::Initialize[$deployment_code],
                                     Stratos::Deploy[$deployment_code],
                                     Push_templates[$service_templates],
#				     Exec["Wait for Cloud Controller"],
                                   ],
        }
}

