---
title: "DHCPLB"
date: "2025-09-02T08:04:26+01:00"
draft: false
---

{{< image path=dhcplb/datahall.webp width=600 >}}

`dhcplb` is Meta's implementation of:

- a DHCP v4/v6 relayer with load balancing capabilities
- a DHCP v4/v6 server framework

Meta currently uses it in production, and it's deployed at global scale across all of the data centers.
It drives bare metal provisioning of all machines being ingested, moved and decommissioned in the fleet.
It is based on [@insomniacslk](https://github.com/insomniacslk) [dhcp library](https://github.com/insomniacslk/dhcp).

The story of this project is pretty significant.
In 2014 I setup redoing the entire DHCP production infra, we needed something more dynamic.
Since the beginning Facebook DHCP infra was based on the standard ISC `dhcpd`

- [Github repo](https://github.com/facebookincubator/dhcplb)
- [Meta engineering blog post](https://engineering.fb.com/2016/09/13/data-infrastructure/dhcplb-an-open-source-load-balancer/)
