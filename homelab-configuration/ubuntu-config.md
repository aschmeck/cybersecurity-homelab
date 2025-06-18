🐧 Ubuntu 24.04 LTS – Wazuh Manager Setup
This document outlines the configuration of an Ubuntu 24.04 virtual machine as the centralized Wazuh SIEM manager in my homelab. It collects, analyzes, and visualizes logs from monitored endpoints.

📡 Static IP Configuration (Internal Network)
To ensure stable communication over the internal VirtualBox network, I configured a static IP using netplan.
🔧 Configuration Details
- Interface: enp0s8
- Static IP: 192.168.56.30/24
- Gateway: 192.168.56.1
- DNS: 1.1.1.1, 8.8.8.8
📁 Netplan YAML Example
network:
  version: 2
  ethernets:
    enp0s8:
      dhcp4: false
      addresses:
        - 192.168.56.30/24
      gateway4: 192.168.56.1
      nameservers:
        addresses: [1.1.1.1, 8.8.8.8]


Apply the config:
sudo netplan apply


✅ Verified VM-to-VM communication using ping.

🛠️ Wazuh Manager Installation
Used the official all-in-one installer for Wazuh 4.12.0, which sets up:
- Wazuh Manager
- OpenSearch Indexer
- Wazuh Dashboard (web UI)
📥 Installation Steps
curl -sO https://packages.wazuh.com/4.12/wazuh-install.sh
sudo bash ./wazuh-install.sh -a


Check service status:
sudo systemctl status wazuh-manager


Access the dashboard at:
https://192.168.56.30
Use the admin credentials displayed after install.
📸 Screenshot tip: Include a capture of the Wazuh Dashboard after login for visual context.


🔑 Adding Windows Agent
To onboard a Windows 11 VM as an agent:
- On the Wazuh Manager:
sudo /var/ossec/bin/manage_agents
- Add a new agent → assign a name → copy the registration key.
- On the Windows VM:
agent-auth.exe -m 192.168.56.30 -k <paste-key>
- Confirm connection:
sudo /var/ossec/bin/agent_control -l


✅ Agent status should move from Never connected to Active once logs start flowing.

📊 Dashboard Verification
The Wazuh Dashboard displays incoming logs and alerts in real time.
Tested Sources:
- Windows Event Logs (Security, System, Application, PowerShell)
- Simulated Nmap scans from Kali VM

✅ Summary
This Ubuntu VM now serves as the heartbeat of my homelab SIEM stack:
- Runs the full Wazuh stack (Manager, Indexer, Dashboard)
- Ingests logs from internal hosts
- Detects real-world attack simulations
- Demonstrates effective log analysis and detection engineering in action

Want help whipping up an architecture diagram or ASCII network map next? I’ve got some artistic flair to spare 🎨👨‍💻
Just say the word.
