class mysql::user::definition ($mysql_user = $mysql::mysql_user, $mysql_id = $mysql::mysql_id) inherits mysql {
  exec { [
    "/usr/local/bin/gidmod.sh ${mysql_id} ${mysql_user}",
    "/usr/local/bin/uidmod.sh ${mysql_id} ${mysql_user}"]: require => Mount["/usr/local/bin"], }

  group { "${mysql_user}":
    ensure  => present,
    gid     => "${mysql_id}",
    require => Exec["/usr/local/bin/gidmod.sh ${mysql_id} ${mysql_user}"],
    before  => Package["mysql-server-5.5"],
  }

  user { "${mysql_user}":
    ensure  => present,
    uid     => "${mysql_id}",
    gid     => "${mysql_user}",
    require => [Exec["/usr/local/bin/uidmod.sh ${mysql_id} ${mysql_user}"], Group["${mysql_user}"]],
    before  => [Package["mysql-server-5.5"], Service["mysql"]],
  }

}
