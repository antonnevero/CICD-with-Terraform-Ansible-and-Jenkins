terraform {
  cloud {
    organization = "devops-in-the-cloud"

    workspaces {
      name = "terransible"
    }
  }
}