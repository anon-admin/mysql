class mysql::service ($mysql_user = $mysql::mysql_user) inherits mysql {
  contain mysql::config

  Service["mysql"] {
    ensure  => running,
    enable  => true,
    require => [File["/etc/mysql/my.cnf"], Mount["/etc/mysql", "/var/log/mysql", "/var/lib/mysql"], User["${mysql_user}"]],
    alias   => "mysql-server",
  }

  contain mysql::monit
  Service["mysql"] -> File["/etc/monit/conf.d/mysql"]
  
  include mysql::logrotate

}