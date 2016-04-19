case $operatingsystem {
  /^(Debian|Ubuntu)$/: { include apt }
  'RedHat', 'CentOS':  { include epel }
  default: { notify { 'unsupported os!': }}
}

class { 'nodejs': manage_package_repo => true, repo_url_suffix => '5.x', }->
class { 'etcd_statsd':
  servers => [
    {
      host => 'http://localhost:2379/',
      prefix   => 'bar.servicebus.yay',
      tags     => {
        foo => 'bar'
      }
    }
  ],
  statsd  => {
    host     => 'localhost',
    port     => 8125,
    interval => 10,
    prefix   => 'foo'
  }
}
