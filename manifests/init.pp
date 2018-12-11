# Class: mysql
#
# This module manages mysql
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class mysql inherits mysql::install {
  include userids

  $mysql_user = $userids::mysql_user
  $mysql_id = $userids::mysql_id

  $mysql_lvname = 'mysql'
  $mysql_vgname = 'DATA'
  $mysql_lvsize = '1G'
  $mysql_lvfs = 'ext4'

  $mysql_mountpoint = "/usr/lib/mysql"

  file { ["/etc/mysql", "/var/log/mysql", "/var/lib/mysql"]: }

  file { "/etc/mysql/my.cnf":
    owner => root,
    group => root,
    mode  => 444,
  }

  service { "mysql": }
}

