#
# Cookbook Name:: tmux
# Attribute:: default
#
# Copyright 2010-2013, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
#

extend Tmux::Helper

default['tmux']['install_method'] = value_for_platform_family(
  'rhel' => 'source',
  'default' => 'package'
)

default['tmux']['version'] = '1.9a'
default['tmux']['source_url'] = "http://downloads.sourceforge.net/tmux/tmux-#{node['tmux']['version']}.tar.gz"

# use default checksum for tmux 1.9a
default['tmux']['checksum'] = 'c5e3b22b901cf109b20dab54a4a651f0471abd1f79f6039d79b250d21c2733f5'

# use the helper method defined in this cookbook's libraries/helper
default['tmux']['libevent']['install_method'] = libevent_install_method
default['tmux']['libevent']['package'] = value_for_platform_family(
  'rhel' => 'libevent-devel',
  'debian' => 'libevent-dev'
)

libevent_tar_name = 'libevent-2.0.21-stable'
default['tmux']['libevent']['tar_name'] = libevent_tar_name
default['tmux']['libevent']['source_url'] = "https://github.com/downloads/libevent/libevent/#{libevent_tar_name}.tar.gz"
# use default checksum for libevent-2.0.21-stable
default['tmux']['libevent']['checksum'] = '22a530a8a5ba1cb9c080cba033206b17dacd21437762155c6d30ee6469f574f5'

default['tmux']['configure_options'] = []

default['tmux']['server_opts']['escape-time'] = 1

default['tmux']['session_opts']['base-index'] = 1
default['tmux']['session_opts']['prefix'] = 'C-a'

default['tmux']['window_opts']['pane-base-index'] = 1
