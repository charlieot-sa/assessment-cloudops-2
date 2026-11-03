locals {
  # El ID de la cuenta hace el nombre único globalmente y distinto por ambiente.
  prefijo         = "bg-${var.ambiente}"
  bucket_lago     = "${local.prefijo}-datalake-${data.aws_caller_identity.current.account_id}"
  base_datos_glue = "datos_${var.ambiente}"
}
