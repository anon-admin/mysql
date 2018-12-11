class mysql::create_lvm($vgname = "DATA") inherits storage {

  if $storage::mysql {
    include mysql

    $mysql_lvname = $mysql::mysql_lvname
    $mysql_lvsize = $mysql::mysql_lvsize
    $mysql_lvfs = $mysql::mysql_lvfs
    $mysql_mountpoint = $mysql::mysql_mountpoint

    storage::lvm::createlv { "${mysql_lvname}":
      vgname     => $vgname,
      size       => "${mysql_lvsize}",
      fstype     => "${mysql_lvfs}",
      mountpoint => "${$mysql_mountpoint}"
    }

    include mysql::clean
  }

}
