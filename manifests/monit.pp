class mysql::monit inherits monit::minimal::config {

  monit::fullfill_service{ "mysql": 
    module => "mysql",
  }
  
}