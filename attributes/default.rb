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

default['tmux']['install_method'] = case node['platform_family']
                                    when 'rhel'
                                      'source'
                                    else
                                      'package'
                                    end

default['tmux']['version'] = '1.9a'
default['tmux']['source_url'] = "http://downloads.sourceforge.net/tmux/tmux-#{node['tmux']['version']}.tar.gz"
default['tmux']['checksum'] = ''
# {
# '1.6' => '',
# '1.7' => '',
# '1.8' => '',
# '1.9a' => ''
# }

default['tmux']['libevent']['install_method'] = libevent_install_method

default['tmux']['configure_options'] = []

default['tmux']['server_opts']['escape-time'] = 1

default['tmux']['session_opts']['base-index'] = 1
default['tmux']['session_opts']['prefix'] = 'C-a'

default['tmux']['window_opts']['pane-base-index'] = 1
