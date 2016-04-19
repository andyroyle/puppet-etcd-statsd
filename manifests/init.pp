# == Class etcd_statsd
class etcd_statsd (
  $ensure           = $etcd_statsd::params::ensure,
  $node_module_dir  = $etcd_statsd::params::node_module_dir,
  $nodejs_bin       = $etcd_statsd::params::nodejs_bin,
  $environment      = $etcd_statsd::params::environment,

  $servers          = $etcd_statsd::params::servers,
  $statsd           = $etcd_statsd::params::statsd,
  $configdir        = $etcd_statsd::params::configdir,
  $logfile          = $etcd_statsd::params::logfile,

  $manage_service   = $etcd_statsd::params::manage_service,
  $service_ensure   = $etcd_statsd::params::service_ensure,
  $service_enable   = $etcd_statsd::params::service_enable,

  $config           = $etcd_statsd::params::config,

  $init_location    = $etcd_statsd::params::init_location,
  $init_mode        = $etcd_statsd::params::init_mode,
  $init_provider    = $etcd_statsd::params::init_provider,
  $init_script      = $etcd_statsd::params::init_script,

  $package_name     = $etcd_statsd::params::package_name,
  $package_source   = $etcd_statsd::params::package_source,
  $package_provider = $etcd_statsd::params::package_provider,

  $dependencies     = $etcd_statsd::params::dependencies,
) inherits etcd_statsd::params {

  if $dependencies {
    $dependencies -> Class['etcd_statsd']
  }

  class { 'etcd_statsd::config': }

  package { 'etcd_statsd':
    ensure   => $ensure,
    name     => $package_name,
    provider => $package_provider,
    source   => $package_source
  }

  if $manage_service == true {
    service { 'etcd-statsd':
      ensure    => $service_ensure,
      enable    => $service_enable,
      hasstatus => true,
      provider  => $init_provider,
      subscribe => Class['etcd_statsd::config'],
      require   => [
        Package['etcd_statsd'],
        File['/var/log/etcd-statsd']
      ],
    }
  }
}
