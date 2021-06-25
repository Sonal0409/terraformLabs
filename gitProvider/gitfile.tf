terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "4.11.0"
    }
  }
}

provider "github" {
  # Configuration options
  token = "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"
}

# create a new repo in gitHub

resource "github_repository" "myrepo" {
  name        = "gitterraformrepo"
  description = "My terraform repo"
  visibility = "private"
}
