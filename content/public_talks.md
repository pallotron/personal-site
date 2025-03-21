---
date: '2025-03-21T08:35:09Z'
draft: false
title: 'Public talks'
page:
  toc:
    enable: true
    auto: true
    keepStatic: false
---

## 2016 - FBTFTP: Facebook's open source python3 framework for dynamic TFTP servers

- [EuroPython2016](https://ep2016.europython.eu/conference/p/angelo-failla.html)
- [Code](https://github.com/facebookarchive/fbtftp)

***Abstract***

TFTP was first standardized in '81 (same year I was born!) and one of
its primary uses is in the early stage of network booting. TFTP is
very simple to implement, and one of the reasons it is still in use is
that its small footprint allows engineers to fit the code into very
low resource, single board computers, system-on-a-chip implementations
and mainboard chipsets, in the case of modern hardware.

It is therefore a crucial protocol deployed in almost every data
center environment. It is used, together with DHCP, to chain load
Network Boot Programs (NBPs), like Grub2 and iPXE. They allow
machines to bootstrap themselves and install operating systems off of
the network, downloading kernels and initrds via HTTP and starting
them up.

At Facebook, we have been using the standard in.tftpd daemon for
years, however, we started to reach its limitations.
Limitations that were partially due to our scale and the way TFTP was
deployed in our infrastructure, but also to the protocol
specifications based on requirements from the 80's.

To address those limitations we ended up writing our own framework for
creating dynamic TFTP servers in Python3, and we decided to open
source it.

I will take you thru the framework and the features it offers. I'll
discuss the specific problems that motivated us to create it. We will
look at practical examples of how touse it, along with a little code, 
to build your own server that are tailored to your own infra needs.

{{< youtube id="1pndeS8FIS8" >}}

## 2015 - DHCP Infrastructure Evolution at Facebook and the Importance of Designing Stateless Services

- [SRECON EMEA 2015 - Dublin](https://www.usenix.org/conference/srecon15europe/program/presentation/failla)
- [Slides](/slides/srecon15europe_slides_failla.pdf)

***Abstract***

Facebook is one of the largest sites in the world, with multiple datacenters
(and POPs in multiple continents) hosting a pretty large amount of machines.
This talk is about the evolution of the DHCP production infrastructure at Facebook.

In this talk we will use the DHCP case as an example to discuss why it's good to design your systems to be stateless, and the fine line between leveraging OSS projects where possible and take a “Not Invented Here” approach instead. We will also talk about the challenges of driving large scope projects from remote offices and the importance of possessing skills in both systems and software development fields.

We'll look at DHCP in Facebook in both IPv4 and IPv6 worlds, we will dive into old architecture and its limitations. and then talk about how the Cluster Operations team in Dublin leveraged the ISC KEA open source project to migrate from a stateful service to a stateless one, discussing challenges faced in the process and the benefits we gained.

Angelo is a Production Engineer at Facebook. He joined the company in early 2011 as a Site Reliability Engineer and recently moved to the Cluster Operations Team. In this period he has contributed to various projects, like our cluster turnup tool Kobold and F. B. A. R. (the Facebook Auto Remediation tool). More recently he has been involved in revamping the DHCP architecture for the Facebook production network, which he will discuss in this talk. He is interested in automation tools and large-scale distributed systems.

<https://www.usenix.org/conference/srecon15europe/program/presentation/failla>

{{< youtube id="JPq_7oLN1TM">}}

## 2014 - Pycon Ireland - Python@Facebook

- [Slides](/slides/pycon2014.pdf)

***Abstract***

Facebook is a company that operates at massive scale. In this talk we’ll talk about how we use Python at Facebook.
Be it building back-end services, fast prototyping, automation, scaling operations, or simply gluing together various pieces of our infrastructure, Python is at the heart of it and allows our engineers to quickly deliver working solutions

{{< youtube id="k0vTpd6h8ZI" >}}
