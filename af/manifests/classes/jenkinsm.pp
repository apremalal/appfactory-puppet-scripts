class jenkinsm(){
		$user	= "root"
		$group = "root"
		$base_dir = "/mnt"
		$remotefs = "/mnt/jenkins_build"
		$jenkins_home = "/mnt/jenkins"
		$jenkins_slave = "node3.domain.com"
		$priv_key = "/${user}/.ssh/jenkins"
		$repo_url = $package_repo
		
		file { 
				"/${user}/.ssh":
				ensure  => directory;

				"${priv_key}":
				owner	=> "${user}",
				group	=> "${group}",
				mode	=> "600",
				source  => "puppet:///jenkins/jenkins";

		}


    file { [ "${jenkins_home}", "${jenkins_home}/repository",
             "${jenkins_home}/storage" ]:
      ensure => "directory",
      owner => "${user}",
      group => "${group}",
      mode  => "0755",
     }


    exec {
      "download_jenkins":
      path    => ["/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"],
      unless  => "test -f ${jenkins_home}/jenkins.war",
      cwd => "${jenkins_home}",
      command => "wget -q ${repo_url}/software/jenkins.war";

    }


		file {	"${jenkins_home}/repository/config.xml":
			content => template("jenkins/config.xml.erb");

			"/root/.netrc":
			content => template("jenkins/netrc.erb");

			"${jenkins_home}/repository/org.wso2.carbon.appfactory.jenkins.AppfactoryPluginManager.xml":
			content => template("jenkins/org.wso2.carbon.appfactory.jenkins.AppfactoryPluginManager.xml.erb");

			"${jenkins_home}/jenkinsServer.sh":
			source 	=> "puppet:///jenkins/jenkinsServer.sh";

			"${jenkins_home}/wso2carbon.jks":
				owner	=> "${user}",
				group	=> "${group}",
				mode	=> "0755",
				source  => "puppet:///jenkins/wso2carbon.jks";

			"${jenkins_home}/client-truststore.jks":
				owner	=> "${user}",
				group	=> "${group}",
				mode	=> "0755",
				source  => "puppet:///jenkins/client-truststore.jks";


			"${jenkins_home}/repository/hudson.tasks.Maven.xml":
				owner	=> "${user}",
				group	=> "${group}",
				mode	=> "0600",
				source  => "puppet:///jenkins/repository/hudson.tasks.Maven.xml";

      "${jenkins_home}/repository/plugins":
        ensure => directory,
        owner => "${user}",
        group => "${group}",
        mode  => "0600",
        recurse => true,
        source  => "puppet:///jenkins/repository/plugins";

		}

		exec {
			"start_jenkins":
			path    => ["/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"],
			cwd	=> "${jenkins_home}",
			user	=> "${user}",
			command => "bash ${jenkins_home}/jenkinsServer.sh";
		}

		File["${priv_key}"] -> 
    File["${jenkins_home}"] ->
    File["${jenkins_home}/repository"] ->
    File["${jenkins_home}/repository/plugins"] ->
    File["${jenkins_home}/storage"] ->
    Exec["download_jenkins"] ->
    File["${jenkins_home}/repository/config.xml"] -> 
    File["${jenkins_home}/repository/org.wso2.carbon.appfactory.jenkins.AppfactoryPluginManager.xml"] -> 
    File["${jenkins_home}/jenkinsServer.sh"] -> 
    File["${jenkins_home}/wso2carbon.jks"] -> 
    File["${jenkins_home}/client-truststore.jks"] -> 
    File["${jenkins_home}/repository/hudson.tasks.Maven.xml"] -> 
    Exec["start_jenkins"]
}
