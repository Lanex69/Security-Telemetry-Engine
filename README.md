# SOC Research Testbed

**Cross-Layer Host–Network Telemetry** Correlation for Improved Intrusion Detection in Modern SOC Architectures.  
It integrates Zeek and the Wazuh Stack (Manager, Indexer, Dashboard) to analyze telemetry and measure alert noise reduction. 
A custom Python-based web-pentest toolkit is used to simulate realistic attack traffic and generate diverse telemetry.

![Status](https://img.shields.io/badge/status-research--ready-blue)  ![SOC](https://img.shields.io/badge/domain-SOC-success) ![Telemetry](https://img.shields.io/badge/focus-telemetry--correlation-orange) ![Zeek](https://img.shields.io/badge/network-Zeek-9cf)  ![License](https://img.shields.io/badge/license-MIT-green) [![Wazuh](https://img.shields.io/badge/SIEM-Wazuh-purple)](https://wazuh.com)

---

## Objective

The goal of this project is to develop a reproducible and research-oriented SOC testbed that can:

- Generate and analyze realistic attack telemetry  
- Detect and correlate multi-stage attacks  
- Measure alert noise and evaluate prioritization methods  
- Explore improvements in detection accuracy and analyst efficiency  

---

## Current Lab Architecture

| Component | Role | Status |
|------------|------|--------|
| Parrot OS | Attacker VM (offensive testing) | Completed |
| Windows 11 | Victim VM with Sysmon + Wazuh Agent | Completed |
| Wazuh Manager | Docker Stack Deployed, Host & Network Agents Linked |  Completed |
| Zeek | Network telemetry and log enrichment |  Completed |


---

### Active Agent in Wazuh Dashboard
![Active Agent](images/wazuh-active-agent.png)

### Zeek Sensor Working
![Zeek Logs](images/working-zeek-logs.jpg)

### Architecture Diagram
![Architecture](images/architecture.png)


**Network topology**  
- Internal network (10.0.0.0/24) for telemetry collection  
- NAT interface for pulling Docker updates and accessing the Wazuh Dashboard from the host.

  
**Status Update (Nov 2025)**

| Component                     | Status                                      |
|------------------------------|----------------------------------------------|
| Attacker VM                  | Completed                                    |
| Windows 11 Victim            | Completed (Sysmon + Wazuh Agent)             |
| SIEM (Wazuh Stack via Docker)| Completed                                    |
| Agent Enrollment             | Successful (1 Active Agent)                  |
| Zeek Sensor                  | Completed (Network telemetry connected to Wazuh) |

---

## Research Focus Areas

This project investigates how multi-source telemetry correlation can improve detection fidelity and reduce SOC analyst workload.  
The primary research areas include:

- Correlation between host and network telemetry  
- Reducing false positives in SOC environments  
- Measuring detection latency and alert volume reduction  

**Planned evaluation metrics**

- True Positive Rate (TPR) and False Positive Rate (FPR)  
- Detection latency (event to alert time)  
- Alert volume before and after correlation  
- Severity and prioritization scores

This testbed is designed primarily for controlled academic experiments rather than production SOC deployment.

---

## Attack Scenarios

| Attack | Description | Status | Detection |
|---------|--------------|---------|-----------|
| SSH Brute Force | Hydra-based SSH brute force | Planned | Pending|
| Directory Fuzzing | Gobuster-based web enumeration | In progress | Pending |
| DNS Tunneling | Data exfiltration via nslookup or iodine | Planned | Pending |
| Privilege Escalation | PowerShell-based local privilege escalation | Planned | Pending |

Detailed steps, logs, and detection artifacts are documented under the [attacks/](attacks/) directory.

---

## Preliminary Results (Work in Progress)

| Metric | Before Correlation | After Correlation | Observation |
|---------|--------------------|-------------------|--------------|
| Average Alerts | - | - | - |
| False Positives | - | - | - |
| Detection Latency | - | - | - |

Results section will be updated after experiments begin.
Quantitative data will be updated after each experiment.

---

## Related Work

**Web-Pentest Toolkit (Attack Generator)**  
https://github.com/Lanex69/vulnerability-scanner

---

## Documentation and Reports

- [Research Summary(PDF)](docs/Research-Summary.pdf)  
- [Ethics Statement](ETHICS.md)  
- [Architecture Diagram v2](images/architecture.png)  
- Blog Series – Part 1: Building the Mini SOC  
   [Medium Version](https://medium.com/@syedahsanahmed04/building-a-mini-soc-research-testbed-my-journey-into-security-telemetry-c49f94c58a65) | [Substack Version](https://zerodayahsan.substack.com/p/building-a-mini-soc-research-testbed)


---

## Research Insights

Preliminary findings indicate that correlating host and network telemetry reduces redundant alerts and improves SOC triage efficiency.  
Future work includes integrating a lightweight ML-based alert scoring module and exploring automated severity assignment.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
