terraform {
  required_version = ">= 1.10.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Configuración parcial: los valores reales llegan desde pdn.tfbackend (no versionado).
  # Estado en el bucket de la cuenta, con bloqueo nativo de S3 (Terraform 1.10+).
  backend "s3" {}
}

provider "aws" {
  region = var.region

  # Tags obligatorios en todos los recursos (TAG-01 y SCP-06, página 3b).
  default_tags {
    tags = {
      Ambiente           = var.ambiente
      Dominio            = "datos"
      CentroCosto        = var.centro_costo
      Owner              = var.owner
      ClasificacionDatos = "confidencial"
      Repositorio        = "workload/stacks/datos/data-lake"
    }
  }
}
