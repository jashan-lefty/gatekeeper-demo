terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_manifest" "template" {
  manifest = yamldecode(file("${path.module}/template.yaml"))
}

resource "kubernetes_manifest" "constraint" {
  manifest = jsondecode(file("${path.module}/constraint.json"))
}

resource "kubernetes_manifest" "goodpod" {
  manifest = yamldecode(file("${path.module}/goodpod.yaml"))
}

# NOTE: We don’t deploy badpod via Terraform, to avoid plan failure.
