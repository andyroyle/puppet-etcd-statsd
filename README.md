# puppet-etcd_statsd

[![Build Status](https://travis-ci.org/andyroyle/puppet-etcd-statsd.png)](https://travis-ci.org/andyroyle/puppet-etcd-statsd) [![Puppet Forge](http://img.shields.io/puppetforge/v/andyroyle/etcd_statsd.svg?style=flat)](https://forge.puppetlabs.com/andyroyle/etcd_statsd)

## Description

This Puppet module will install [etcd-statsd](https://github.com/andyroyle/puppet-etcd-statsd/) on Debian or RedHat.

## Installation

`puppet module install --modulepath /path/to/puppet/modules andyroyle-etcd_statsd`

## Requirements

This module assumes nodejs & npm is installed on the host, but will not do it for you. I recommend using [puppet/nodejs](https://github.com/puppet-community/puppet-nodejs) to set this up.

## Usage
```puppet
    class { 'etcd_statsd':
      servers => [
        {
          endpoint => 'http://my.servicebus.instance.com',
          key      => 'accesskey',
          keyname  => 'RootManageSharedAccessKey',
          queues   => true,                 # log stats for queues
          topics   => true,                 # log stats for topics (and subscriptions)
          tags     => {                     # tags are only supported by influxdb backend
            foo => 'bar'
          },
          prefix   => 'bar.etcd.yay' # prefix to apply to the metric name
        }
      ],
      statsd => {
        host     => 'localhost',
        port     => 8125,
        interval => 10, # interval in seconds to send metrics,
        prefix   => 'foo', # global prefix to apply to all metrics,
        debug    => true # print out metrics that are logged (default false)
      }
    }
```

## Testing

```
bundle install
bundle exec librarian-puppet install
vagrant up
```

## Custom Nodejs Environment

Use the `$environment` parameter to add custom environment variables or run scripts in the `/etc/default/etcd-statsd` file:

```
class { 'etcd-statsd':
  # ...
  environment  => [
    'PATH=/opt/my/path:$PATH',
  ]
}
```

## This looks familiar
Module structure largely copy-pasted from [puppet-statsd](https://github.com/justindowning/puppet-statsd)
