class mysql::no inherits mysql {
  Package["mysql-server-5.5"] {
    ensure => purged,
  }
  
  File["/etc/mysql/my.cnf"] {
    ensure => absent,
  }
  
  File ["/etc/mysql","/var/log/mysql", "/var/lib/mysql"] {
    ensure => absent,
    recurse => true,
  }
  
  Service["mysql"] {
    enable => false,
    ensure => stopped,
  }
}



