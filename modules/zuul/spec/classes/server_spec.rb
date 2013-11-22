require 'spec_helper'

describe 'ntp::server' do
  context 'on Ubuntu 12.04 (Precise)' do
    let(:facts) { { 
      :lsbdistcodename  => 'precise',
      :lsbdistrelease   => '12.04',
      :operatingsystem  => 'Ubuntu',
    } }

    it do
      should contain_file('/etc/ntp.conf').with({
        'ensure'  => 'file',
        'group'   => 'root',
        'mode'    => '0644',
        'owner'   => 'root',
      })
    end

    it do
      should contain_file('/etc/default/ntp').with({
        'ensure'  => 'file',
        'group'   => 'root',
        'mode'    => '0644',
        'owner'   => 'root',
      })
    end

    it do
      should contain_package('ntp').with_ensure('present')
    end

    it do
      should contain_service('ntp').with({
        'ensure'      => 'running',
        'enable'      => true,
        'hasstatus'   => true,
        'hasrestart'  => true,
      })
    end
  end
end

# vim:sw=2:ts=2:expandtab:textwidth=79
