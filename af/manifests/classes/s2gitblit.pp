class s2gitblit(){

	$git_home = "/mnt/s2gitblit-1.1.0"
	$admin_uname = $adminuser_name
	$admin_passwd = $adminuser_passwd

#	package {
#		"git":
#		ensure          => installed;
#	}
	
	exec { "download_s2gitblit":
		path            => ["/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"],
		cwd		=> "/mnt/",
		unless		=> "test -f /mnt/gitblit-1.1.0.zip",
		command		=> "wget -q ${package_repo}/software/gitblit-1.1.0.zip";

		"extract_s2gitblit":
		path            => ["/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"],
		unless		=> "test -d ${git_home}",
		cwd		=> "/mnt/",
		command		=> "unzip gitblit-1.1.0.zip -d ${git_home}";
	}
	
	file { "/mnt/s2gitblit":
                ensure  => link,
                target  => "${git_home}";

		"/mnt/tmp":
                ensure  => directory;

		"${git_home}/groovy/notifys2.groovy":
                owner   => root,
                group   => root,
                mode    => 644,
                content => template("s2gitblit/notifys2.groovy.erb");

		"${git_home}/gitblit.properties":
                owner   => root,
                group   => root,
                mode    => 644,
                content => template("s2gitblit/gitblit.properties.erb");

		"${git_home}":
		owner   => $user,
		recurse	=> true,
		ignore	=> ".svn",
		source => "puppet:///s2gitblit";

	}

	exec { "start_s2gitblit":
		path            => ["/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/java/bin"],
		cwd		=> "/mnt/s2gitblit",
		command		=> "/bin/bash start-gitblit.sh";

	}

	Exec["download_s2gitblit"] -> Exec["extract_s2gitblit"] -> File["${git_home}/gitblit.properties"] ->  File["${git_home}"] -> Exec["start_s2gitblit"]
}
