# workload

Infraestructura de las cargas de trabajo de Banca Global. Un solo repositorio con dos grupos de stacks; el ejemplo documentado es el ambiente **PDN**, y DEV y QA siguen el mismo patrón en sus ramas.

| Rama | Cuenta destino |
|---|---|
| `dev` | Core DEV y Datos DEV |
| `qa` | Core QA y Datos QA |
| `main` | Core PDN y Datos PDN |

## Stacks

Cada stack tiene su propio estado. Un error en uno no afecta a los demás y el plan es más pequeño de revisar.

```text
workload/
├── stacks/
│   ├── core/                     # Página 4: aplicación transaccional
│   │   ├── ecs-cluster/          # clúster, servicios y tasks de los 5 módulos
│   │   ├── api/                  # API Gateway, VPC Link, NLB interno, Cognito
│   │   ├── edge/                 # CloudFront, WAF, sitio web en S3
│   │   └── data-stores/          # Aurora PostgreSQL, ElastiCache, secretos
│   └── datos/                    # Página 4: plataforma de datos en tiempo real
│       ├── data-lake/            # ← EJEMPLO IMPLEMENTADO: bucket del lago y catálogo de Glue
│       ├── streaming/            # Kinesis, Firehose, Managed Flink
│       └── analitica/            # Lake Formation, Athena, QuickSight, DynamoDB
└── README.md
```

## Qué se tiene en cuenta

- **Consume, no crea, la red:** la VPC, las subredes y el Transit Gateway los crea el repo `networking`. Este repo lee sus identificadores desde SSM Parameter Store (`/network/...`).
- **Consume las llaves KMS** publicadas por `security` (`/security/kms/...`).
- **Rol OIDC del pipeline:** puede crear recursos de aplicación y datos, pero no rutas, VPC ni políticas de la organización.
- **Orden dentro del repo:** `data-stores` → `api` → `ecs-cluster` → `edge`, y en paralelo `data-lake` → `streaming` → `analitica`.
