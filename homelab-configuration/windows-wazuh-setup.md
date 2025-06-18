# 🛡️ Windows 11 VM Configuration for Wazuh Agent – Homelab Setup

This document outlines the steps I took to configure my Windows 11 VM as a log source for Wazuh in my homelab. It includes setting a static IP address, installing and registering the Wazuh agent, and configuring log collection from Windows event channels.

---

## 📡 Part 1: Configuring Static IP for Internal Network

The Windows 11 VM is part of an internal VirtualBox network and is assigned a static IP to communicate reliably with the Wazuh manager hosted on the Ubuntu VM.

### 🛠️ Steps:

1. Open **Control Panel → Network and Sharing Center → Change Adapter Settings**

2. Right-click on the internal adapter (e.g., `Ethernet 2`) → **Properties**

3. Select `Internet Protocol Version 4 (TCP/IPv4)` → Click **Properties**

4. Enter static IP details:
   - IP Address: `192.168.56.20`
   - Subnet Mask: `255.255.255.0`
   - Default Gateway: `192.168.56.1`
   - Preferred DNS: `1.1.1.1`
   - Alternate DNS: `8.8.8.8`

5. Click OK and verify with:
   ```powershell
   ipconfig
   ```

---

## 📦 Part 2: Installing and Registering Wazuh Agent

The Windows machine will forward logs to the Wazuh manager via the agent service.

### 📥 Step-by-Step Installation

1. Download the Wazuh Agent for Windows (v4.12) from the [official site](https://packages.wazuh.com/4.x/windows/wazuh-agent-4.12.0-1.msi)

2. Install the `.msi` file with default options.

3. After installation, **open Command Prompt as Administrator** and run:

```cmd
"C:\Program Files (x86)\ossec-agent\agent-auth.exe" -m 192.168.56.30 -k "the very very long key"
```

- `192.168.56.30` is the IP of the Ubuntu Wazuh Manager

4. Start the Wazuh service:

```cmd
net start WazuhSvc
```

5. Confirm connection on the manager:

```bash
sudo /var/ossec/bin/agent_control -l
```


---

## 🔍 Part 3: Configuring Windows Event Log Collection

By default, Wazuh only collects basic event logs. To expand this, I edited the configuration file to monitor key event channels.

I also saw that several event IDs were being excluded that I very much wanted to be included so I removed those from the query to ensure that I gathered the correct logs for events:
- 4670 - Permissions changed on an object.
- 5152 - Dropped packets
- 5157 - Dropped Connections
- 5447 - Firewall rules changed

Since I will be doing various pentest related activities on this VM, I wanted to be able to accurately detect and log what has been done. The end goal is to both strengthen my own skills in pentesting and defense.
```
C:\Program Files (x86)\ossec-agent\ossec.conf
```

### 🪪 Key Sections Added
![image](https://github.com/user-attachments/assets/8372c508-3084-4e70-a071-ae3e2c7d8569)

### 🔄 Restart the Agent

```cmd
net stop WazuhSvc
net start WazuhSvc
```

---

### 🧪 Log Collection Testing

To verify ingestion:

```powershell
Write-EventLog -LogName Application -Source "WazuhTest" -EntryType Information -EventId 1000 -Message "Test log for Wazuh"
```

Search the Wazuh Dashboard for the event using the `agent.name` or log ID.



---

## ✅ Summary

This Windows 11 VM is now integrated with the Wazuh SIEM, forwarding security-relevant logs for monitoring. This setup enables centralized detection and response testing across different platforms in my cybersecurity homelab.

---
