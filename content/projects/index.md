---
title: "️️⚙ Projects"
---

A list of (public) work and personal projects.

## Personal projects

### Yubiswitch ([Github repo](https://github.com/pallotron/yubiswitch))

![Yubikey Nano picture](/nano.jpg)

`yubiswitch` is an OSX status bar application to enable/disable a [Yubikey Nano or Neo](https://www.yubico.com/products/yubikey-hardware/) from Yubico.

Yubico is the producer of the Yubikeys: a hardware authentication device, designed to provide an easy to use and secure compliment to the traditional username and password.

By touching the exposed gold edge, a YubiKey Nano emits a One Time Password (OTP) as if it was typed in from a keyboard. The unique passcode is verified by a YubiKey compliant application.

So far all looks great doesn't it? :joy:

```text
flnurfrdjvfrlutthjtjvcbcrlbbnnuu
ejehlrlrclcllukjgehhrttbknnbjdfn
njlvvnherbjvnljdvvvnihrfikufjucr
jhgkhrubrnuchhhbhrugvbenrhkcvich
```

Whooops! You see? I brought my laptop (lid opened) with me for a walk to a meeting room holding it with my right hand touching the golden stripe and this caused the Nano to start sending random OTP passwords to my Vim session, and to the FB chat window I had opened with my wife, and right now she's been asking WTF I've been writing :stuck_out_tongue:

This status bar app allows you to avoid sending those accidental OTP passwords by allowing you to enable or disable the yubikey using a convenient global keyboard hot key that you can configure yourself.
This was my first (and probably last) macOS application!
I used it as an excuse to learn some ObjectiveC.

## Work related Projects (Meta)

![Yubikey Nano picture](/datahall.webp)

### dhcplb ([Github repo](https://github.com/facebookincubator/dhcplb))

`dhcplb` is Meta's implementation of:

- a DHCP v4/v6 relayer with load balancing capabilities
- a DHCP v4/v6 server framework

Meta currently uses it in production, and it's deployed at global scale across all of the data centers.
It drives bare metal provisioning of all machines being ingested, moved and decommissioned in the fleet.
It is based on [@insomniacslk](https://github.com/insomniacslk) [dhcp library](https://github.com/insomniacslk/dhcp).

The story of this project is pretty significant.
In 2014 I setup redoing the entire DHCP production infra, we needed something more dynamic.
Since the beginning Facebook DHCP infra was based on the standard ISC `dhcpd`

- [Meta engineering blog post](https://engineering.fb.com/2016/09/13/data-infrastructure/dhcplb-an-open-source-load-balancer/)

### fbtftp ([Github repo](https://github.com/facebookarchive/fbtftp))

Dynamic TFTP server written in Python3 that was used in Meta/Facebook datacenters (now replaced).
Allow you to configure hooks and serve files dynamically based on code you write.
I presented about it at [EuroPython, Bilbao](/public_talks/2016-europython-fbtftp/)

### fbender ([Github repo](https://github.com/facebookarchive/fbender))

Load testing command line tool for generic network protocols.
Expands over the Pinterest Bender library and add some features to it.
Worked on it with my summer intern of 2018. It was used to perform load testing of DHCP and DNS infra.
