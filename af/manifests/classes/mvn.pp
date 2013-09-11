class mvn(){
        $maven_package = "apache-maven-3.0.5-bin.tar.gz"
        $maven_dir = "apache-maven-3.0.5" 

	exec { "download_mvn":
		path   	=> ["/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"],
		cwd	=> "/opt/",
		unless	=> "test -f /opt/${maven_package}",
		command	=> "wget -q ${package_repo}/software/${maven_package}";

		"extract_mvn":
			path   	=> ["/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"],
			unless	=> "test -d /opt/${maven_dir}",
			cwd	=> "/opt/",
			command	=> "tar xvfz ${maven_package}",
			require	=> Exec["download_mvn"];
	}

	file { "/opt/mvn":
		ensure  => link,
		target  => "/opt/${maven_dir}",
		require	=> Exec["extract_mvn"];
	}
}
