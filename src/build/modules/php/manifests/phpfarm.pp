class php::phpfarm {
  file { '/tmp/phpfarm-master.zip':
    ensure => present,
    source => 'puppet:///modules/php/tmp/phpfarm-master.zip'
  }

  bash_exec { 'cd /tmp && unzip phpfarm-master.zip':
    require => File['/tmp/phpfarm-master.zip']
  }

  bash_exec { 'cd /tmp && mv phpfarm-master /phpfarm':
    require => Bash_exec['unzip phpfarm-master.zip']
  }

  file { '/phpfarm/custom':
    ensure => directory,
    require => Bash_exec['mv phpfarm-master /phpfarm']
  }

  file { '/etc/profile.d/phpfarm.sh':
    ensure => present,
    source => 'puppet:///modules/php/etc/profile.d/phpfarm.sh',
    mode => 755
  }
}
