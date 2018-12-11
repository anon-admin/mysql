class mysql::mounts (
  $mysql_user       = $mysql::mysql_user,
  $mysql_lvname     = $mysql::mysql_lvname,
  $mysql_vgname     = $mysql::mysql_vgname,
  $mysql_lvfs       = $mysql::mysql_lvfs,
  $mysql_mountpoint = $mysql::mysql_mountpoint) inherits mysql {
    
    include mysql::create_lvm
    
  file { "${mysql_mountpoint}": ensure => directory, }

  mount { "${mysql_mountpoint}":
    device  => "LABEL=${mysql_vgname}-${mysql_lvname}",
    fstype  => "${mysql_lvfs}",
    options => "defaults",
    pass    => 2,
    atboot  => true,
    ensure  => mounted,
    require => File["${mysql_mountpoint}"],
  }

  file { ["${mysql_mountpoint}/config", "${mysql_mountpoint}/log", "${mysql_mountpoint}/databases"]:
    ensure  => directory,
    require => Mount["${mysql_mountpoint}"],
  }

  file { "${mysql_mountpoint}/etc":
    ensure => link,
    target => "${mysql_mountpoint}/config",
  }

  mount { "/etc/mysql":
    device  => "${mysql_mountpoint}/config",
    require => [File["/etc/mysql", "${mysql_mountpoint}/config"], Mount["${mysql_mountpoint}"]],
  }

  mount { "/var/log/mysql":
    device  => "${mysql_mountpoint}/log",
    require => [File["/var/log/mysql", "${mysql_mountpoint}/log"], Mount["${mysql_mountpoint}"]],
  }

  mount { "/var/lib/mysql":
    device  => "${mysql_mountpoint}/databases",
    require => [File["/var/lib/mysql", "${mysql_mountpoint}/databases"], Mount["${mysql_mountpoint}"]],
  }

  Mount[
    "/etc/mysql", "/var/log/mysql", "/var/lib/mysql"] {
    fstype  => none,
    options => "bind,rw",
    before  => Package["mysql-server-5.5"],
    atboot  => true,
    ensure  => mounted,
  }

  contain mysql::clean
}
