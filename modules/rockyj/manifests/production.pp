class rockyj::production {

  include rockyj::nginx
  include rockyj::node
  include rockyj::tbox
  include ufw

  Exec {
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
  }

  ufw::allow { "allow-ssh-from-all":
    port => 22,
  }

  ufw::allow { "allow-http-from-all":
    port => 80,
  }

  ufw::allow { "allow-https-from-all":
    port => 443,
  }

  file { "statusboard":
    path    => "/opt/torquebox/statusboard",
    ensure  =>  directory,
    owner   => "torquebox",
    group   => "torquebox",
    recurse => true,
    require => User['torquebox']
  }

  file { "initscript":
    path    => "/etc/init/torquebox.conf",
    ensure  => present,
    mode    => 0644,
    source  => "puppet:///modules/rockyj/static/init_s2",
    require => User['torquebox']
  }

}
