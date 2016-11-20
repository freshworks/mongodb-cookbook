if node[:platform] == 'amazon'
  # We only have to run 'yum-config-manager --quiet --enable epel' in order
  # to get EPEL working.
  execute 'installing ip_conntrack package' do
    command 'modprobe ip_conntrack'
    action :run
  end
end
