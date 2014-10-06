module Tmux
  module Helper
    def libevent_install_method
      return 'package' unless tmux_requires_libevent_2?

      # libevent 2.0 is available as a package only in CentOS 7 and Ubuntu > 10.04
      value_for_platform(
        %w(rhel centos) => {
          '6.4' => 'source',
          '6.5' => 'source'
        },
        'ubuntu' => { '10.04' => 'source' },
        'default' => 'package'
      )
    end

    private

    # tmux version > 1.6 requires libevent 2.0+
    def tmux_requires_libevent_2?
      node['tmux']['version'].to_f > 1.6
    end
  end
end
