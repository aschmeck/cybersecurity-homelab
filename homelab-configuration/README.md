
# 🛡️ Cybersecurity Homelab – Entry-Level Portfolio

Welcome to my cybersecurity homelab repository. This project demonstrates my hands-on experience building and managing a simulated enterprise environment for blue team monitoring and red team simulation. It serves as a portfolio to showcase my technical capabilities as I pursue an entry-level role in cybersecurity.

---

## 🎯 Objectives

- Build a fully virtualized, networked environment for cybersecurity testing
- Implement and document real-world SIEM, detection, and response tools
- Simulate attacks and analyze detection effectiveness
- Gain hands-on experience with log management, monitoring, and threat hunting

---

## 🧱 Lab Architecture

| Role         | OS            | Description                              | Network Setup                |
|--------------|---------------|------------------------------------------|------------------------------|
| 🔎 SIEM       | Ubuntu 24.04  | Wazuh Manager, Indexer, and Dashboard     | Static IP (Internal Only)    |
| 🪟 Endpoint   | Windows 11    | Wazuh Agent, logs critical events         | Static IP (Internal Only)    |
| ⚔️ Attacker   | Kali Linux    | Penetration testing and red team tools    | Static IP (Internal) + DHCP (Bridged) |
| 🧰 Host       | Windows 11    | Physical host machine running VirtualBox  | Bridged                      |

---

## 🔧 Key Technologies

- **Wazuh** – Open-source SIEM for log analysis, file integrity monitoring, and intrusion detection
- **Netplan** – Static IP configuration for Ubuntu
- **Event Viewer** – Windows logging configuration for security and system monitoring
- **Nmap, Nikto, Hydra** – Recon and exploitation tools via Kali
- **VirtualBox** – Virtualization platform used to host all VMs

---

## 📂 Documentation

Each machine is documented in detail, including screenshots, commands, and configuration files:

- [`ubuntu-config.md`](./ubuntu-config.md)
- [`windows-wazuh-setup.md`](./windows-wazuh-setup.md)
- [`kali-setup.md`](./kali-setup.md)

---

## 🔬 Next Steps

- Add additional log sources (e.g. Sysmon, WinDefender, Linux Audit)
- Simulate brute-force, privilege escalation, and persistence techniques
- Tune Wazuh rules and build detection dashboards
- Document incident response and detection analysis workflows

---

## 🧠 Learning Goals

- Develop blue team detection skills
- Build evidence of hands-on lab experience
- Prepare for SOC Analyst and Threat Detection roles
- Align experience with NIST CSF and real-world detection engineering

---


## 📜 License

This project is open for educational use and personal development. Feel free to fork and build upon it in your own cybersecurity journey.

---
