require 'spec_helper'

describe 'grafana::_install_package' do
  platforms = {
    'debian' => {
      'versions' => ['7.11']
    },
    'ubuntu' => {
      'versions' => ['14.04', '16.04']
    },
    'centos' => {
      'versions' => ['6.8']
    }
  }

  platforms.each do |platform, value|
    value['versions'].each do |version|
      before do
        stub_command('which nginx').and_return('1')
      end
      context "on #{platform} #{version}" do
        let(:chef_run) do
          ChefSpec::SoloRunner.new(platform: platform, version: version) do |node|
            node.normal['grafana']['install_type'] = 'package'
          end.converge 'grafana::default'
        end

        it 'loads grafana::_install_package recipe' do
          expect(chef_run).to include_recipe 'grafana::_install_package'
        end
        it 'installs grafana package' do
          if platform == 'centos'
            expect(chef_run).to create_yum_repository('grafana')
          else
            expect(chef_run).to install_package('apt-transport-https')
            expect(chef_run).to add_apt_repository('grafana')
          end
        end
        it 'installs grafana package' do
          expect(chef_run).to install_package 'grafana'
        end
      end
      context "on #{platform} #{version} with grafana version older than 2.0.2" do
        let(:chef_run) do
          ChefSpec::SoloRunner.new(platform: platform, version: version) do |node|
            node.normal['grafana']['install_type'] = 'package'
            node.normal['grafana']['file']['version'] = '5.0.4'
          end.converge 'grafana::default'
        end

        it 'installs grafana package' do
          expect(chef_run).to install_package 'grafana'
        end
      end
    end
  end
end
