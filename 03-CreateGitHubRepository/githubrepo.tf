terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

# Configure the GitHub Provider

provider "github" {
  token = " " # "GITHUB_TOKEN"
}

resource "github_repository" "examplerepo" {
  name        = "GitRepoThroughTF"
  description = "My awesome Github Repository created through Terraform script"

  visibility = "public"
 
}