# pipeline-templates

Plantillas YAML de Azure Pipelines que reutilizan todos los repositorios de dominio, para que todos apliquen los mismos controles (página 9).

| Plantilla | Uso |
|---|---|
| `terraform-pipeline.yml` | Pipeline de IaC por dominio y stack: prerrequisitos, CI, validación, aprobación y CD |

## Cómo la usa un repositorio de dominio

```yaml
# azure-pipelines.yml en el repositorio "workload"
trigger:
  branches:
    include: [dev, qa, main]

resources:
  repositories:
    - repository: templates
      type: git
      name: <proyecto>/pipeline-templates
      ref: refs/tags/v1.0.0

extends:
  template: terraform-pipeline.yml@templates
  parameters:
    stackPath: stacks/datos/data-lake
```

## Requisitos en Azure DevOps

- Una **service connection de AWS por cuenta** configurada con OIDC (sin access keys), que asume el rol IAM del pipeline de ese dominio.
- **Environments** `dev`, `qa` y `pdn`, con aprobadores en `qa` y `pdn`.
- Un **grupo de variables** por ambiente en la Library, vinculado a un gestor seguro para los valores sensibles.
