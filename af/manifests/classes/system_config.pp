class system_config {

	include hosts
	include apt
  include java

	user { "wso2": 
  	ensure     => present,                            
 	 	managehome => true,
	}

	file {  "/root/bin":
    owner   => root,
    group   => root,
    ensure  => "directory";

		'/root/bin/puppet_clean.sh':
      owner   => root,
      group   => root,
      mode    => '0755',
      content => template("puppet_clean.sh.erb");

		'/root/bin/puppet_init.sh':
      owner   => root,
      group   => root,
      mode    => 0755,
      content => template("puppet_init.sh.erb"),
      require => File["/root/bin/puppet_clean.sh"];

		
		'/etc/environment':
			source	=> "puppet:///commons/environment";
  }

    Exec {  path    => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/java/bin/"  }
}
