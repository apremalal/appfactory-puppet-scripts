class wso2::storage ( $version,
      $offset=0,
      $tribes_port=4000,
      $config_db=governance,
      $maintenance_mode=true,
      $sub_cluster_domain=mgt,
      $css_id=node0,
      $owner=root,
      $group=root,
      $rss_dev_instance_prefix,
      $rss_test_instance_prefix,
      $rss_staging_instance_prefix,
      $rss_prod_instance_prefix,
      $rss_database,
      $rss_user,
      $rss_password,
      $target="/mnt" ) {
    $deployment_code    = "storage"
    $stratos_version     = $version
    $service_code         = "ss"
    $carbon_home        =  "${target}/wso2${service_code}-${stratos_version}"
    $service_templates    = [
                    "conf/axis2/axis2.xml",
                    "conf/carbon.xml",
                    "conf/etc/cassandra-component.xml",
                    "conf/etc/cassandra-auth.xml",
                    "conf/etc/cassandra-endpoint.xml",
                    "conf/etc/cluster-config.xml",
                    "conf/etc/cluster-monitor-config.xml",
                    "conf/etc/logging-config.xml",
                    "conf/etc/rss-config.xml",
                    "conf/user-mgt.xml",
                    "conf/datasources/master-datasources.xml",
                    "conf/tomcat/catalina-server.xml"
                ]

    $common_templates     = [   
                    "conf/etc/cache.xml",
                ]

    tag ($service_code)

    tag ("storage")

    define push_templates ( $directory, $target ) {
               file { "${target}/repository/${name}":
                       owner   => $owner,
                       group   => $group,
                       mode    => 755,
                       content => template("${directory}/${name}.erb"),
                       ensure  => present,
               }
    }

    cleandeployment { $deployment_code:
        mode        => $maintenance_mode,
               target          => $carbon_home,
    }

    initializedeployment { $deployment_code:
        repo        => $package_repo,
        version         => $stratos_version,
        mode        => $maintenance_mode,
        service        => "ss",
        local_dir       => $local_package_dir,
        owner        => $owner,
        target       => $target,
        require        => WSO2::Cleandeployment[$deployment_code],
    }

    deployservice { $deployment_code:
        service        => $service_code,
        security    => "true",
        owner        => $owner,
        group        => $group,
        target        => $carbon_home,
        require        => WSO2::Initializedeployment[$deployment_code],
    }

    push_templates {
        $service_templates:
        target        => $carbon_home,
        directory     => $service_code,
        require     => WSO2::Deployservice[$deployment_code];
        $common_templates:
        target          => $carbon_home,
          directory       => "commons",
        require     => WSO2::Deployservice[$deployment_code],
    }

    startservice { $deployment_code:
        owner        => $owner,
        target          => $carbon_home,
        require        => [ WSO2::Initializedeployment[$deployment_code],
                     WSO2::Deployservice[$deployment_code],
                     Push_templates[$service_templates],
                     Push_templates[$common_templates],
                   ],
    }

}
