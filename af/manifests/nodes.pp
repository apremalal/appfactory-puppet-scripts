stage { 'configure': require => Stage['main'] }
stage { 'deploy': require => Stage['configure'] }

node basenode {
  $package_repo       = 'http://packagerepo.domain.com'
  $depsync_svn_repo   = 'https://svn.appfactory.domain.com/wso2/repo/'
  $local_package_dir  = '/mnt/packs'
  $deploy_new_packs   = 'true'
}

node confignode inherits basenode  {
  ## Service subdomains
  $wso2_env_domain      = 'appfactory.domain.com'
  $af_cluster_domain    = 'appfactory'
  $as_subdomain         = 'appserver'
  $ss_subdomain         = 'storage'
  $am_subdomain         = 'apimanager'
  $analyzer_subdomain   = 'analyzer'
  $esb_subdomain        = 'esb'

  $management_subdomain = 'management'

  ## MySQL server configuration details
  $mysql_server_1       = "mysql.${wso2_env_domain}"
  $mysql_server_2       = "mysql.${wso2_env_domain}"
  $mysql_port           = '3306'
  $max_connections      = '100000'
  $max_active           = '150'
  $max_wait             = '360000'
  $mysql_driver_file    = 'mysql-connector-java-5.1.12-bin.jar'

  ## Deployment Synchronizer
  $repository_type      = 'svn'
  $svn_user             = 'wso2'
  $svn_password         = 'xxxx'

  ## Auto-scaler
  $keystore_password        = 'wso2carbon'
  $auto_scaler_epr          = 'http://xxx:9863/services/AutoscalerService/'
  $auto_scaler_task_interval= '60000'
  $server_startup_delay     = '180000'

  ## Database details
  $registry_user        = 'registry'
  $registry_password    = 'xxxx'
  $registry_database    = 'governance'

  $bpel_mysql_username   = 's2user'
  $bpel_mysql_password   = 'xxxx'

  ## Appfactory
  $adminuser_name       = 'admin@admin.com'
  $adminuser_passwd     = 'xxxx'
  $app_creation_delay   = '1000'
  $af_registration_link = 'http://wso2.org/user/register'
  $af_identity_provider = "https://${wso2_env_domain}/samlsso"
  $af_keystore_passwd   = 'xxxx'
  $af_keystore_alias    = 'wso2carbon'
  $jenkins_resource_uid = 'admin@admin.com'
  $jenkins_apitoken     = '11111'
  $redmine_admin_uname  = 'admin'
  $redmine_admin_passwd = 'xxxx'
  $jpadb_user           = 'jpadb'
  $jpadb_passwd         = 'xxxx'
  $truststore_passwd    = 'xxxx'
  $s2_enabled           = true
  $cartridge_dev_alias  = 'asdev'
  $cartridge_dev_type   = 'asdev'
  $cartridge_test_alias = 'astest'
  $cartridge_test_type  = 'astest'
  $cartridge_staging_alias  = 'asstaging'
  $cartridge_staging_type   = 'asstaging'
  $cartridge_prod_alias     = 'asprod'
  $cartridge_prod_type      = 'asprod'
  $tenant_manager_class     = 'org.wso2.carbon.appfactory.userstore.AppFactoryTenantManager'
  $app_base                 = 'ou=application,ou=appfactory-beta,ou=services,dc=ldap,dc=wso2,dc=org'
  $appfactory_tenant_mgt_service_epr= "sc.${wso2_env_domain}"

  ## Redmine
  $redminedb_user       = "redmine"
  $redminedb_passwd     = "xxxx"
  $redmine_domain       = "redmine.${wso2_env_domain}"
  $redmine_certfile     = "cert.crt"
  $redmine_keyfile      = "key.key"
  $redmine_cafile       = "CA.crt"

  ## API Manager
  $am_nio_http_port     = "8280"
  $am_nio_https_port    = "8243"
  $apimgt_db_user       = "apimgt"
  $apimgt_db_passwd     = "xxxx"

  #Storage RSS
  #rss
  $hive_database        = "metastore_db"
  $rss_database         = "rss_mgt"
  $rss_user             = "rss_mgt"
  $rss_password         = "xxxx"
  $rss_instance_user    = "wso2admin"
  $rss_instance_password= "xxxx"

  $rss_instance0        = "rss0"
  $rss_instance1        = "rss1"
  $rss_instance2        = "rss2"

  $userstore_user       = "userstore"
  $userstore_password   = "xxxx"
  $userstore_database   = "userstore"

  ## Cassandra details
  $css0_subdomain       = "node0.cassandra"
  $css1_subdomain       = "node1.cassandra"
  $css2_subdomain       = "node2.cassandra"
  $css_cluster_name     = "AF Setup"
  $css_port             = "9160"
  $cassandra_username   = "admin"
  $cassandra_password   = "xxxx"
  $css_replication_factor = "3"
  $hdfs_url               = "hadoop0"
  $hdfs_port              = "9000"
  $hdfs_job_tracker_port  = "9001"

  ## User MGT
  $usrmgt_username        = "admin.admin.com"
  $usrmgt_password        = "xxxx"
  $usrmgt_connectionname  = "cn=appfacadmin,dc=ldap,dc=wso2,dc=org"
  $usrmgt_connectionpasswd= "xxxx"

  $usrmgt_class         = "org.wso2.carbon.appfactory.userstore.AppFactoryUserStore"
  $usrmgt_class_cloud   = "org.wso2.carbon.appfactory.userstore.AppFactoryUserStore"
  $usrmgt_usb           = "ou=user,dc=ldap,dc=wso2,dc=org"
  $usrmgt_unsf          = "(&amp;(objectClass=inetOrgPerson)(uid=?))"
  $usrmgt_una           = "uid"
  $usrmgt_gsb           = "ou=group,ou=appfactory-beta,ou=services,dc=ldap,dc=wso2,dc=org"
  $usrmgt_udnp          = "${usrmgt_una}={0},ou=user,dc=ldap,dc=wso2,dc=org"

  ## Hadoop details
  $hadoop1_subdomain    = "hadoop1"
  $hadoop2_subdomain    = "hadoop2"
  $dfs_replication      = "1"
  $hadoop_heapsize      = "1024"

  ## LOGEVENT configurations
  $receiver_url         = "receiver.${wso2_env_domain}"
  $receiver_port        = "7617"
  $receiver_secure_port = "7717"
  $receiver_username    = "cassandra"
  $receiver_password    = "xxxx"


  ## Server details for billing
  $time_zone            = "GMT-8:00"

  ##s2gitblit confiugeration
  $s2gitbit_http_port   = "80"
  $s2gitbit_https_port  = "443"
  $s2gitblit_server     ="s2git.${wso2_env_domain}"
  $s2gitblit_https_port_enabled =false
  $adc_server_domain    ="sc.${wso2_env_domain}"
  $adc_server_port      ="9445"
  $s2gitblit_server_port  ="80"
  $s2git_adminusername  = "admin"
  $s2git_adminpassword  = "xxxx"

  ##Datasource Passwords  
  $carbon_db_password   = "wso2carbon"

  ##AM Master Datasource Passwords
  $reg_db_password              = "regdb123"
  $am_db_password               = "amdb123"
  $am_config_registry_password  = "xxxx"
  $am_stat_db_password          = "wso2carbon"

  ## Datasource Passwords 
  $apistore_keystore_password     = "xxxx"
  $apistore_keystore_alias        = "wso2carbon"
  $apipublisher_keystore_password = "xxxx"
  $apipublisher_keystore_alias    = "wso2carbon"

  ## Catalina Thread configrations
  ## AM
  $am_accept_thread_count = "2"
  $am_max_threads         = "250"
  $am_min_spare_threads   = "50"
  ## CG
  $cg_accept_thread_count = "200" 
  $cg_max_threads         = "250"
  $cg_min_spare_threads   = "250"
  ## Manager
  $mgr_accept_thread_count= "200"        
  $mgr_max_threads        = "250"
  $mgr_min_spare_threads  = "250"
  ## CEP
  $cep_accept_thread_count= "200"        
  $cep_max_threads        = "250"
  $cep_min_spare_threads  = "250"
  ## MB
  $mb_accept_thread_count = "200" 
  $mb_max_threads         = "250"
  $mb_min_spare_threads   = "250"
  ## AS
  $as_accept_thread_count = "2"   
  $as_max_threads         = "750"
  $as_min_spare_threads   = "150"
  ## SS
  $ss_accept_thread_count = "2"
  $ss_max_threads         = "250"
  $ss_min_spare_threads   = "50"
}


###### Staging Setup ########################
node 'appfactory01.domain.com' inherits confignode {
  $server_ip= $ipaddress 
  include system_config

  class {"mvn":}

  class {"wso2::appfactory":
    version            => "1.0.0",
    offset             => 1,
    tribes_port        => 4100,
    config_db          => "appfactory_config",
    maintenance_mode   => true,
    owner              => "ubuntu",
    group              => "ubuntu",
    target             => "/mnt/${server_ip}",
    sub_cluster_domain => "mgt",
    stage              => "deploy",
    af_config_db       => 'appfactory_config',
    clustering         => true,
  }

  class {"wso2::elb":
    services           =>  ["appfactory,*,*"],
    version            => "2.0.3",
    maintenance_mode   => true,
    auto_scaler        => false,
    auto_failover      => false,
    owner              => "root",
    group              => "root",
    target             => "/mnt/${server_ip}",
    stage              => "deploy",
  }

}


node 'appfactory02.domain.com' inherits confignode {
  $server_ip= $ipaddress
  include system_config

  class {"mvn":}

  class {"wso2::appfactory":
    version            => "1.0.0",
    offset             => 1,
    tribes_port        => 4100,
    config_db          => "appfactory_config",
    maintenance_mode   => true,
    owner              => "ubuntu",
    group              => "ubuntu",
    target             => "/mnt/${server_ip}",
    sub_cluster_domain => "mgt",
    stage              => "deploy",
    af_config_db       => 'af_bps_config',
    clustering         => 'false',
  }
}


node 'appfactory03.domain.com' inherits confignode {
  $server_ip= $ipaddress
  include system_config

  class {"apache":}

  class {"apache_vhost":
    port            => '80',
    servername      => "jenkins.${wso2_env_domain}",
  }

  class {"mvn":}

  class {"jenkinsm":}

}


node 'appfactory04.domain.com' inherits confignode {
  $server_ip= $ipaddress 
  include system_config
  
  class {"mvn":}

  class { "gitblit":}

}

node 'appfactory05.domain.com' inherits confignode {
  $server_ip= $ipaddress 
  include system_config

  class {"apache":}

  class {"apache_vhost":
    port        => '80',
    servername  => "redmine.${wso2_env_domain}"
  }

  class {"redmine":}
}

node 'appfactory06.domain.com' inherits confignode {
  $server_ip      = $ipaddress
  include system_config

  class {"wso2::am":
    version            => "1.4.0",
    offset             => 0,
    tribes_port        => 4000,
    maintenance_mode   => true,
    sub_cluster_domain => "mgt",
    owner              => "root",
    group              => "root",
    target             => "/mnt/${server_ip}",
    stage              => "deploy",
  }
}

node 'appfactory07.domain.com' inherits confignode {
  $server_ip      = $ipaddress
  include system_config


  class {"wso2::storage":
    version                     => "1.0.3",
    offset                      => 0,
    tribes_port                 => 4000,
    config_db                   => "ss_config",
    maintenance_mode            => true,
    sub_cluster_domain          => "worker",
    owner                       => "root",
    group                       => "root",
    css_id                      => "prod",
    target                      => "/mnt/${server_ip}",
    rss_dev_instance_prefix     => "Development",
    rss_test_instance_prefix    => "Testing",
    rss_staging_instance_prefix => "Staging",
    rss_prod_instance_prefix    => "Production",
    rss_database                => "rss_mgt",
    rss_user                    => "rss_mgt",
    rss_password                => "xxxx",
    stage                       => "deploy",
  }

}

node 'appfactory12.domain.com' inherits confignode {
  $server_ip      = $ipaddress
  include system_config

  class {"mvn":}

  class {"s2gitblit":}
}


## Appserver Cartridge configs

node /[0-9]{1,12}.appserver.test.staging.com/ inherits confignode {
  $server_ip  = $ipaddress 
  include system_config

  class {"wso2::appserver::test":
    version            => "5.1.0",
    offset             => 0,
    tribes_port        => 4100,
    config_db          => "as_test_config",
    datasource         => "WSO2ASTestConfigDB",
    maintenance_mode   => false,
    depsync            => true,
    sub_cluster_domain => "mgt",
    owner              => "ubuntu",
    group              => "ubuntu",
    af_env             => "test",
    target             => "/mnt/${server_ip}/test",
    stage              => "deploy",
  }
}

node /[0-9]{1,12}.appserver.dev.staging.com/ inherits confignode {

  $server_ip = $ipaddress 
  include system_config
  
  class {"wso2::appserver::dev":
    version            => "5.1.0",
    offset             => 0,
    tribes_port        => 4100,
    config_db          => "as_dev_config",
    datasource         => "WSO2ASDevConfigDB",
    maintenance_mode   => false,
    depsync            => true,
    sub_cluster_domain => "mgt",
    owner              => "ubuntu",
    group              => "ubuntu",
    af_env             => "dev",
    target             => "/mnt/${server_ip}/dev",
    stage              => "deploy",
  }
}

node /[0-9]{1,12}.appserver.staging.staging.com/ inherits confignode {

  $server_ip = $ipaddress 
  include system_config

  class {"wso2::appserver::staging":
    version            => "5.1.0",
    offset             => 0,
    tribes_port        => 4100,
    config_db          => "as_staging_config",
    datasource         => "WSO2ASDevConfigDB",
    maintenance_mode   => false,
    depsync            => true,
    sub_cluster_domain => "mgt",
    owner              => "ubuntu",
    group              => "ubuntu",
    af_env             => "staging",
    target             => "/mnt/${server_ip}/staging",
    stage              => "deploy",
  }
}

node /[0-9]{1,12}.appserver.staging.com/ inherits confignode {

  $server_ip = $ipaddress 
  include system_config
  
  class {"wso2::appserver::dev":
    version            => "5.1.0",
    offset             => 0,
    tribes_port        => 4100,
    config_db          => "as_prod_config",
    datasource         => "WSO2ASProdConfigDB",
    maintenance_mode   => false,
    depsync            => true,
    sub_cluster_domain => "mgt",
    owner              => "ubuntu",
    group              => "ubuntu",
    af_env             => "prod",
    target             => "/mnt/${server_ip}/prod",
    stage              => "deploy",
  } 
}

## End Appserver cartridge configs

## ESB cartridge configs

node /[0-9]{1,12}.esb.dev.staging.com/ inherits confignode{
  $server_ip      =  $ipaddress 
  include system_config

  class {"wso2::esb":
    version            => "4.6.0",
    offset             => 0,
    tribes_port        => 4100,
    config_db          => "esb_config",
    maintenance_mode   => false,
    depsync            => true,
    sub_cluster_domain => "mgt",
    owner              => "ubuntu",
    group              => "ubuntu",
    target             => "/mnt/${server_ip}",
    stage              => "deploy",
    repository_type    => "git",
    cartridge_type     => "esb",
    af_env             => "dev",
    datasource         => "WSO2ESBDevConfigDB",
    generic            => 1,
  }

}

node /[0-9]{1,12}.esb.test.staging.com/ inherits confignode{
  $server_ip      = $ipaddress 
  include system_config

  class {"wso2::esb":
    version            => "4.6.0",
    offset             => 0,
    tribes_port        => 4100,
    config_db          => "esb_config",
    maintenance_mode   => false,
    depsync            => true,
    sub_cluster_domain => "mgt",
    owner              => "ubuntu",
    group              => "ubuntu",
    target             => "/mnt/${server_ip}",
    stage              => "deploy",
    repository_type    => "git",
    cartridge_type     => "esb",
    af_env             => "test",
    datasource         => "WSO2ESBTestConfigDB",
    generic            => 1,
  }
}

node /[0-9]{1,12}.esb.staging.staging.com/ inherits confignode{
  $server_ip      = $ipaddress 
  include system_config

  class {"wso2::esb":
    version            => "4.6.0",
    offset             => 0,
    tribes_port        => 4100,
    config_db          => "esb_config",
    maintenance_mode   => false,
    depsync            => true,
    sub_cluster_domain => "mgt",
    owner              => "ubuntu",
    group              => "ubuntu",
    target             => "/mnt/${server_ip}",
    stage              => "deploy",
    repository_type    => "git",
    cartridge_type     => "esb",
    af_env             => "staging",
    datasource         => "WSO2ESBStagingConfigDB",
    generic            => 1,
  }
}

node /[0-9]{1,12}.esb.prod.staging.com/ inherits confignode{
  $server_ip      = $ipaddress 
  include system_config

  class {"wso2::esb":
    version            => "4.6.0",
    offset             => 0,
    tribes_port        => 4100,
    config_db          => "esb_config",
    maintenance_mode   => false,
    depsync            => true,
    sub_cluster_domain => "mgt",
    owner              => "ubuntu",
    group              => "ubuntu",
    target             => "/mnt/${server_ip}",
    stage              => "deploy",
    repository_type    => "git",
    cartridge_type     => "esb",
    af_env             => "prod",
    datasource         => "WSO2ESBProdConfigDB",
    generic            => 1,
  }
}

## End ESB cartridge configs
