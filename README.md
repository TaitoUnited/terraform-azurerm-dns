# Azure DNS

Example usage:

```
provider "azurerm" {
  features {}
}

module "dns" {
  source              = "TaitoUnited/dns/azurerm"
  version             = "1.0.0"

  resource_group_name = "my-infrastructure"

  dns_zones           = yamldecode(file("${path.root}/../infra.yaml"))["dnsZones"]
}
```

Example YAML:

```
dnsZones:
  - dnsName: mydomain.com.
    visibility: public # 'public' or 'private'
    soaRecord:
      email: support@mydomain.com
      hostName: ns1-03.azure-dns.com.
    recordSets:
      - dnsName: www.mydomain.com.
        type: A
        ttl: 3600
        values: ["127.127.127.127"]
      - dnsName: myapp.mydomain.com.
        type: CNAME
        ttl: 43200
        values: ["myapp.otherdomain.com."]
```

YAML attributes:

- See variables.tf for all the supported YAML attributes.
- See [dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_zone) for attribute descriptions.

Combine with the following modules to get a complete infrastructure defined by YAML:

- [Admin](https://registry.terraform.io/modules/TaitoUnited/admin/azurerm)
- [DNS](https://registry.terraform.io/modules/TaitoUnited/dns/azurerm)
- [Network](https://registry.terraform.io/modules/TaitoUnited/network/azurerm)
- [Compute](https://registry.terraform.io/modules/TaitoUnited/compute/azurerm)
- [Kubernetes](https://registry.terraform.io/modules/TaitoUnited/kubernetes/azurerm)
- [Databases](https://registry.terraform.io/modules/TaitoUnited/databases/azurerm)
- [Storage](https://registry.terraform.io/modules/TaitoUnited/storage/azurerm)
- [Monitoring](https://registry.terraform.io/modules/TaitoUnited/monitoring/azurerm)
- [Integrations](https://registry.terraform.io/modules/TaitoUnited/integrations/azurerm)
- [PostgreSQL privileges](https://registry.terraform.io/modules/TaitoUnited/privileges/postgresql)
- [MySQL privileges](https://registry.terraform.io/modules/TaitoUnited/privileges/mysql)

TIP: Similar modules are also available for AWS, Google Cloud, and DigitalOcean. All modules are used by [infrastructure templates](https://taitounited.github.io/taito-cli/templates#infrastructure-templates) of [Taito CLI](https://taitounited.github.io/taito-cli/). See also [Azure project resources](https://registry.terraform.io/modules/TaitoUnited/project-resources/azurerm), [Full Stack Helm Chart](https://github.com/TaitoUnited/taito-charts/blob/master/full-stack), and [full-stack-template](https://github.com/TaitoUnited/full-stack-template).

Contributions are welcome!
