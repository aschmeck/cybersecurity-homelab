# Threat Detection Engineering – Practical Experience via TryHackMe SOC1 Path

As part of my training toward a SOC Analyst role, I spent time working through four introductory rooms in TryHackMe’s SOC Level 1 Analyst Certificate Path, following a productive morning spent managing my personal Homelab. These rooms simulated key responsibilities in malware detection and defense response. While the labs used guided environments, I made a deliberate effort to map each task to real-world application scenarios, showing how theoretical simulations translate into operational skills.

---

## Room 1: Simulated Malware Defense Scenario

### Lab Scenario

I was placed in the role of a SOC Analyst for a fictional organization enhancing its malware detection posture. I was given staged malware samples (`sample1.exe` through `sample6.exe`), each with a specific behavior or indicator, and I had to block or monitor them using built-in GUI tools:

- Hash Management  
- Firewall Manager  
- DNS Filter  
- Sigma Rule Builder (a GPT-based assistant)

For each sample, I applied a layered defense method within the lab, and I identified how those techniques would be adapted in enterprise-grade environments.

---

### Sample1.exe – Hash-Based Detection

- **What I did in the lab**: Used the SHA256 hash of the file to create a detection rule through the lab's GUI interface. Triggered an alert when that specific hash was encountered.  
![image](https://github.com/user-attachments/assets/57306263-80b3-41bf-a463-2e9d98b59b52)


- **Theoretical concept**: Signature-based detection using known malicious hashes to flag malware.

- **Real-world application**: Hash checks can be scripted or integrated into EDR/XDR solutions. However, hash-only detection is brittle—slight file changes produce different hashes (polymorphism).

- **Windows**: Use PowerShell or endpoint protection solutions.  
![image](https://github.com/user-attachments/assets/3d522b2a-7e0c-4639-b04c-6320579edca0)


- **Linux**: Employ sha256sum checks in cronjobs or SIEM integrations.  
![image](https://github.com/user-attachments/assets/875f1c81-1bd3-4fca-bb64-c4de820bf846)

---

### Sample2.exe – IP-Based Blocking

- **What I did in the lab**: Created a firewall rule using the lab GUI to block a known malicious IP address.  
![image](https://github.com/user-attachments/assets/1c337084-fc88-42c0-a45c-a8da86c3680c)


- **Theory behind the task**: Network-layer blocking using IP reputation or intelligence.

- **Practical translation**: IPs can be blocked using system-level firewalls or NAC policies.

- **Windows**: New-NetFirewallRule via PowerShell.  
![image](https://github.com/user-attachments/assets/efc66bd7-1fde-4c7d-800f-2a2e1943671c)


- **Linux**: iptables or UFW rules.  
![image](https://github.com/user-attachments/assets/12242706-ce7f-493f-b529-846fa457fee0)

![image](https://github.com/user-attachments/assets/3f175357-ce2f-4101-ae5a-044a59250634)


- **Real-world note**: Malicious actors often rotate IPs, so this is best paired with behavioral indicators.

---

### Sample3.exe – Domain Blocking and DNS Filtering

- **What I did in the lab**: Blocked a threat domain using the DNS Filter GUI in the platform.  
![image](https://github.com/user-attachments/assets/5a3e79f8-3ad4-43bc-856d-7f0ea3d4f6e9)


- **Theory**: Malware commonly uses domain names instead of hardcoded IPs. Blocking at the DNS level prevents resolution to malicious infrastructure.

- **Production techniques**:
  - **Windows**: Modify hosts file, deploy DNS Sinkhole with Windows Defender Firewall, use Sysmon Event ID 22 to monitor DNS queries.
  - **Linux**: Use tools like dnsmasq or configure custom DNS resolvers; integrate threat feeds from Abuse.ch for automation.

---

### Sample4.exe – Registry Modification Monitoring

- **What I did in the lab**: Created a Sigma rule to generate alerts if malware attempted to modify critical registry keys.

- **Simulated tactic**: Persistence through disabling security via registry edits.  
![image](https://github.com/user-attachments/assets/e8c10ac2-9454-435c-b080-7bb71848027d)

- **MITRE ATT&CK Mapping**:
  - **Technique ID**: T1112 – Modify Registry
  - **Tactics**: Defense Evasion, Persistence

- **Explanation**: Adversaries use registry modifications to disable defenses, establish persistence, or hide malicious activity. Your detection rule directly targets this behavior.

- **How it maps to production**:
  - **Windows**: Enable Sysmon (Event ID 13) for registry tracking, apply `auditpol` + configured SACLs on sensitive keys.
  - **Linux**: Use Auditd to monitor configuration files and directories; optionally supplement with inotify.

> Monitoring registry or system config changes is crucial in detecting stealthy persistence tactics.

---

### Sample5.exe – Network Behavior Analysis for Exfiltration

- **What I did in the lab**: Logs presented multiple outbound connections. Initially misleading, the malware consistently exfiltrated data to a single IP every 30 minutes.  
![image](https://github.com/user-attachments/assets/db47a307-8f43-4aa4-a3e9-d044cb43cd6c)


- **My task**: Identify and alert on this behavior.  
![image](https://github.com/user-attachments/assets/17606393-e607-469b-a56c-096040d444f1)


- **MITRE ATT&CK Mapping**:
  - **Technique ID**: T1041 – Exfiltration Over C2 Channel
  - **Tactic**: Exfiltration

- **Explanation**: This technique involves adversaries exfiltrating data over an existing command and control (C2) channel, often using the same protocols and infrastructure as their C2 communications to avoid detection.

- **Production strategy**:
  - Use network telemetry to detect unusual outbound patterns, such as consistent large uploads to a known or unknown destination.
  - **Windows**: Monitor with Sysmon (Event ID 3) and SIEM correlation rules.
  - **Linux**: Use `tcpdump`, `ss`, `nftables`, or custom scripts.
  - Combine with time-based detection and volume heuristics to identify exfiltration attempts.

---

### Sample6.exe – File Creation Pattern Detection

- **What I did in the lab**: I noticed malware consistently created files in a specific directory. I set up a rule using the Sigma Rule Builder to alert on this path-based activity.  
![image](https://github.com/user-attachments/assets/67c70c41-ff2b-4b30-9c2a-06cb9793ad09)


- **Theory in action**: Behavior-based detection using known TTP patterns.  
![image](https://github.com/user-attachments/assets/d79c5a77-f099-43b4-9e81-fd9dcf637a10)


- **MITRE ATT&CK Mapping**:
  - **Technique ID**: T1055 – Process Injection (if the file was used to inject into another process)
  - **Alternative Technique**: T1105 – Ingress Tool Transfer (if the file was a downloaded payload)
  - **Also relevant**: T1074.001 – Local Data Staging (if the file was being staged for exfiltration)
  - **Tactics**: Execution, Persistence, Defense Evasion, Collection

- **Explanation**: The malware’s repeated use of a specific file path suggests a predictable behavior pattern, which aligns with Local Data Staging or Ingress Tool Transfer.

- **Real-world implementation**:
  - **Windows**: Sysmon’s Event ID 11 (file creation) and Event ID 12 (file modification); Group Policy Object (GPO) settings for auditing specific directories.
  - **Linux**: Auditd rules or `inotifywait` for real-time response.

- Map against MITRE ATT&CK techniques to create contextual detection logic.

---

## Summary

This exercise allowed me to practice converting technical signals (e.g., hashes, IPs, domains, file system activity) into structured detection and prevention rules, using a combination of theoretical detection concepts, lab-based simulations, and real-world implementation strategies. Each stage not only reinforced my practical tooling knowledge (Sysmon, auditd, IPTables, etc.), but also deepened my understanding of TTPs, layered defense mechanisms, and proactive threat hunting.
