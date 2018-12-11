class mysql::install {

  include apt_source_list
  
  package { "mysql-server-5.5":
  }
  
  
}
