class redmine (){


	define install_packages(){
		package {
			"python-software-properties":
			ensure	=> installed;
		}

		exec {"Add redmine repository":
			path 	=> "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games",
			command => "add-apt-repository ppa:ondrej/redmine",
			require => Package["python-software-properties"];

			"update-apt":
			path    => ['/bin', '/usr/bin'],
			command => "apt-get update > /dev/null 2>&1 &",
			require	=> Exec["Add redmine repository"];
		}

		package { 
			"libapache2-mod-passenger": 	
			ensure 		=> installed;

			"redmine": 
			ensure 		=> installed;

			"redmine-mysql": 
			ensure 		=> installed,
			require		=> Exec["Add redmine repository"];
		}
	}

	define configure_passenger() {

		exec {"enable passenger & ssl module":
			command 	=> "/usr/sbin/a2enmod passenger ssl",
			notify  	=> Service['apache2'];
		}

		file {
			"/etc/apache2/mods-available/passenger.conf":
			source		=> "puppet:///redmine/passenger.conf",
		}

		exec {"apache2_reload_passenger_enable": 
			command 	=> "/etc/init.d/apache2 reload",
			refreshonly	=> true;
		}
	}



	define configure_redmine() {

		file {
			"/var/www/redmine":
			ensure		=> link,
			target 		=> "/usr/share/redmine/public",
			require 	=> [
						Package['apache2'],
						Package['redmine'],
					   ],
			notify  	=> Service['apache2'];
		}

	}
	
	define configure_apache() {
		file {
			"/etc/apache2/ssl":
			recurse		=> true,
			ignore		=> ".svn",
			source		=> "puppet:///ssl",
			require 	=> Package['apache2'];
			
			"/etc/apache2/sites-enabled/https.redmine":
			content		=> template("redmine/https.redmine.erb");
			
			"/var/log/apache2/https.redmine":
			ensure		=> directory;
		}
	}

	define configure_redminedb() {
		file {
			"/etc/redmine/default/database.yml":
			content		=> template("redmine/database.yml.erb");
		}	
	}
	
	define start_redmine() {

		exec {
			"apache2_reload_apply_configs": 
			command 	=> "/etc/init.d/apache2 reload",
			refreshonly	=> true;

			"generate_secret_token_${name}":
	              	path            => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
			cwd		=> "/var/www/redmine",
	              	command         => "/usr/bin/rake generate_secret_token" ; 

			"production_db_configuration_${name}":
	              	path            => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
			cwd		=> "/var/www/redmine",
	              	command         => "/usr/bin/rake db:migrate RAILS_ENV=\"production\"";

			"production_db_load_defualtdata_${name}":
	              	path            => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
			cwd		=> "/var/www/redmine",
	              	command         => "/usr/bin/rake redmine:load_default_data RAILS_ENV=\"production\" REDMINE_LANG=\"en\"";
	
			"restart apache2":
			command		=> "/etc/init.d/apache2 restart";
		}
		
	}
	
	install_packages{
		"Installing_Packages":
	}
	configure_passenger{
		"Configure_Passenger":
		require		=> Install_packages["Installing_Packages"];	
	}
	configure_redmine{
		"Configure_Redmine":
		require		=> Configure_passenger["Configure_Passenger"];	
	}
	configure_apache{
		"Configure_Apache":
		require		=> Configure_redmine["Configure_Redmine"];	
	}
	configure_redminedb{
		"Configure_Redminedb":
		require		=> Configure_apache["Configure_Apache"];	
	}
	start_redmine{
		"Start_Redmine":
		require		=> Configure_redminedb["Configure_Redminedb"];
	}
}


