---
title: "PVMLab"
date: "2025-11-03T08:04:26+01:00"
draft: false
---

![PVMLab Logo](/projects/pvmlab.png)

This project provides a command-line tool, pvmlab, to automate the setup of a simple virtual provisioning lab on macOS. It uses QEMU, socket_vmnet, cloud-init, and Docker to create and manage an environment where multiple "target" VMs are deployed in a private virtual network and one VM functions as the "provisioner" VM offering pxeboot services and working as default gw for internet access for those VMs.

All generated artifacts (VM disks, ISOs, logs, etc.) are stored neatly in ~/.pvmlab/, keeping the project repository clean.

## Use Cases

This virtual lab is ideal for a variety of network-based provisioning and testing scenarios, such as:

- **Testing OS Installers:** Develop and test automated OS installation configurations like Ubuntu Autoinstall, Debian Preseed, or Red Hat Kickstart. Or test your own ;)
- **Developing Network Boot Environments:** Experiment with and develop iPXE scripts or other network boot setups.
- **Simulating Bare-Metal Provisioning:** Mimic the process of provisioning physical servers in a fully virtualized, local environment.
- **Network Service Testing:** Safely test DHCP, TFTP, and HTTP services in an isolated network.
- **Playing with Kubernetes or Other Orchestration Tools:** Use the lab to experiment with cluster provisioning and management tools like kubernetes, Tinkerbell, Canonical MAAS, etc.
- **Learning and Experimentation:** Provide a hands-on environment for learning about PXE boot, network automation, and cloud-init.

## References

- [QEMU](https://www.qemu.org/)
- [socket_vmnet](https://github.com/lima-vm/socket_vmnet)
- [cloud-init](https://cloud-init.io/)
- [Docker](https://www.docker.com/)
- [GitHub Repository](https://github.com/pallotron/pvmlab)
