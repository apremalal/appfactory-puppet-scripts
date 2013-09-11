class gitblit(){

	$git_home = "/mnt/gitblit-1.0.0"
	$admin_uname = $adminuser_name
	$admin_passwd = $adminuser_passwd

	
	define setup {
		exec { "download_gitblit":
			path            => ["/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"],
			cwd		=> "/mnt/",
			unless		=> "test -f /mnt/gitblit-1.1.0.zip",
			command		=> "wget -q ${package_repo}/software/gitblit-1.1.0.zip";

			"extract_gitblit":
			path            => ["/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"],
			unless		=> "test -d /mnt/gitblit-1.1.0",
			cwd		=> "/mnt/",
			command		=> "unzip gitblit-1.1.0.zip -d ${git_home}",
			require		=> Exec["download_gitblit"];
		}
	}

	define deploy {

		file { 
			"/mnt/gitblit":
			ensure  => link,
			target  => "${$git_home}";

			"/mnt/tmp":
			ensure  => directory;

			"/mnt/gitblit-1.0.0":
			owner   => $user,
			recurse	=> true,
			ignore	=> ".svn",
			source  => "puppet:///gitblit",
			require	=> File["/mnt/gitblit"];

		}
	}

	define push_templates {
		file { 

			"/mnt/gitblit-1.0.0/groovy/jenkins.groovy":
			owner   => root,
			group   => root,
			mode    => 644,
			content => template("gitblit/groovy/jenkins.groovy.erb");

			"/mnt/gitblit-1.0.0/puppet_init.sh":
			owner   => root,
			group   => root,
			mode    => 755,
			content => template("puppet_init.sh.erb");

			"/mnt/gitblit-1.0.0/gitblit.properties":
			owner   => root,
			group   => root,
			mode    => 644,
			content => template("gitblit/gitblit.properties.erb");

		}
	}

	define start {
		exec { "start_gitblit":
			path            => ["/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/java/bin"],
			cwd		=> "/mnt/gitblit",
			command		=> "/bin/bash start-gitblit.sh";
		}
	}

	setup {"Download and extract gitblit":}
	deploy {"Copy modules to gitblit":
		require		=> Setup["Download and extract gitblit"];
	}
	push_templates {"Copy template files to gitblit":
		require		=> Deploy["Copy modules to gitblit"];
	}
	start {"Start Gitblit":
		require		=> [ Setup["Download and extract gitblit"],
				     Deploy["Copy modules to gitblit"],
				     Push_templates ["Copy template files to gitblit"],
				   ]
	}	
}
