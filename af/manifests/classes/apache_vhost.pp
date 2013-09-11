class apache_vhost(
        $port,
        $template      = 'apache/vhost-redirect.conf.erb',
        $servername    = '',
        $vhost_name    = '*'
      ) {

      include apache
    
      $vdir   = '/etc/apache2/sites-enabled'
      $logdir = '/var/log/apache2'
      
      
      if $servername == '' {
        $srvname = $title
      } else {
        $srvname = $servername
      }

      exec {
	"remove existing default vhost":
	   command         => "/usr/sbin/a2dissite 000-default",
	   notify          => Service['apache2'],
           require 	   => Package['apache2'];

      }

      file {
        "${vdir}/${servername}.conf":
          content => template($template),
          owner   => 'root',
          group   => 'root',
          mode    => '755',
          require => Package['apache2'],
          notify  => Service['apache2'],
      }
    
}
