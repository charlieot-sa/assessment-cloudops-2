# security · paso 2 del orden de despliegue

**Despliega en:** cuentas Audit y Log Archive (administrador delegado de los servicios de seguridad). **Dueño:** equipo de seguridad. **Páginas de referencia:** 5, 5b, 5c y 5d.

## Stacks

```text
security/stacks/
├── log-archive/         # Buckets de CloudTrail, Config, Flow Logs y WAF (módulo s3-bucket-seguro), retención y Object Lock*
├── kms/                 # Llaves por dominio de datos (transaccional, datos, logs, tfstate) y sus key policies
├── detection/           # GuardDuty, Security Hub (estándares CIS y AWS Foundational), Config agregador, Macie, Inspector, Access Analyzer
├── firewall-manager/    # Políticas de WAF, Shield Advanced, security groups y Network Firewall para toda la organización
└── response/            # Reglas de EventBridge, Lambdas de remediación y temas de SNS hacia el SOC
```

## Publica en SSM Parameter Store

`/security/kms/<dominio>/arn`, `/security/log-archive/bucket`, `/security/sns/alertas/arn`.

## Qué se tiene en cuenta

- Las llaves KMS se crean aquí y los demás dominios solo las **referencian**: así nadie puede crear llaves sin control.
- Los buckets de Log Archive no se pueden borrar desde ningún otro repositorio (lo protege la SCP-04).
- **Su rol OIDC no puede** modificar rutas, VPC ni recursos de aplicación.
