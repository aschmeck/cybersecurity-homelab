# TryHackMe – Eviction Room (SOC Level 1 Path)

In the *Eviction* room, I assumed the role of a SOC analyst at E-corp to investigate a simulated intrusion by APT28. This scenario-driven challenge emphasized adversary emulation, threat detection, and the application of the MITRE ATT&CK framework to trace the attacker’s methodology across the cyber kill chain.

## Threat Analysis & Adversary TTPs

- **Reconnaissance & Initial Access**: The APT used *spearphishing via service* — a technique that enabled both reconnaissance and initial access by targeting specific users with crafted emails or messages.
- **Resource Development**: The attacker likely compromised *valid accounts*, such as service or administrative accounts, to establish a foothold and prepare for lateral movement.
- **Execution Techniques**:
  - *User Execution: Malicious File*
  - *User Execution: Malicious Link*
- **Scripting Interpreters Used**:
  - *Windows Command Shell (cmd.exe)*
  - *PowerShell*
- **Persistence via Registry Modification**: Obfuscated scripts modified critical registry keys:
  - `HKCU\Software\Microsoft\Windows\CurrentVersion\Run`
  - `HKLM\Software\Microsoft\Windows\CurrentVersion\Run`
- **Defense Evasion**: Scrutiny was placed on proxy execution via `rundll32.exe` — a signed binary often exploited to bypass detection.
- **Discovery Activity**: Use of `tcpdump` indicated *Network Sniffing* tactics to collect traffic data.
- **Lateral Movement**: Remote access was gained through:
  - *Remote Desktop Protocol (RDP)*
  - *Windows Admin Shares*
- **Targeted Repository**: The attacker aimed to exfiltrate intellectual property from E-corp’s *internal Confluence wiki*.
- **C2 & Exfiltration Attempt**: Though no outbound connection was made, the attacker may have attempted to leverage:
  - *Internal Proxy*
  - *Multihop Proxy*

## MITRE ATT&CK Mapping

| Tactic              | Technique Example                          |
|---------------------|--------------------------------------------|
| Reconnaissance      | Spearphishing via Service (T1566.002)      |
| Initial Access      | User Execution (T1204)                     |
| Execution           | PowerShell (T1059.001), Cmd (T1059.003)    |
| Persistence         | Registry Run Keys (T1547.001)              |
| Defense Evasion     | Signed Binary Proxy Execution (T1218)      |
| Discovery           | Network Sniffing (T1040)                   |
| Lateral Movement    | Remote Services (T1021)                    |
| Collection          | Data from Information Repositories (T1213) |
| Exfiltration        | Proxy (T1090)                              |

---

This room helped reinforce my ability to correlate endpoint artifacts with adversary TTPs and sharpened my skillset in identifying, mapping, and mitigating persistent threats using the MITRE ATT&CK framework.
