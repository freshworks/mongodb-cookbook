shard_nodes = search(
  :node,
  "mongodb_cluster_name:#{new_resource.cluster_name} AND \
   mongodb_is_shard:true AND \
   chef_environment:#{node.chef_environment}"
)
Chef::Log.info("shard_nodes.inspect -> #{shard_nodes.inspect}")
ruby_block 'config_sharding' do
  Chef::Log.info("Inside Config Sharding")      
  block do
    MongoDB.configure_shards(node, shard_nodes)
    MongoDB.configure_sharded_collections(node, new_resource.sharded_collections)
  end
  action :create
end