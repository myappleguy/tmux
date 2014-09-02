describe 'tmux::default' do
  context 'when the installation method is source' do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set['tmux']['install_method'] = 'source'
      end.converge(described_recipe)
    end

    it 'includes the source recipe' do
      expect(chef_run).to include_recipe('tmux::_source')
    end

    it 'does not include the package recipe' do
      expect(chef_run).to_not include_recipe('tmux::_package')
    end
  end

  context 'when the installation method is package' do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set['tmux']['install_method'] = 'package'
      end.converge(described_recipe)
    end

    it 'includes the package recipe' do
      expect(chef_run).to include_recipe('tmux::_package')
    end

    it 'does not include the source recipe' do
      expect(chef_run).to_not include_recipe('tmux::_source')
    end
  end

  context 'on RHEL' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'redhat', version: '6.5').converge(described_recipe) }

    it 'sets the installation method to `source`'  do
      expect(chef_run.node['tmux']['install_method']).to eq('source')
    end
  end

  context 'on debian' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04').converge(described_recipe) }

    it 'sets the installation method to `package`'  do
      expect(chef_run.node['tmux']['install_method']).to eq('package')
    end
  end

  context 'when the installation method is set to something invalid' do

    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set['tmux']['install_method'] = 'not_real'
      end.converge(described_recipe)
    end

    it 'raises an error' do
      expect { chef_run }.to raise_error(Chef::Exceptions::RecipeNotFound)
    end
  end

  context 'usual business' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04').converge(described_recipe) }

    it 'creates the tmux conf' do
      expect(chef_run).to create_template('/etc/tmux.conf')
    end

    it 'writes the correct content' do
      template = chef_run.template('/etc/tmux.conf')
      expect(template.owner).to eq('root')
      expect(template.group).to eq('root')
      expect(template.mode).to eq('0644')
    end
  end
end
