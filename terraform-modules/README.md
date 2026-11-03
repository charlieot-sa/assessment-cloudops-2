# terraform-modules

Librería de módulos Terraform reutilizables. Cada módulo se versiona con etiquetas Git siguiendo versionado semántico (`v1.0.0`, `v1.1.0`, `v2.0.0`), y los repositorios de dominio consumen siempre una versión fija.

| Módulo | Estado en el esqueleto | Usado por |
|---|---|---|
| `s3-bucket-seguro` | **Implementado** (ejemplo) | security (Log Archive), workload (data lake), estado de Terraform |
| `vpc-spoke` | Pendiente | networking |
| `tgw-attachment` | Pendiente | networking |
| `ecs-service` | Pendiente | workload/core |
| `aurora-postgresql` | Pendiente | workload/core |
| `kms-key` | Pendiente | security |
| `iam-role-oidc` | Pendiente | todos (rol del pipeline por cuenta) |
| `waf-web-acl` | Pendiente | workload/core |

## Reglas de los módulos

- Valores seguros por defecto: cifrado, sin acceso público y logs activos, sin que quien lo usa tenga que recordarlo.
- Variables con validaciones y descripciones; salidas mínimas y documentadas.
- Sin bloque `provider` ni `backend` dentro del módulo: los define el repo que lo usa.
- Cambios que rompen compatibilidad suben la versión mayor.
