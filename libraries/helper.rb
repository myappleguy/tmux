module Tmux
  module Helper

    def libevent_install_method
      if tmux_requires_libevent_2?
        install_method = value_for_platform_family(
          'rhel' => {
            '6.4' => :source,
            '6.5' => :source,
            '7.0' => :package
          },
          'default' => :package
        )
      else
        install_method = :package
      end

      install_method
    end


    private

    # tmux version > 1.6 requires libevent 2.0+
    # libevent 2.0 is available as a package only in CentOS 7 and Ubuntu > 10.04
    def tmux_requires_libevent_2?
      node['tmux']['version'].to_f > 1.6 
    end

  end
end
