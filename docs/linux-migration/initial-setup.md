# Debian 13 Workstation Migration and Hardening

This entry documents the installation, configuration, and hardening of a Debian 13 workstation migrated from Windows 11. The purpose of this migration was to establish a secure, transparent, and controllable daily-driver environment suitable for administrative work, development, and personal cybersecurity research.

## Section 1 — Pre-Migration Planning and Verification

The migration began with a deliberate transition away from Windows 11 toward an open-source platform emphasizing transparency, reduced telemetry, and long-term stability. Debian’s predictable release cycle and minimal background processes made it the preferred foundation.

To ensure the distribution met functional needs, several desktop environments were evaluated. Xfce was selected for its low resource usage, high configurability, and stability. Browser compatibility was confirmed through testing Ungoogled Chromium extensions with Debian repositories while retaining Firefox ESR for compatibility and future testing work.

### Hardware and Driver Verification

Prior to installation, full hardware profiling was performed within Windows to ensure component compatibility and avoid unsupported drivers.
```powershell
Get-PnpDevice -Class Display,Net,Sound,Keyboard,Mouse | Format-Table -AutoSize
Get-WmiObject Win32_Processor | Select-Object Name, VirtualizationFirmwareEnabled
```
Key steps completed:

- Logged hardware results and compared component support against Debian documentation
- Created a complete Windows system image backup and cloud copy via OneDrive
- Wrote the verified Debian ISO to USB using Rufus (GPT + UEFI mode)
- Confirmed virtualization support and driver compatibility

This pre-deployment stage established an evidence-based baseline ensuring that every decision was deliberate, defensible, and measurable.

## Section 2 — Installation and Encryption
Debian 13 was installed using guided partitioning with LUKS2 full-disk encryption on the root volume. Selected packages included the Xfce desktop environment, OpenSSH server, and necessary system utilities.

### Installation Process

1. Booted from the verified installation media and selected graphical install
2. Configured locale, keyboard, and timezone for accurate logging
3. Created a non-root administrative user for daily operations
4. Enabled full-disk encryption to support later forensic imaging and security auditing
5. Confirmed Secure Boot and disk encryption status before reboot

### Post-Install Sanity Checks
After first login, terminal verification ensured system integrity and baseline correctness:
```bash
sudo apt update
sudo apt full-upgrade -y
uname -r
cat /etc/debian_version
hostnamectl
```

### Findings:

- Kernel version and architecture confirmed via uname and hostnamectl
- Secure Boot and encrypted boot functioning correctly
- Minor peripheral adjustments required (volume keys) but all components operational

### Artifacts Included

| Artifact | Description |
|------------------------|---------------------------------------------------|
| install_log.txt | Installer summary from /var/log/installer/ |
| hash_verification.txt | SHA-256 verification of Debian ISO |
| dmesg_init.txt | Initial boot log confirming no driver failures |
| apt_first_run.log | Output from first update and upgrade sequence |

## Section 3 — Post-Install Configuration and Hardening
Objective: convert the clean Debian install into a hardened, maintainable workstation with reduced service exposure and clear administrative controls.

### Essential Package Installation

Installed minimal tools required for daily administration:

```bash
sudo apt install -y neovim mousepad xfce4-screenshooter qalculate-gtk git curl wget
```

### Rationale:

- neovim and mousepad: lightweight editors for administrative and user tasks
- git: version control for configuration tracking
- curl and wget: automation and remote file retrieval
- Minimalist approach preserved performance and reduced the attack surface

### Secure Mail Configuration
Thunderbird was configured for encrypted mail using IMAPS and SMTPS, with OpenPGP enabled for signing and encryption. Plugins were restricted to trusted sources to reduce risk.

### Firewall Deployment and Hardening
nftables was implemented as the primary host firewall to enforce a strict deny-by-default policy.

### Initial setup:
```bash
sudo apt install -y nftables
sudo systemctl enable --now nftables
```
### Intended behavior:
- Allow loopback
- Allow established/related traffic
- Allow ICMP (v4 and v6)
- Permit DHCP
- Deny all inbound traffic by default
- Drop SSH (tcp/22) on all external interfaces
- Keep SSH available on localhost only

### Unexpected Behavior and Root Cause

Despite correct rules, Nmap scans still showed port 22 as open.
Investigation revealed that firewalld, active by default, injected its own nftables chains, including an early-order rule:
```nft
tcp dport 22 accept
```
This rule was evaluated before my drop rule, which allowed SSH traffic through despite the deny-by-default policy.

### Resolution

firewalld was removed to eliminate silent rule overrides:
```bash
sudo systemctl disable --now firewalld
sudo apt remove -y firewalld
```
SSH isolation was then enforced with interface-specific filtering:
```bash
sudo nft add rule inet filter input iif "<interface>" tcp dport 22 drop
```
*Replace `<interface>` with the name of your wireless interface.*

External scans confirmed SSH as filtered, while local access remained intact.
The finalized ruleset was saved:
```bash
sudo sh -c 'nft list ruleset > /etc/nftables.conf'
```
### Shell and Desktop Optimization
```bash
sudo apt install -y zsh
chsh -s /usr/bin/zsh $USER
```
Xfce panel, keyboard shortcuts, and menu organization were refined to streamline administrative workflow without increasing background processes.

### Security and Auditing Tools
```bash
sudo apt install -y lynis clamav clamav-daemon
sudo systemctl enable --now clamav-daemon
sudo freshclam
sudo lynis audit system
```
Artifacts generated:
- nftables.conf
- clamav_scan.log
- ssh_daemon_state.txt
- sysctl_hardening.txt

## Section 4 — Automated Maintenance Suite
### Objective: implement self-maintaining system hygiene using systemd timers and lightweight scripts.
#### Overview of Timers

| Category | Frequency | Purpose |
|-------------------------------|-----------|-------------------------------------------|
| System Updates | Daily | Apply patches and upgrades |
| Log Management | Daily | Prevent log bloat through rotation/cleanup |
| Disk Monitoring | Daily | Alert if usage exceeds safe thresholds |
| Backups | Daily | Preserve configuration and user data |
| Temporary File Cleanup | Weekly | Clear stale data in /tmp |
| Security Audits | Weekly | Run malware and vulnerability scans |
| Service Health Checks | Weekly | Detect failed or degraded systemd units |
| Package Integrity Verification| Weekly | Validate package integrity |
| Log & Config Archiving | Monthly | Compress and rotate historical logs |

### Example Timer Definitions
#### System Updates

| Timer | Command | Purpose |
|------------------------|--------------------------------------------------------------------|---------------------------------------------|
| daily-update.timer | /usr/bin/apt update && /usr/bin/apt full-upgrade -y | Continuous patching; logs stored under /var/log/maintenance/ |
| daily-logcleanup.timer | find /var/log -type f -name "*.log" -mtime +30 -delete | Maintain one-month audit retention |
| daily-diskcheck.timer | `df -h \| awk '$5+0 > 80 {print $0}'` | Alert when disk usage exceeds safe thresholds |



## Final Result
The Debian 13 workstation now operates as a secure, maintainable, and encrypted daily-use environment. The system is hardened through nftables, log management, automated patching, and regular audit cycles, all supported by a verifiable installation process and minimal service exposure.
### Artifacts Included
| Evidence | Description |
|------------------------|--------------------------------------|
| final_system_audit.txt | Combined Lynis + ClamAV summary |
| nftables_final.conf | Locked, versioned firewall ruleset |
| systemd_timer_list.txt | Active maintenance timers |
| metrics_summary.md | Resource usage statistics |

