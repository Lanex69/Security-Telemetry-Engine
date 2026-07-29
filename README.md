# Security Telemetry Engine

## Evaluating Cross-Layer Host–Network Telemetry Correlation in a Reproducible SOC Testbed

**Author:** Syed Ahsan Ahmed  
Department of Computer Science Engineering  
Lords Institute of Engineering and Technology

![Status](https://img.shields.io/badge/status-research--ready-blue)
![Research](https://img.shields.io/badge/type-research-success)
![SOC](https://img.shields.io/badge/domain-SOC-2ea44f)
![Wazuh](https://img.shields.io/badge/SIEM-Wazuh-7A3EFF)
![Zeek](https://img.shields.io/badge/network-Zeek-1E90FF)
![Sysmon](https://img.shields.io/badge/host-Sysmon-red)
![Docker](https://img.shields.io/badge/deployment-Docker-2496ED)
![License](https://img.shields.io/badge/license-MIT-brightgreen)

---

##  Research Paper

This repository accompanies the research paper:

> **Evaluating Cross-Layer Host–Network Telemetry Correlation in a Reproducible SOC Testbed**

The project presents a controlled empirical evaluation of SIEM-level host–network telemetry correlation using a reproducible Security Operations Center (SOC) testbed built with **Wazuh**, **Sysmon**, and **Zeek**.

Unlike traditional IDS research, this work does **not** introduce a new detection algorithm. Instead, it isolates **cross-layer telemetry correlation** as the independent architectural variable and evaluates its operational impact on:

- Detection performance
- Detection latency
- Alert consolidation
- Correlation window sensitivity
- Framework robustness under telemetry degradation

---

#  Architecture

<p align="center">
<img src="images/architecture.png" width="900">
</p>

The experimental environment consists of:

| Component | Purpose |
|-----------|---------|
| 🐧 Parrot Security | Attack generation |
| 🪟 Windows 11 + Sysmon | Host telemetry |
| 🔍 Zeek Sensor | Network telemetry |
| 🛡 Wazuh Stack | SIEM, indexing and visualization |

---

#  Key Experimental Results

| Metric | Result |
|---------|--------|
| Raw Telemetry | **53 Events** |
| Correlated Incidents | **4** |
| Alert Consolidation Ratio | **92.45%** |
| True Positive Rate | **100%** |
| Detection Configurations | Host • Network • Cross-layer |
| Correlation Windows | 10 s • 30 s • 60 s |

---

#  Repository Structure

| Path | Description |
|------|-------------|
| attacks/ | Attack scripts and execution workflow |
| detections/ | Detection rules and correlation artifacts |
| docs/ | Research summary and documentation |
| images/ | Architecture diagrams, screenshots and figures |
| scripts/ | Automation and experiment scripts |
| README.md | Project overview |

---

#  Research Objectives

This work experimentally evaluates:

- Host-only detection
- Network-only detection
- Cross-layer correlated detection
- Detection latency
- Alert Consolidation Ratio (CR)
- True Positive Rate (TPR)
- False Positive Rate (FPR)
- Correlation window sensitivity (Δt)
- Robustness under partial telemetry loss

---

#  Testbed Status

| Component | Status |
|-----------|--------|
| Parrot Attacker | ✅ |
| Windows 11 + Sysmon | ✅ |
| Wazuh Docker Stack | ✅ |
| Zeek Sensor | ✅ |
| Host Telemetry | ✅ |
| Network Telemetry | ✅ |
| Correlation Framework | ✅ |
| Experimental Evaluation | ✅ |
| Research Paper | ✅ |

---

#  Screenshots

## Wazuh Dashboard

<p align="center">
<img src="images/wazuh-active-agent.png" width="850">
</p>

---

## Zeek Telemetry

<p align="center">
<img src="images/working-zeek-logs.jpg" width="850">
</p>

---

#  Documentation

-  Research Paper
-  One-page Research Summary
-  Ethics Statement
-  Architecture Diagram
-  Medium Blog
-  Substack Blog

---

# 📈 Experimental Workflow

1. Deploy reproducible SOC environment
2. Generate controlled attack scenarios
3. Collect host telemetry
4. Collect network telemetry
5. Perform cross-layer correlation
6. Evaluate operational metrics
7. Analyze architectural trade-offs

---

#  Intended Audience

This repository is designed for:

- Cybersecurity researchers
- SOC engineers
- Detection engineers
- Graduate and undergraduate students
- Reviewers evaluating reproducibility


#  License

Released under the MIT License.

---

##  Citation

If you use this repository in your research, please cite the accompanying paper.

```bibtex
@misc{Ahmed2026,
  author={Syed Ahsan Ahmed},
  title={Evaluating Cross-Layer Host--Network Telemetry Correlation in a Reproducible SOC Testbed},
  year={2026}
}
```
