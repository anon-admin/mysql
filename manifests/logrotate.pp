class mysql::logrotate {

  rsyslog::fullfill_service{ "mysql-server": module => "mysql", } 
}