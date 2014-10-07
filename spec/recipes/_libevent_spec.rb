describe 'tmux::_libevent' do
  let(:libevent_tarball) { "#{Chef::Config['file_cache_path']}/libevent-2.0.21-stable.tar.gz" }

  context 'when libevent install_method is package' do
    context 'on a RHEL family system' do
      let(:chef_run) { ChefSpec::Runner.new(platform: 'centos', version: '6.5') }

      it 'installs the libevent package' do
        chef_run.node.set['tmux']['libevent']['install_method'] = 'package'
        chef_run.converge(described_recipe)
        expect(chef_run).to install_package('libevent-devel')
      end
    end

    context 'on a Debian family system' do

      let(:chef_run) { ChefSpec::Runner.new(platform: 'ubuntu', version: '14.04') }

      it 'installs the libevent-dev package' do
        chef_run.converge(described_recipe)
        expect(chef_run).to install_package('libevent-dev')
      end
    end
  end

  context 'when libevent install_method is source' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'centos', version: '6.5').converge(described_recipe) }

    it 'downloads the libevent tarball' do
      chef_run.node.set['tmux']['libevent']['install_method'] = 'source'
      expect(chef_run).to create_remote_file(libevent_tarball)
    end

    it 'notifies bash to untar and install libevent' do
      libevent_download = chef_run.remote_file(libevent_tarball)
      expect(libevent_download).to notify('bash[install_libevent]').to(:run).immediately
    end

    it 'bash install_libevent only installs when notified' do
      install_libevent = chef_run.bash('install_libevent')
      expect(install_libevent).to do_nothing
    end
  end
end
