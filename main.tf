provider "aws" {
  region = var.region
}

module "aws_cloud_gaming" {
  source = "./aws-cloud-gaming"
  region = var.region
  allowed_availability_zone_identifier = var.allowed_availability_zone_identifier
  instance_type = var.instance_type
  root_block_device_size_gb = var.root_block_device_size_gb
  install_parsec = var.install_parsec
  install_auto_login = var.install_auto_login
  install_graphic_card_driver = var.install_graphic_card_driver
  install_steam = var.install_steam
  install_gog_galaxy = var.install_gog_galaxy
  install_uplay = var.install_uplay
  install_origin = var.install_origin
  install_epic_games_launcher = var.install_epic_games_launcher

  custom_ami = var.custom_ami
  skip_install = var.skip_install
}

resource "aws_ami_from_instance" "paused_instance_ami" {
  name                    = "cloud-gaming-${terraform.workspace}-paused"
  source_instance_id      = var.running_instance_id
}

output "paused_instance_ami" {
  value = aws_ami_from_instance.paused_instance_ami.id
}

output "instance_id" {
  value = module.aws_cloud_gaming.instance_id
}

output "instance_public_dns" {
  value = module.aws_cloud_gaming.instance_public_dns
}

output "instance_password" {
  value = module.aws_cloud_gaming.instance_password 
  sensitive = true
}