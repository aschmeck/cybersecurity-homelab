# 🛡️ Kali Linux VM Configuration – Homelab Setup

This document outlines the setup of my Kali Linux VM as part of my cybersecurity homelab. Kali serves as the **attacker machine** for running reconnaissance, exploitation, and red team simulations. This machine has both a static internal IP and a bridged adapter for internet access.

---

## 💻 Overview

- **OS**: Kali Linux (latest rolling release)
- **Use Case**: Penetration testing and offensive operations
- **Network Configuration**:
  - `eth0`: Bridged adapter (internet access, dynamic)
  - `eth1`: Internal network (static IP, for isolated comms)

---

## 📡 Part 1: Configuring Static IP on Internal Adapter

Kali is connected to both an external and internal network. The internal adapter is used to simulate attacks on isolated targets (e.g., Windows or Ubuntu VMs in the homelab).

### 🔧 Step-by-Step:

1. Identify interfaces:
   ```bash
   ip a
   ```
   - `eth0`: Bridged connection (internet)
   - `eth1`: Internal connection (to be statically configured)

2. Create or edit a network config file for the internal adapter:

   File: `/etc/network/interfaces.d/eth1`

   ```bash
   sudo nano /etc/network/interfaces.d/eth1
   ```

   Add:
   ```bash
   auto eth1
   iface eth1 inet static
     address 192.168.56.10
     netmask 255.255.255.0
     gateway 192.168.56.1
     dns-nameservers 1.1.1.1 8.8.8.8
   ```

3. Restart networking service:
   ```bash
   sudo systemctl restart networking
   ```

4. Confirm the new address:
   ```bash
   ip a
   ```


---

## 🌐 Bridged Internet Connection

No additional configuration was necessary for `eth0`, which remains managed via DHCP through the bridged VirtualBox adapter.

This allows Kali to:
- Download tools and updates from the internet
- Connect to external servers if needed (e.g., C2 infrastructure)
- Perform live scans using real-world networking

---

## 🧪 Final Testing

To verify configuration:

- Ping internal VMs (e.g., Wazuh Manager or Windows VM):
  ```bash
  ping 192.168.56.30 (Ubuntu Server)
  ```

- Confirm outbound internet access:
  ```bash
  ping google.com
  ```

---

## ✅ Summary

This Kali Linux VM is a key offensive component of my homelab, allowing me to:

- Simulate attacks against internal assets
- Validate Wazuh’s detection and alerting
- Build and test exploits safely in an isolated virtual network

Its dual-network setup enables flexible offensive operations with both isolation and internet access.

---
