describe 'tmux::_source' do

  let(:tmux_tarball) { "#{Chef::Config['file_cache_path']}/tmux-1.9a.tar.gz" }

  let(:chef_run) { ChefSpec::Runner.new(platform: 'centos', version: '6.5').converge(described_recipe) }

  context 'when installing tmux on a RHEL family system' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'centos', version: '6.5') }

    it 'installs packages required for tmux to compile' do
      chef_run.node.set['tmux']['libevent']['install_method'] = :package
      chef_run.converge(described_recipe)
      expect(chef_run).to install_package('ncurses-devel')
    end

    it 'includes the _libevent recipe' do
      chef_run.node.set['tmux']['libevent']['install_method'] = :package
      chef_run.converge(described_recipe)
      expect(chef_run).to include_recipe('tmux::_libevent')
    end
  end

  context 'when installing tmux on a Debian family system' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'ubuntu', version: '14.04') }

    it 'installs packages required for tmux to install' do
      chef_run.node.set['tmux']['libevent']['install_method'] = :package
      chef_run.converge(described_recipe)
      expect(chef_run).to install_package('libncurses5-dev')
    end
  end

  it 'downloads the tmux tarball' do
    expect(chef_run).to create_remote_file(tmux_tarball)
  end

  it 'notifies the bash script to untar and install tmux' do
    tmux_download = chef_run.remote_file(tmux_tarball)
    expect(tmux_download).to notify('bash[install_tmux]').to(:run).immediately
  end

end
