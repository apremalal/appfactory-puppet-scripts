class stratos::cc ( $version, 
		   $offset=0, 
		   $tribes_port=4000, 
		  # $config_db=governance, 
		    $maintenance_mode=true, 
		  # $depsync=false, 
		  # $sub_cluster_domain=mgt,
		   $owner=root,
		   $group=root,
		   $target="/mnt" ) {
	
	$deployment_code	= "cc"

	$stratos_version 	= $version
	$service_code 		= "cc"
	$carbon_home		= "${target}/wso2${service_code}-${stratos_version}"

	$service_templates 	= [
					"conf/advanced/qpid-virtualhosts.xml",
					"conf/carbon.xml",
					"conf/cloud-controller.xml",
					"deployment/server/services/as_staging_service.xml",
					"deployment/server/services/as_dev_service.xml",
					"deployment/server/services/as_prod_service.xml",
					"deployment/server/services/as_test_service.xml",
					"deployment/server/cartridges/as-dev.xml",
					"deployment/server/cartridges/as-test.xml",
					"deployment/server/cartridges/as-staging.xml",
					"deployment/server/cartridges/as-prod.xml",
				]

        $common_templates       = []


	tag ($service_code)

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
		mode		=> $maintenance_mode,
                target          => $carbon_home,
	}

	initialize { $deployment_code:
                repo            => $package_repo,
		version         => $stratos_version,
		mode		=> $maintenance_mode,
		service		=> $service_code,
		local_dir       => $local_package_dir,
		owner		=> $owner,
		target   	=> $target,
		require		=> Stratos::Clean[$deployment_code],
	}

	deploy { $deployment_code:
		service		=> $service_code,	
		security	=> "true",
		owner		=> $owner,
		group		=> $group,
		target		=> $carbon_home,
		require		=> Stratos::Initialize[$deployment_code],
	}

	push_templates { 
		$service_templates: 
		target		=> $carbon_home,
		directory 	=> $service_code,
		require 	=> Stratos::Deploy[$deployment_code];
	}

	start { $deployment_code:
		owner		=> $owner,
                target          => $carbon_home,
		require		=> [ Stratos::Initialize[$deployment_code],
				     Stratos::Deploy[$deployment_code],
				     Push_templates[$service_templates],
				   ],
	}
}

