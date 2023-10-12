terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  cloud {
    organization = "NetworkCoder-Daniel"

    workspaces {
      name = "terra-house-10"
    }
  }
}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid=var.teacherseat_user_uuid
  token=var.terratowns_access_token
}


module "home_cartoons_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.cartoons.public_path
  content_version = var.cartoons.content_version
}

resource "terratowns_home" "home_cartoons" {
  name = "Cartoons to Movies!!"
  description = <<DESCRIPTION
Great cartoons from back in the 90's that were
fun to watch and later became good movies.
DESCRIPTION
  domain_name = module.home_cartoons_hosting.domain_name
  town = "video-valley"
  content_version = var.cartoons.content_version
}

module "home_recipe_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.recipe.public_path
  content_version = var.recipe.content_version
}

resource "terratowns_home" "home_recipe" {
  name = "My fav recipe"
  description = <<DESCRIPTION
Really like to eat and one of my favorite recipes
to make is chicken tikka masala.
DESCRIPTION
  domain_name = module.home_recipe_hosting.domain_name
  town = "cooker-cove"
  content_version = var.recipe.content_version
}