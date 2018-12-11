class mysql::config inherits mysql {

  include storage
  if $storage::mysql {
    contain mysql::mounts
  }
  
  include mysql::user::definition


  File[
    "/etc/mysql", "/var/log/mysql", "/var/lib/mysql"] {
    ensure => directory,
    group  => "${mysql_user}",
    mode   => "g+w",
  }

  File["/etc/mysql","/var/lib/mysql"] {
    require => Group["${mysql_user}"], }

  File["/var/log/mysql"] {
    require => [Group["${mysql_user}"], Mount["/var/log"]], }



  Package["mysql-server-5.5"] {
    ensure => latest,
    require => File["/etc/apt/sources.list"], 
  }
    
  File["/etc/mysql/my.cnf"] {
    notify => Service["mysql"],
    #content => template("mysql/my.cnf.erb"),
  }
  

}
