data "aws_caller_identity" "current" {}

# Llave KMS del dominio de datos, creada y publicada por el repositorio "security".
data "aws_ssm_parameter" "kms_datos" {
  name = "/security/kms/datos/arn"
}
