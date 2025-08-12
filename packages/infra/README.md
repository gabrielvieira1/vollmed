# VollMed Infrastructure

## Estrutura

- `terraform/` - Infraestrutura como código
- `kubernetes/` - Manifests do Kubernetes
- `ansible/` - Playbooks de configuração
- `monitoring/` - Prometheus, Grafana, etc.

## Comandos

```bash
npm run tf:init    # Inicializar Terraform
npm run tf:plan    # Planejar infraestrutura
npm run tf:apply   # Aplicar infraestrutura
npm run k8s:deploy # Deploy no Kubernetes
```
