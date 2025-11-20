# Cybersecurity Homelab

This repository documents the design, deployment, and ongoing operation of my cybersecurity homelab. The environment is built to mirror the moving parts of a small enterprise—directory services, endpoint hardening, network segmentation, traffic inspection, centralized logging, and structured incident response practice. Every component is configured deliberately, tested repeatedly, and documented in detail.

The purpose is straightforward: develop and demonstrate real operational security experience. This lab acts as a controlled environment for validating defensive techniques, troubleshooting complex systems, and building an engineering process that aligns with modern security expectations.

## Scope and Objectives

This homelab serves as a platform for:

- Systems administration across Linux and Windows
- Network architecture using KVM bridges and pfSense routing
- Endpoint hardening, firewall configuration, and kernel-level tuning
- Log collection and SIEM analysis via Wazuh
- Threat detection experiments, including packet capture and alert validation
- Incident response workflows based on practical simulations

Each subsystem is configured with reproducibility in mind—versioned configurations, structured documentation, and evidence artifacts accompany most major changes.

## Core Environment

The lab currently consists of:
- Virtualization Host: Debian 13 workstation running KVM/QEMU with virt-manager
- Firewall/Gateway: pfSense
- Server Infrastructure: Windows Server 2022 (Active Directory Domain Services)
- Workstations: Windows 11, Kali Linux
- Security Infrastructure: Wazuh Manager on Ubuntu
- Tooling: Sysmon, nftables, Wireshark, ClamAV, Lynis, systemd-timer maintenance suite
- All systems operate on an internal network with controlled outbound access. Kali maintains limited external connectivity to support testing and simulation without exposing the rest of the environment.

## Design Philosophy

The lab is built around several foundational principles:

- Transparency — Real configurations, real fixes, and real failures are documented.
- Reproducibility — Scripts, configs, and system behaviors are version-controlled.
- Security-by-default — Minimal services exposed, strict firewalling, and hardened hosts.
- Operational accuracy — Configurations match realistic enterprise practices, not shortcuts.
- Iterative refinement — Systems evolve as understanding deepens and requirements change.

This repository reflects that process—not just the final state, but the engineering behind it.

## Repository Structure
```
cybersecurity-homelab/
│
├── docs/                       # Architecture, walkthroughs, and project documentation
│   ├── linux-migration/        # Debian 13 workstation rebuild & hardening
│   ├── homelab-projects/       # Security exercises, simulations, IR workflows
│   ├── network-design/         # Network diagrams, segmentation plans, firewall logic
│   ├── windows/                # Windows Server + Windows 11 configurations
│   ├── wazuh/                  # SIEM setup, rules, and detection tuning
│   └── policies/               # Security policies and standards
│
├── artifacts/                  # Logs, exported configs, screenshots, and evidence
├── scripts/                    # Bash/Python tooling and automation
└── README.md
```

## Current Capabilities

The environment currently supports:

- Highly controlled KVM-based virtualization with multiple bridged networks
- Hardened Debian host with a complete nftables ruleset
- Automated maintenance via systemd timers (updates, log cleanup, disk checks, security scans)
- Centralized log collection and monitoring through Wazuh
- Windows Event Visibility enhanced with Sysmon
- Packet analysis workflows using Wireshark
- Controlled offensive testing using Kali

Most subsystems are fully functional, and their configurations are captured within the repository.

### Work in Progress

The networking layer is in active development—static addressing, pfSense routing, and VM communication paths are being finalized. Windows Server is provisioned and awaiting further domain services configuration. Documentation updates are ongoing as each subsystem reaches a stable state.

## Future Roadmap

Focus areas for continued development include:

- Automated detection tuning for Wazuh
- Building structured rules, alert-quality improvements, and automated workflows for evaluating detection efficacy.
- Red-team attack chain simulations
- Executing controlled adversarial sequences to generate telemetry, validate defensive configurations, and map detections to MITRE ATT&CK.

Additional roadmap items will be added only after the baseline environment is fully completed and documented.
