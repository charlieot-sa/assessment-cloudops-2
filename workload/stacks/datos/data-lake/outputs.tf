output "bucket_lago" {
  description = "Nombre del bucket del data lake."
  value       = module.data_lake.bucket_id
}

output "base_datos_glue" {
  description = "Base de datos del Glue Data Catalog para las tablas Iceberg."
  value       = aws_glue_catalog_database.datos.name
}
