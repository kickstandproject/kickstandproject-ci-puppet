require 'spec_helper'

describe 'jenkins-01-prod.kickstand-project.org', :type => :host do
  context 'on Ubuntu 12.04 (Precise)' do
    let(:facts) { { 
      :lsbdistcodename  => 'precise',
      :lsbdistrelease   => '12.04',
      :operatingsystem  => 'Ubuntu',
    } }
    it { should include_class('jenkins::server') }
  end
end

# vim:sw=2:ts=2:expandtab
