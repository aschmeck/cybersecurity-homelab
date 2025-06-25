# 🛡️ Cyber Threat Intelligence: Concepts, Classifications, and Frameworks

As part of my cybersecurity learning journey, I completed two rooms related to **Cyber Threat Intelligence (CTI)**—a critical domain focused on understanding adversaries and defending digital assets through actionable insights. The first room was focused on theory and understanding, while the second had tools and practical exercises.

## 🧠 From Data to Intelligence
- **Data**: Raw adversary-linked elements (IP addresses, file hashes).
- **Information**: Contextual groupings (e.g., frequency of access to malicious domains).
- **Intelligence**: Correlated insights that uncover adversary patterns and drive defense strategies.

## 🎯 CTI’s Core Objective
To establish a robust defense posture by answering:
- Who is attacking?
- What are their motives and capabilities?
- Which Indicators of Compromise (IOCs) signal their presence?

## 🛰️ Intelligence Sources
- **Internal**: Logs, incident reports, training results
- **Community**: Open forums, dark web monitoring
- **External**: Threat feeds (open/commercial), government data, social media, etc.

## 🧩 Classifications of Threat Intelligence
- **Strategic**: High-level trends influencing business risk
- **Technical**: Detailed IOCs used for baseline detection
- **Tactical**: Adversary TTPs to reinforce controls
- **Operational**: Insights on specific threats and intent

## 🔁 The Threat Intelligence Lifecycle
1. **Direction**: Define business-critical assets and threat models
2. **Collection**: Aggregate data using automated tooling
3. **Processing**: Correlate and format disparate logs and signals
4. **Analysis**: Derive meaning, prioritize actions, support IR
5. **Dissemination**: Tailor intel to technical teams vs. executives
6. **Feedback**: Refine CTI workflows based on stakeholder input

## 🧱 Standards & Frameworks
- **MITRE ATT&CK**: Maps adversarial behavior to TTPs
- **TAXII**: Secure threat intel exchange protocol (push/pull models)
- **STIX**: Language for standardized cyber threat expressions
- **Cyber Kill Chain**: Stages of an attack—from recon to actions on objectives
- **Diamond Model**: Visual method to analyze adversary, victim, infrastructure, and capabilities

---

## 🧰 Threat Intelligence Tools in Practice

In the second part of my CTI training, I explored hands-on tools used by SOC analysts and threat hunters to investigate and enrich threat data.

### 🔍 UrlScan.io
A web sandbox that analyzes URLs in real time. It captures screenshots, DOM content, and network requests to detect phishing, malware delivery, and suspicious redirects. In real-world use, analysts can submit suspicious links from phishing emails and inspect behaviors like spoofed login forms or obfuscated JavaScript.

### 🧪 Abuse.ch Platforms
A suite of open-source threat intel platforms:
- **Malware Bazaar**: Repository for malware samples, searchable by hash, signature, or YARA rules.
- **Feodo Tracker**: Tracks botnet C2 infrastructure for malware like Dridex, Emotet, and QakBot.
- **SSL Blacklist (SSLBL)**: Identifies malicious SSL certificates and JA3 fingerprints used in encrypted C2 traffic.
- **URLHaus**: Shares URLs used for malware distribution.
- **ThreatFox**: Community-driven IOC sharing platform with exportable feeds for SIEMs and IDS tools.

These platforms are invaluable for enriching alerts, blocking malicious infrastructure, and correlating malware campaigns.

### 📨 PhishTool
A phishing analysis platform that extracts metadata from emails and attachments. It integrates OSINT and threat intel to reverse engineer phishing attempts. In a SOC setting, it helps analysts triage user-reported emails, identify spoofed domains, and generate forensic reports.

### 🧠 Cisco Talos Intelligence
One of the largest commercial threat intel teams. Talos provides:
- IP/domain/file reputation lookups
- Vulnerability advisories with Snort rules
- Global telemetry on malware and spam trends

It's used to enrich alerts, validate IOCs, and understand threat actor infrastructure and behavior.

### 🧬 VirusTotal
A multi-engine malware scanning platform that aggregates results from dozens of antivirus vendors. It also provides behavioral analysis, file relationships, and community insights. It's a go-to tool for verifying file hashes, URLs, and domains during investigations.

---

## 🧪 Real-World Scenarios

### Scenario 1: Worm Detection via VirusTotal
I extracted the hash of a suspicious email attachment and submitted it to VirusTotal. The detection alias returned was **"HIDDENEXT/Worm.Gen"**, confirming the file was malicious and likely a generic worm variant.

### Scenario 2: Dridex Malware Identification
Using the same hash-based methodology, I analyzed another email attachment and found it was associated with the **Dridex** malware family—a known banking Trojan with ties to botnet activity. This reinforced the importance of hash-based triage and threat family attribution.

---

This room helped me bridge the gap between theory and practice by applying CTI tools to real-world scenarios. It also strengthened my ability to pivot between indicators, enrich alerts, and communicate findings using industry-standard platforms.
