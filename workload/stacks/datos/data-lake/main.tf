# Bucket del data lake (tablas Apache Iceberg de eventos y resultados de fraude).
# En el repositorio real: source = "git::https://dev.azure.com/<org>/<proyecto>/_git/terraform-modules//s3-bucket-seguro?ref=v1.0.0"
module "data_lake" {
  source = "../../../../terraform-modules/s3-bucket-seguro"

  bucket_name                    = local.bucket_lago
  kms_key_arn                    = data.aws_ssm_parameter.kms_datos.value
  organization_id                = var.organization_id
  intelligent_tiering_after_days = var.intelligent_tiering_after_days
}

# Base de datos del Glue Data Catalog donde Firehose y Flink registran las tablas Iceberg.
resource "aws_glue_catalog_database" "datos" {
  name         = local.base_datos_glue
  description  = "Tablas Iceberg de la plataforma de datos (${var.ambiente})"
  location_uri = "s3://${module.data_lake.bucket_id}/iceberg/"
}

# Publica los valores que otros stacks necesitan (streaming, analítica), sin compartir el estado.
resource "aws_ssm_parameter" "bucket_lago" {
  name  = "/datos/data-lake/bucket"
  type  = "String"
  value = module.data_lake.bucket_id
}

resource "aws_ssm_parameter" "base_datos_glue" {
  name  = "/datos/data-lake/glue-database"
  type  = "String"
  value = aws_glue_catalog_database.datos.name
}
