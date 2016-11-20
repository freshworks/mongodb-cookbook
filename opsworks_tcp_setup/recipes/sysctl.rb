template "/etc/sysctl.d/50-faye-defaults.conf" do
  mode 0644
  owner "root"
  group "root"
  source "sysctl.conf.erb"
  cookbook "opsworks_tcp_setup"
end

node[:opsworks_tcp_setup][:sysctl].each do |systcl, value|
  execute "Setting sysctl: #{systcl}" do
    command "sysctl -w #{systcl}='#{value}'"
    action :run
  end
end
