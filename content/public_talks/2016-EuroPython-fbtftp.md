---
date: '2016-07-17T10:33:09Z'
draft: false
title: "FBTFTP: Facebook's open source python3 framework for dynamic TFTP servers"
---


🏢 Where: [Euro Python 2016 - Bilbao, Spain](https://ep2016.europython.eu/conference/p/angelo-failla.html)

🌎 [Conference official website](https://ep2016.europython.eu/conference)

📊 [Slides](/slides/srecon15europe_slides_failla.pdf)

⌨️ Code: <https://github.com/facebookarchive/fbtftp>

🎥 Video:
{{< youtube id="1pndeS8FIS8" >}}

## Abstract

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

## Notes

This project was sunset'ed a few years ago, the code is still available
on github, it was replaced initially by a golang implementation based
on <https://github.com/pin/tftp> followed by an internal rust implementation.
