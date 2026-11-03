# IaC de Banca Global S.A.S. · repositorio esqueleto

> **Qué es esto.** Una muestra de la estrategia de infraestructura como código descrita en las páginas **9c y 9d** de `diagramas/banca-global.drawio`. Contiene la **estructura completa** de los repositorios por dominio y **un ejemplo funcional**: el módulo `s3-bucket-seguro` y su uso para el data lake de PDN. El resto de la infraestructura sigue el mismo patrón.
>
> **Qué no es.** No despliega toda la arquitectura ni se ha ejecutado contra AWS.

## Repositorios por dominio

En Azure Repos cada carpeta sería un repositorio independiente. Aquí se agrupan en una sola carpeta para presentarlos juntos.

| Orden | Repositorio | Despliega en | Contenido |
|---|---|---|---|
| — | `terraform-modules/` | — (librería) | Módulos reutilizables y versionados |
| — | `pipeline-templates/` | — | Plantillas YAML de Azure DevOps |
| 1 | `governance/` | Management | OUs, SCPs, RCPs, Tag Policy, Identity Center, Budgets |
| 2 | `security/` | Audit y Log Archive | GuardDuty, Security Hub, Config, Macie, Firewall Manager, KMS base, buckets de logs |
| 3 | `networking/` | Network y la VPC de cada cuenta de carga | IPAM, Transit Gateway, VPC de egreso, Direct Connect, VPN, Resolver, Client VPN, VPC spoke |
| 4 | `workload/` | Cuentas de carga (ejemplo: PDN) | Stacks `core` (aplicación) y `datos` (plataforma de datos) |
| 5 | `observability/` | Todas | Dashboards, alarmas, Metric Streams, Datadog, SNS, EventBridge |

## Reglas comunes

1. **Ramas por ambiente:** `dev` → cuenta DEV, `qa` → cuenta QA, `main` → cuenta PDN. Un cambio se escribe una vez y se promueve por Pull Request.
2. **Estado aislado:** un bucket S3 por cuenta, una clave por dominio y stack (`<dominio>/<stack>/terraform.tfstate`), cifrado con KMS, versionado y con bloqueo nativo de S3.
3. **Sin acoplar dominios:** los valores que otro dominio necesita se publican en **SSM Parameter Store** (por ejemplo `/network/vpc/id`). Ningún repo lee el estado de otro.
4. **Sin secretos en el código:** `*.tfvars` y `*.tfbackend` reales no se versionan; solo los `.example`.
5. **Tags obligatorios** desde el proveedor (`default_tags`): `Ambiente`, `Dominio`, `CentroCosto`, `Owner` y `ClasificacionDatos`.
6. **Módulos con versión fija:** en un repo real se consumen como `git::https://dev.azure.com/<org>/<proyecto>/_git/terraform-modules//s3-bucket-seguro?ref=v1.0.0`. En este esqueleto se usa una ruta relativa para poder validarlo localmente.

## Cómo validar el ejemplo

Requiere Terraform 1.10 o superior. No necesita credenciales de AWS para validar.

```bash
cd workload/stacks/datos/data-lake
terraform init -backend=false
terraform validate
terraform fmt -check -recursive ../../../..
```
