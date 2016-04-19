# == Class: etcd_statsd::params
class etcd_statsd::params {
  $ensure           = 'present'
  $node_module_dir  = '/usr/lib/node_modules'
  $nodejs_bin       = '/usr/bin/node'
  $environment      = []

  $servers          = []
  $statsd           = { }
  $configdir        = '/etc/etcd-statsd'
  $logfile          = '/var/log/etcd-statsd/etcd-statsd.log'

  $manage_service   = true
  $service_ensure   = 'running'
  $service_enable   = true

  $config           = { }

  $dependencies     = undef

  $package_name     = 'etcd-statsd'
  $package_source   = undef
  $package_provider = 'npm'

  case $::osfamily {
    'RedHat', 'Amazon': {
      $init_location = '/etc/init.d/etcd-statsd'
      $init_mode     = '0755'
      $init_provider = 'redhat'
      $init_script   = 'puppet:///modules/etcd_statsd/etcd-init-rhel'
    }
    'Debian': {
      $init_location = '/etc/init/etcd-statsd.conf'
      $init_mode     = '0644'
      $init_provider = 'upstart'
      $init_script   = 'puppet:///modules/etcd_statsd/etcd-upstart'
    }
    default: {
      fail('Unsupported OS Family')
    }
  }
}
