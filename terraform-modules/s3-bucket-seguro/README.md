# Módulo s3-bucket-seguro

Crea un bucket S3 con las protecciones que exige la estrategia de seguridad de Banca Global, activas por defecto:

| Protección | Cómo | Relación con la arquitectura |
|---|---|---|
| Cifrado en reposo con una llave propia | SSE-KMS con `bucket_key_enabled` | Una llave por dominio de datos (página 5c) |
| Sin acceso público | Los cuatro bloqueos de S3 Block Public Access | Coherente con SCP-02 (página 3b) |
| Solo conexiones cifradas | Política que niega peticiones sin TLS | Cifrado en tránsito |
| Solo identidades de la organización (opcional) | Política con `aws:PrincipalOrgID` | Perímetro de datos (RCP-01) |
| Sin ACL heredadas | `BucketOwnerEnforced` | Permisos solo por políticas |
| Historial de objetos | Versionado activo por defecto | Recuperación ante borrados |
| Costo optimizado (opcional) | Transición a S3 Intelligent-Tiering | Palanca de ahorro (página 11) |

## Uso

```hcl
module "data_lake" {
  source = "git::https://dev.azure.com/<org>/<proyecto>/_git/terraform-modules//s3-bucket-seguro?ref=v1.0.0"

  bucket_name                 = "bg-pdn-datalake-123456789012"
  kms_key_arn                 = data.aws_ssm_parameter.kms_datos.value
  organization_id             = "o-xxxxxxxxxx"
  intelligent_tiering_after_days = 30
}
```

## Variables

| Nombre | Tipo | Por defecto | Descripción |
|---|---|---|---|
| `bucket_name` | string | — | Nombre global del bucket (3 a 63 caracteres, minúsculas, números, puntos y guiones) |
| `kms_key_arn` | string | — | ARN de la llave KMS que cifra los objetos |
| `versioning_enabled` | bool | `true` | Activa el versionado de objetos |
| `organization_id` | string | `null` | Si se indica, niega el acceso a identidades fuera de la organización |
| `intelligent_tiering_after_days` | number | `null` | Días para mover objetos a Intelligent-Tiering; `null` desactiva la regla |
| `force_destroy` | bool | `false` | Permite borrar el bucket con objetos (solo para ambientes de prueba) |
| `tags` | map(string) | `{}` | Tags adicionales; los obligatorios llegan por `default_tags` del proveedor |

## Salidas

| Nombre | Descripción |
|---|---|
| `bucket_id` | Nombre del bucket |
| `bucket_arn` | ARN del bucket |
