if node['tmux']['libevent']['install_method'] == 'package'
  package node['tmux']['libevent']['package']
else

  LIBEVENT_TAR_NAME = node['tmux']['libevent']['tar_name']

  remote_file "#{Chef::Config['file_cache_path']}/#{LIBEVENT_TAR_NAME}.tar.gz" do
    source node['tmux']['libevent']['source_url']
    checksum node['tmux']['libevent']['checksum']
    notifies :run, 'bash[install_libevent]', :immediately
  end

  bash 'install_libevent' do
    cwd  Chef::Config['file_cache_path']
    code <<-EOH
      tar -zxf #{LIBEVENT_TAR_NAME}.tar.gz
      cd #{LIBEVENT_TAR_NAME}
      make
      make install
    EOH
    action :nothing
  end
end
