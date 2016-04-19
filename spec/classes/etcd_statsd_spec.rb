require 'spec_helper'

describe 'etcd_statsd', :type => :class do

  ['Debian', 'RedHat'].each do |osfamily|
    context "using #{osfamily}" do
      let(:facts) { {
        :osfamily => osfamily
      } }

      it { should contain_class('etcd_statsd') }
      it { should contain_class('etcd_statsd::params') }
      it { should contain_etcd_statsd__config }
      it { should contain_package('etcd_statsd').with_ensure('present') }
      it { should contain_service('etcd-statsd').with_ensure('running') }
      it { should contain_service('etcd-statsd').with_enable(true) }

      it { should contain_file('/etc/etcd-statsd') }
      it { should contain_file('/etc/etcd-statsd/etcd.json') }
      it { should contain_file('/etc/etcd-statsd/statsd.json') }
      it { should contain_file('/etc/default/etcd-statsd') }
      it { should contain_file('/var/log/etcd-statsd') }
      it { should contain_file('/usr/local/sbin/etcd-statsd') }

      if osfamily == 'Debian'
        it { should contain_file('/etc/init/etcd-statsd.conf') }
      end

      if osfamily == 'RedHat'
        it { should contain_file('/etc/init.d/etcd-statsd') }
      end

      describe 'stopping the statsd service' do
	let(:params) {{
	  :service_ensure => 'stopped',
        }}
        it { should contain_service('etcd-statsd').with_ensure('stopped') }
      end

      describe 'disabling the statsd service' do
	let(:params) {{
	  :service_enable => false,
        }}
        it { should contain_service('etcd-statsd').with_enable(false) }
      end

      describe 'disabling the management of the statsd service' do
	let(:params) {{
	  :manage_service => false,
        }}
        it { should_not contain_service('etcd-statsd') }
      end
     end
  end

end
