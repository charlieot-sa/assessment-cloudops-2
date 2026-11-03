variable "region" {
  description = "Región de AWS del ambiente."
  type        = string
  default     = "us-east-1"
}

variable "ambiente" {
  description = "Ambiente: dev, qa o pdn."
  type        = string

  validation {
    condition     = contains(["dev", "qa", "pdn"], var.ambiente)
    error_message = "El ambiente debe ser dev, qa o pdn."
  }
}

variable "centro_costo" {
  description = "Código contable del área dueña (tag CentroCosto)."
  type        = string
}

variable "owner" {
  description = "Equipo o correo responsable (tag Owner)."
  type        = string
}

variable "organization_id" {
  description = "ID de AWS Organizations para restringir el acceso al lago."
  type        = string
}

variable "intelligent_tiering_after_days" {
  description = "Días para mover los objetos del lago a Intelligent-Tiering."
  type        = number
  default     = 30
}
