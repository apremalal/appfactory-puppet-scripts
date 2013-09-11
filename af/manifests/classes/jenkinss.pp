class jenkinss(){

        $remotefs = "/mnt/jenkins_build"
	$repo_url = $package_repo


        file { 
		"/root/.ssh":
		ensure	=> directory;

                "/root/.ssh/authorized_keys2":
                source  => "puppet:///jenkins/jenkins.pub";

                "/root/.netrc":
                source  => "puppet:///jenkins/netrc";

                "${remotefs}":
                ensure  => directory,
                owner  => "root",
                group  => "root";


        }

        File["/root/.ssh"] -> File["/root/.ssh/authorized_keys2"]  -> File["${remotefs}"]
}

