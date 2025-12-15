output "sg_system" {
  value = {
    lb          = module.alb_sg.security_group_id
    web         = module.web_sg.security_group_id
    db          = module.db_sg.security_group_id
    elasticache = module.elasticache_sg.security_group_id
    baston = {
      id   = module.baston_sg.security_group_id
      name = module.baston_sg.security_group_name
    }
  }
}