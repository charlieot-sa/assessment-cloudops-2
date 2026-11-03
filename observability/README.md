# observability · paso 5 del orden de despliegue

**Despliega en:** todas las cuentas, con la cuenta Observability como centro. **Dueño:** equipo CloudOps. **Página de referencia:** 8 y 8b.

## Stacks

```text
observability/stacks/
├── cloudwatch/          # Alarmas base, dashboards de respaldo, Container Insights, retención de log groups
├── metric-streams/      # CloudWatch Metric Streams + Firehose hacia Datadog
├── datadog/             # Integración AWS–Datadog, monitores, SLO, dashboards por audiencia y sintéticos (proveedor datadog)
└── alerting/            # Temas de SNS y rutas por severidad: PagerDuty, Slack o Teams, Jira
```

## Consume de SSM Parameter Store

`/security/sns/alertas/arn`, `/datos/data-lake/bucket` y los identificadores de los servicios que monitorea.

## Qué se tiene en cuenta

- Se despliega al final porque monitorea lo que crean los demás dominios.
- Las alertas se definen en un solo lugar (Datadog) para no duplicar avisos; CloudWatch solo conserva las alarmas base y las de corrección automática.
- La llave de API de Datadog vive en Secrets Manager y se lee en tiempo de ejecución; nunca se escribe en el código.
