class java { 

	$java_home 	= "jdk1.7.0_07"
	$package 	  = "jdk-7u7-linux-x64.tar.gz"
  $java_dir  = '/opt'
  
  exec {
    "downloading_${package}":
      path      => ["/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"],
      cwd       => $java_dir,
      unless    => "test -f ${java_dir}/${package}",
      command   => "wget -q ${package_repo}/software/${package}";
  }

	file {
#	  "/opt/java/jre/lib/security/":
#      owner   => root,
#      group   => root,
#      source  => ["puppet:///java/jars/"],
#		  ignore	=> ".svn",
#      ensure  => present,
#      recurse => true,
#      require => Exec["downloading_${package}"];

		"/opt/java":
      ensure 	=> link,
      target	=> "/opt/${java_home}",
      require	=> Exec["install_java"],
	}
    
	exec { 
    "install_java":
      cwd	      => "/opt",
      command   => "tar xzf ${package}",
      unless    => "/usr/bin/test -d /opt/${java_home}",
      creates   => "/opt/${java_home}/COPYRIGHT",
      require   => Exec["downloading_${package}"];

    "changing_permissions":
      path      => ["/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"],
      cwd	      => "/opt",
      command   => "chown -R root:root ${java_dir}/${java_home}; chmod -R 755 ${java_dir}/${java_home}",
      require   => Exec["install_java"];
	} 

}
 
