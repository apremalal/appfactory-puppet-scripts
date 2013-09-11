class apache {
	package { 
		"apache2": ensure => installed;
	}

	service { "apache2":
		enable => true,
		ensure => running,
	} 

	exec {"apache2 reload": 
		command => "/etc/init.d/apache2 reload",
		refreshonly => true
	}
}
