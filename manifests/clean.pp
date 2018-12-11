class mysql::clean inherits mysql {
  tidy { ["/usr/tidy/usr/lib/mysql", "/usr/tidy/etc/mysql", "/usr/tidy/var/log/mysql", "/usr/tidy/var/lib/mysql"]:
    recurse => true,
    backup  => false,
    age     => "4w",
    require => Mount["/usr/tidy"],
  }

  Mount["/etc/mysql"] -> Tidy["/usr/tidy/etc/mysql"]
  Mount["/var/log/mysql"] -> Tidy["/usr/tidy/var/log/mysql"]
  Mount["/var/lib/mysql"] -> Tidy["/usr/tidy/var/lib/mysql"]
}
