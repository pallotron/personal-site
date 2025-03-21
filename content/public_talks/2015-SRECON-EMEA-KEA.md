---
date: '2015-03-21T10:32:32Z'
draft: false
title: 'DHCP Infrastructure Evolution at Facebook and the Importance of Designing Stateless Services'
---

🏢 Where: [SRECON2015](https://www.usenix.org/conference/srecon15europe)

🌎 [Conference official website](https://www.usenix.org/conference/srecon15europe/program/presentation/failla)

📊 [Slides](/slides/srecon15europe_slides_failla.pdf)

🎥 Video:
{{< youtube id="JPq_7oLN1TM">}}

## Abstract

Facebook is one of the largest sites in the world, with multiple datacenters
(and POPs in multiple continents) hosting a pretty large amount of machines.
This talk is about the evolution of the `DHCP` production infrastructure at Facebook.

In this talk we will use the `DHCP` case as an example to discuss why it's good
to design your systems to be stateless, and the fine line between leveraging
OSS projects where possible and take a “Not Invented Here” approach instead.
We will also talk about the challenges of driving large scope projects from
remote offices and the importance of possessing skills in both systems and
software development fields.

We'll look at `DHCP` in Facebook in both `IPv4` and `IPv6` worlds, we will dive
into old architecture and its limitations. and then talk about how the Cluster
Operations team in Dublin leveraged the ISC KEA open source project to migrate
from a stateful service to a stateless one, discussing challenges faced in the
process and the benefits we gained.

Angelo is a Production Engineer at Facebook. He joined the company in early
2011 as a Site Reliability Engineer and recently moved to the Cluster
Operations Team. In this period he has contributed to various projects, like
our cluster turnup tool Kobold and F. B. A. R. (the Facebook Auto Remediation
tool). More recently he has been involved in revamping the DHCP architecture
for the Facebook production network, which he will discuss in this talk. He is
interested in automation tools and large-scale distributed systems.

## Notes

KEA is no longer used at FB/Meta since 2016, we ended up working on `dhcplb`.
You can read [the post on Meta's engineering blog](https://engineering.fb.com/2016/09/13/data-infrastructure/dhcplb-an-open-source-load-balancer/)
which tells you the full story of how the project was born: from a "hackaton prototype"
to a summer internship project to production! And it is still running to these days
(2025) driving datacenters aroudn the globe :)
