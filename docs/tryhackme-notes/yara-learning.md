# TryHackMe – YARA Room (SOC Level 1 Path)

In this lab, I explored the fundamentals of **YARA**—a powerful pattern-matching tool used in malware analysis, threat hunting, and digital forensics. The room guided me through writing custom YARA rules, integrating them with tools like LOKI and yarGen, and applying them to detect suspicious files in a simulated SOC environment.

## 🔍 Key Concepts Covered

- **YARA Basics**: Learned how YARA uses rules to identify patterns in files based on strings, hexadecimal values, and conditions.
- **Rule Structure**: Gained hands-on experience writing YARA rules with `meta`, `strings`, and `condition` sections.
- **String Matching**: Understood how malware often embeds readable strings (e.g., IPs, wallet addresses, commands) that can be used for detection.
- **Hexadecimal Detection**: Identified that YARA can detect base-16 (hex) patterns in binaries.

## 🛠️ Practical Tasks

### ✅ Writing and Testing YARA Rules

- Created a basic rule to detect the string `"tryhackme"` in a file.
- Used the `yara` command-line tool to scan directories and files with custom rules.
- Example:
  ```bash
  yara myrule.yar /path/to/scan


🧪 Using LOKI for Threat Detection
- Scanned suspicious files using LOKI, a scanner that leverages YARA rules.
- Detected a web shell (b374k 2.2) in file1 using the webshell_metaslsoft rule.
- Identified the matched string ($str1) and confirmed the classification as suspicious.
- Verified that file2 was initially benign but contained a newer version of the same web shell (b374k 3.2.3).
🧬 Creating Custom Rules with yarGen
- Used yarGen to generate a YARA rule for file2:
python3 yarGen.py -m /home/user/suspicious-files/file2 --excludegood -o file2.yar
- Tested the rule with both yara and loki, confirming it successfully flagged the file.
- Integrated the rule into LOKI’s signature base for future scans.
🧭 MITRE ATT&CK Alignment
While this room focused on detection rather than adversary emulation, the techniques align with:
| Tactic | Technique Example | 
| Detection | File and String Pattern Matching (Custom) | 
| Threat Hunting | Signature-Based Detection (YARA Rules) | 
| Analysis | Static File Inspection | 


🧠 Takeaways
- YARA is a flexible and powerful tool for identifying malware based on known patterns.
- Writing effective rules requires understanding both the malware’s behavior and how it manifests in files.
- Tools like LOKI and yarGen enhance YARA’s capabilities by automating detection and rule generation.

This lab strengthened my ability to write and apply YARA rules in a SOC context, reinforcing my skills in malware detection and threat hunting.
