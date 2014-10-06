describe 'tmux::_libevent' do
  let(:libevent_tarball) { "#{Chef::Config['file_cache_path']}/libevent-2.0.21-stable.tar.gz" }
  let(:chef_run) { ChefSpec::Runner.new(platform: 'centos', version: '6.5') }

  context 'when installing tmux on a RHEL family system' do
    context 'when libevent install_method is package' do

      it 'installs the libevent package' do
        chef_run.node.set['tmux']['libevent']['install_method'] = 'package'
        chef_run.converge(described_recipe)
        expect(chef_run).to install_package('libevent-devel')
      end
    end

    context 'when libevent install_method is source' do

      it 'downloads the libevent tarball' do
        chef_run.node.set['tmux']['libevent']['install_method'] = 'source'
        chef_run.converge(described_recipe)
        expect(chef_run).to create_remote_file(libevent_tarball)
      end

      it 'notifies bash to untar and install libevent' do
        chef_run.converge(described_recipe)
        libevent_download = chef_run.remote_file(libevent_tarball)
        expect(libevent_download).to notify('bash[install_libevent]').to(:run).immediately
      end

    end
  end
end
