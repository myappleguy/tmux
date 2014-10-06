#
# Cookbook Name:: tmux
# Recipe:: source
# Author:: Seth Vargo <sethvargo@gmail.com>
#
# Copyright 2011-2013 CustomInk, LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# if centos/RHEL 7 then install libevent-devel 2.0 package

# install prerequisite packages
# install libevent
#

FILE_CACHE = Chef::Config['file_cache_path']

packages = value_for_platform_family(
  %w(rhel fedora) => %w(ncurses-devel gcc make),
  'debian' => %w(libncurses5-dev gcc make)
)

packages.each do |name|
  package name
end

include_recipe "#{cookbook_name}::_libevent"

tar_name = "tmux-#{node['tmux']['version']}"

remote_file "#{FILE_CACHE}/#{tar_name}.tar.gz" do
  source node['tmux']['source_url']
  checksum node['tmux']['checksum']
  notifies :run, 'bash[install_tmux]', :immediately
end

bash 'install_tmux' do
  user 'root'
  cwd  FILE_CACHE
  code <<-EOH
      tar -zxf #{tar_name}.tar.gz
      cd #{tar_name}
      ./configure #{node['tmux']['configure_options'].join(' ')}
      make
      make install
  EOH
  action :nothing
end
