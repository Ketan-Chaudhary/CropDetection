output "swarm_node_ips" {
  value = module.compute.instance_public_ips
}

output "vpc_id" {
  value = module.network.vpc_id
}
