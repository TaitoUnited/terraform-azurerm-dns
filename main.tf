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

locals {
  dnsZones = var.dns_zones != null ? var.dns_zones : []

  publicDnsZones = flatten([
    for dnsZone in local.dnsZones:
    dnsZone.visibility == "public" ? [ dnsZone ] : []
  ])

  privateDnsZones = flatten([
    for dnsZone in local.dnsZones:
    dnsZone.visibility == "private" ? [ dnsZone ] : []
  ])

  dnsZoneRecordSets = flatten([
    for dnsZone in local.dnsZones: [
      for dnsRecordSet in dnsZone.recordSets : merge(dnsRecordSet, {
        key = "${dnsZone.name}-${dnsRecordSet.dnsName}-${dnsRecordSet.type}"
        dnsZone = dnsZone
      })
    ]
  ])

  aRecords = flatten([
    for record in local.dnsZoneRecordSets:
    record.type == "A" ? [ record ] : []
  ])

  cnameRecords = flatten([
    for record in local.dnsZoneRecordSets:
    record.type == "CNAME" ? [ record ] : []
  ])

}
