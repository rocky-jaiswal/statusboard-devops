class rockyj::tbox {

  package { "openjdk-7-jdk": 
    ensure => latest,
    before => Exec['install_torquebox']
  }

  class { 'torquebox':
    version         => '3.0.0',
    add_to_path     => true,
  }

}