class rockyj::nginx {
  
  include stdlib
  include apt

  apt::ppa { "ppa:nginx/stable": 
    before  => Package["nginx"],
  }

  package { "python-software-properties": 
    ensure => latest 
  }

  package { "nginx": 
    ensure => latest,
    require => Package["python-software-properties"]
  }

  service { "nginx": 
    ensure => running,
    require => Package["nginx"]
  }

  file { "logfile1":
    path    => "/var/log/nginx/statusboard.access.log",
    ensure  => present,
    mode    => 0644,
  }

  file { "unwanted-default":
    path    => "/etc/nginx/sites-enabled/default",
    ensure  => absent,
    require => Package["nginx"]
  }

  file { "ssldir":
    path    => "/etc/nginx/ssl",
    ensure  =>  directory,
    recurse => true,
    require => Package["nginx"]
  }

  file { "statusboard-avaliable":
    path    => "/etc/nginx/sites-available/statusboard",
    ensure  => present,
    mode    => 0644,
    source  => "puppet:///modules/rockyj/static/statusboard",
    require => File["logfile1", "unwanted-default"],
    notify  => Service["nginx"],
  }

  file { "statusboard-enabled":
    path    => "/etc/nginx/sites-enabled/statusboard",
    ensure  => link,
    mode    => 0644,
    target  => "/etc/nginx/sites-available/statusboard",
    require => File["statusboard-avaliable"],
  }

}