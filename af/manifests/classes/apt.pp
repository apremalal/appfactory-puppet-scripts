class apt {
	$packages = ["lsof","unzip","sysstat","telnet", "git", "less"]

        file { "/etc/apt/apt.conf.d/90forceyes":
                ensure  => present,
                source  => "puppet:///apt/90forceyes";
        }

        package { $packages:
                provider        => apt,
                ensure          => installed,
                require         => File["/etc/apt/apt.conf.d/90forceyes"],
        }	
}
