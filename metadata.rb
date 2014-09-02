name             'tmux'
maintainer       'Chef Software, Inc.'
maintainer_email 'cookbooks@getchef.com'
license          'Apache 2.0'
description      'Installs tmux'
long_description 'Installs tmux (http://http://tmux.sourceforge.net/), a terminal multiplexer for Unix/Linux'
version          '1.4.2'

%w{ centos redhat ubuntu }.each do |os|
  supports os
end
