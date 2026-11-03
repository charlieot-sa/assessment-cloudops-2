# governance · paso 1 del orden de despliegue

**Despliega en:** cuenta Management. **Dueño:** equipo de plataforma y gobierno. **Página de referencia:** 3 y 3b.

## Stacks

```text
governance/stacks/
├── organization/        # OUs: Security, Infrastructure, Workloads (PDN, QA, DEV), Sandbox, Suspended
├── policies/            # SCP-01 a SCP-08, RCP-01, Tag Policy TAG-01 y sus asociaciones a cada OU
├── controls/            # Controles de Control Tower habilitados por OU (preventivos y detectivos)
├── identity/            # IAM Identity Center: permission sets y asignaciones por grupo del IdP
└── billing/             # Budgets por OU y alertas de Cost Anomaly Detection
```

## Publica en SSM Parameter Store

`/org/id`, `/org/ou/<nombre>/id`.

## Qué se tiene en cuenta

- Es el repositorio más sensible: cualquier cambio puede afectar a todas las cuentas. **Siempre con aprobación**, incluso fuera de PDN.
- Las SCP se prueban primero asociadas a la OU **Sandbox** antes de aplicarlas a Workloads.
- Las SCP excluyen los roles de Control Tower y el rol *break-glass*.
- La landing zone de Control Tower se crea una vez desde la consola; este repositorio gestiona lo que se configura encima.
- **Su rol OIDC no puede** crear recursos de red ni de aplicación.
