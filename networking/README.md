# networking · paso 3 del orden de despliegue

**Despliega en:** cuenta Network y la VPC spoke de cada cuenta de carga. **Dueño:** equipo de redes. **Página de referencia:** 6 y 6b.

## Stacks

```text
networking/stacks/
├── ipam/                # Pool 10.100.0.0/14 y sub-pools por ambiente (PDN, QA, DEV, compartidos)
├── transit-gateway/     # Transit Gateway, tablas rt-pdn, rt-nopdn, rt-compartidos, rt-onprem, rt-egreso; compartido por RAM
├── egress/              # VPC de egreso: Network Firewall, NAT e Internet Gateway en dos zonas
├── hybrid/              # Direct Connect Gateway, transit VIF, Site-to-Site VPN de respaldo, Customer Gateway
├── dns/                 # Endpoints de entrada y salida de Route 53 Resolver y reglas hacia el dominio corporativo
├── client-vpn/          # Client VPN con autenticación del IdP y reglas de autorización por CIDR
└── spokes/              # VPC de cada cuenta de carga: subredes TGW, App, Data y Service, tablas de rutas, NACL, endpoints
```

## Publica en SSM Parameter Store (en la cuenta de cada spoke)

`/network/vpc/id`, `/network/subnets/app/ids`, `/network/subnets/data/ids`, `/network/subnets/service/ids`, `/network/tgw/id`.

## Qué se tiene en cuenta

- **Es el único repositorio que crea VPC, subredes, rutas y attachments.** Así la segmentación de la página 6 no depende de cada equipo de aplicación.
- Los CIDR salen de IPAM: nadie escribe rangos a mano, y se evitan los solapamientos.
- La capa de datos (`rt-data`) nunca tiene ruta por defecto.
- Ningún spoke tiene Internet Gateway (coherente con la SCP-05); la salida a Internet va por `egress`.
- **Su rol OIDC no puede** crear bases de datos, contenedores ni políticas de la organización.
