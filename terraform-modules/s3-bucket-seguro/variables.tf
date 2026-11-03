variable "bucket_name" {
  description = "Nombre global del bucket."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9.-]{1,61}[a-z0-9]$", var.bucket_name))
    error_message = "El nombre debe tener entre 3 y 63 caracteres: minúsculas, números, puntos o guiones, sin empezar ni terminar con símbolo."
  }
}

variable "kms_key_arn" {
  description = "ARN de la llave KMS que cifra los objetos del bucket."
  type        = string

  validation {
    condition     = can(regex("^arn:aws[a-z-]*:kms:", var.kms_key_arn))
    error_message = "Debe ser el ARN de una llave KMS."
  }
}

variable "versioning_enabled" {
  description = "Activa el versionado de objetos."
  type        = bool
  default     = true
}

variable "organization_id" {
  description = "ID de AWS Organizations (o-xxxxxxxxxx). Si se indica, se niega el acceso a identidades de fuera de la organización."
  type        = string
  default     = null
}

variable "intelligent_tiering_after_days" {
  description = "Días después de los cuales los objetos pasan a S3 Intelligent-Tiering. null desactiva la regla."
  type        = number
  default     = null

  validation {
    condition     = var.intelligent_tiering_after_days == null || try(var.intelligent_tiering_after_days >= 0, false)
    error_message = "Debe ser null o un número de días mayor o igual a 0."
  }
}

variable "force_destroy" {
  description = "Permite borrar el bucket aunque tenga objetos. Usar solo en ambientes de prueba."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags adicionales del bucket. Los tags obligatorios llegan por default_tags del proveedor."
  type        = map(string)
  default     = {}
}
