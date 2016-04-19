# == Class: etcd_statsd::config
class etcd_statsd::config (
  $servers                           = $etcd_statsd::servers,
  $statsd                            = $etcd_statsd::statsd,
  $configdir                         = $etcd_statsd::configdir,
  $config                            = $etcd_statsd::config,

  $environment = $etcd_statsd::environment,
  $nodejs_bin  = $etcd_statsd::nodejs_bin,
  $etcdjs     = "${etcd_statsd::node_module_dir}/etcd-statsd/etcd.js",
  $logfile     = $etcd_statsd::logfile,
) {

  file { $configdir:
    ensure => directory,
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
  }->
  file { "${configdir}/etcd.json":
    content => template('etcd_statsd/etcd.json.erb'),
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
  }->
  file { "${configdir}/statsd.json":
    content => template('etcd_statsd/statsd.json.erb'),
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
  }

  file { $etcd_statsd::init_location:
    source => $etcd_statsd::init_script,
    mode   => $etcd_statsd::init_mode,
    owner  => 'root',
    group  => 'root',
  }

  file {  '/etc/default/etcd-statsd':
    content => template('etcd_statsd/etcd-defaults.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }

  file { '/var/log/etcd-statsd':
    ensure => directory,
    mode   => '0755',
    owner  => 'nobody',
    group  => 'root',
  }

  file { '/usr/local/sbin/etcd-statsd':
    source => 'puppet:///modules/etcd_statsd/etcd-wrapper',
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
  }

}
