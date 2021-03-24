/**
 * Copyright 2021 Taito United
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

resource "azurerm_dns_zone" "public" {
  for_each            = {for item in local.publicDnsZones: item.name => item}

  name                = each.value.dnsName
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone" "private" {
  for_each      = {for item in local.privateDnsZones: item.name => item}

  name                = each.value.dnsName
  resource_group_name = var.resource_group_name
}

resource "azurerm_dns_a_record" "a" {
  for_each            = {for item in local.aRecords: item.name => item}
  name                = split(".", each.value.dnsName)[0]
  zone_name           = join(".", slice(split(".", each.value.dnsName), 1, 100))  # TODO: endIndex
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl
  records             = each.value.values
}

resource "azurerm_dns_cname_record" "cname" {
  for_each            = {for item in local.cnameRecords: item.name => item}
  name                = split(".", each.value.dnsName)[0]
  zone_name           = join(".", slice(split(".", each.value.dnsName), 1, 100))  # TODO: endIndex
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl
  record              = each.value.values[0]
}

# TODO: Add support for other record types
