class wso2::elb ( $version, 
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
					"conf/axis2/axis2.xml",
					"conf/user-mgt.xml",
					"conf/carbon.xml",
                                        "conf/loadbalancer.conf"
				]

	tag ("elb")

	if $auto_failover == "true" {
		include keepalived
	}
	else {
		notice("No failover requested")
	}

        define pushtemplates ( $directory, $target ) {
        
                file { "${target}/repository/${name}":
                        owner   => $owner,
                        group   => $group,
                        mode    => 755,
                        content => template("${directory}/${name}.erb"),
                        ensure  => present,
                }
        }

	cleandeployment { $deployment_code:
		mode		=> $maintenance_mode,
                target          => $carbon_home,
	}

	initializedeployment { $deployment_code:
		repo		=> $package_repo,
		version         => $stratos_version,
		mode		=> $maintenance_mode,
		service		=> $service_code,
		local_dir       => $local_package_dir,
		owner		=> $owner,
		target   	=> $target,
		require		=> WSO2::CleanDeployment[$deployment_code],
	}

	deployservice { $deployment_code:
		service		=> $service_code,	
		security	=> "true",
		owner		=> $owner,
		group		=> $group,
		target		=> $carbon_home,
		require		=> WSO2::InitializeDeployment[$deployment_code],
	}

	pushtemplates { 
		$service_templates: 
		target		=> $carbon_home,
		directory 	=> $service_code,
		require 	=> WSO2::DeployService[$deployment_code];
        }

	startservice { $deployment_code:
		owner		=> $owner,
                target          => $carbon_home,
		require		=> [ WSO2::InitializeDeployment[$deployment_code],
				     WSO2::DeployService[$deployment_code],
				     PushTemplates[$service_templates],
				   ],
	}
}
