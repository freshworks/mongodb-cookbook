template '/etc/security/limits.conf' do
  source 'limits.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  cookbook 'opsworks_tcp_setup'
end
