describe 'tmux::_source' do

  context 'when installing tmux on a RHEL family system' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'centos', version: '6.5') }

    it 'installs packages required for tmux to compile' do
      chef_run.node.set['tmux']['libevent']['install_method'] = :package
      chef_run.converge(described_recipe)
      expect(chef_run).to install_package('ncurses-devel')
    end

  end

  context 'when installing tmux on a Debian family system' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'ubuntu', version: '14.04') }

    it 'installs packages required for tmux to compile' do
      chef_run.node.set['tmux']['libevent']['install_method'] = :package
      chef_run.converge(described_recipe)
      expect(chef_run).to install_package('libncurses5-dev')
    end
  end


end
