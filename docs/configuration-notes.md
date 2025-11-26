# Configuration Notes – Mini SOC Research Testbed

Purpose: Stable, reproducible lab setup for SOC investigation, Wazuh SIEM, Sysmon, and Zeek experiments.

---

# 1. Network Configuration (All VMs)

## 1.1 Internal Network Topology

**Internal Virtual Network Name:**

```
MiniSOCNet
```

**IP Scheme (Static Assignments):**

| VM                   | Role                        | IP Address | Why                                               |
| -------------------- | --------------------------- | ---------- | ------------------------------------------------- |
| ParrotOS Attacker    | Offensive Testing Node      | 10.0.0.5   | Used to attack the victim and generate telemetry. |
| Windows 11 Victim    | Host Telemetry Node         | 10.0.0.10  | Sends Sysmon + Agent logs to SIEM.                |
| Zeek Sensor          | Network Monitoring Node     | 10.0.0.20  | Will capture packet-level data.                   |
| SIEM / Wazuh Manager | Log Aggregation + Analytics | 10.0.0.30  | Central SIEM server.                              |

## 1.2 Why Static IPs Are Required

Static IPs ensure:

* Consistent log correlation.
* Wazuh Manager always knows where the agent is.
* Zeek sensors always forward to the same SIEM IP.
* Reproducible experiments and clean documentation.

## 1.3 Linux Static IP Configuration (Netplan)

Example for SIEM VM:

```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s3:
      dhcp4: false
      addresses: [10.0.0.30/24]
      gateway4: 10.0.0.1
      nameservers:
        addresses: [8.8.8.8, 1.1.1.1]
```

Apply config:

```
sudo netplan apply
```

## 1.4 Windows Static IP Configuration

1. Open **Network & Internet Settings**.
2. Adapter → Properties → IPv4.
3. Set:

   * IP Address: `10.0.0.10`
   * Subnet: `255.255.255.0`
   * Gateway: *leave empty* (internal lab)
   * DNS: `8.8.8.8` or leave empty.

## 1.5 Connectivity Testing

### Ping

```
ping 10.0.0.10
ping 10.0.0.30
```

### Traceroute (Linux)

```
traceroute 10.0.0.10
```

---

# 2. SIEM Deployment (Docker Wazuh Stack)

## 2.1 Repository Clone

```
git clone https://github.com/wazuh/wazuh-docker.git
cd wazuh-docker/single-node
```

## 2.2 Pin Version

```
git checkout v4.14.1
```

## 2.3 Certificate Generation

Required because Wazuh components refuse to run without TLS.

```
docker compose -f generate-indexer-certs.yml run --rm generator
```

This creates:

* CA certificate
* Indexer certificates
* Dashboard certificates

Stored under:

```
config/wazuh_indexer_ssl_certs/
config/wazuh_dashboard_ssl_certs/
```

## 2.4 Deploy Wazuh Stack

```
docker compose up -d
```

## 2.5 Container Roles

* **wazuh.indexer** → Stores & indexes logs.
* **wazuh.manager** → Receives agents, runs rules.
* **wazuh.dashboard** → Web UI for SIEM.

## 2.6 Verify Stack

```
docker compose ps
```

All containers must show **Up**.

## 2.7 Access Dashboard

Open browser on SIEM VM:

```
https://10.0.0.30
```

Default credentials:

* user: `admin`
* pass: `SecretPassword`

## 2.8 Why Docker Was Chosen

* Fully reproducible builds.
* Avoids dependency conflicts.
* Easy resets.
* Clean snapshot-based workflows.

---

# 3. Windows Agent Enrollment (Final Working Method)

## 3.1 What Failed

API enrollment attempts caused:

* Agent not appearing in dashboard.
* Enrollment timeouts.
* Unreliable communication.

## 3.2 Working Solution: Interactive Enrollment

Inside the Wazuh Manager container:

```
docker exec -it single-node-wazuh.manager-1 /var/ossec/bin/manage_agents
```

### Add Agent

* Name: `WIN11-VICTIM`
* IP: `10.0.0.10`

Copy the generated agent key.

### Windows Side

```
manage_agents.exe -i <agent-key>
net start wazuh
```

### Verification

* Dashboard → **1 Active Agent**
* Log file on manager:

```
/var/ossec/logs/ossec.log
```

---

# 4. Sysmon + Logging Configuration on Windows

## 4.1 Install Sysmon

```
Sysmon64.exe -accepteula -i sysmonconfig.xml
```

## 4.2 Config Used

* SwiftOnSecurity Sysmon config.
* High-fidelity event tracing.

## 4.3 Why Sysmon Matters

* Logs process creation.
* Network connections.
* Registry changes.
* DLL loads.
* Provides critical host telemetry for SOC analysis.

## 4.4 Where Logs Are Stored

```
Event Viewer → Applications and Services Logs → Microsoft → Windows → Sysmon
```

## 4.5 How Wazuh Collects Sysmon Logs

* Wazuh agent reads the Windows Event Log channels.
* Forwards them to `ossec` on manager.

---

# 5. Future Zeek Configuration Notes

## (Placeholder Section)

### Installation Steps

*To be added.*

### NIC Monitoring Mode

*To be added.*

### Exporting Logs to Wazuh

*To be added.*

### Validating Zeek Data Flow

*To be added.*

---

# 6. Troubleshooting Notes

### Dashboard Not Loading

* Certificates missing → regenerate.

### Wazuh Failing to Start

* Wrong version.
* Bad cert permissions.

### Docker Containers Not Starting

* Ensure version pinned.
* Ensure memory available.

### Agent Enrollment Errors

* API enrollment unreliable; use interactive mode.

### Time Sync Issues

* Ensure all VMs use same timezone.

### Host-Only Network Not Appearing

* Recreate VirtualBox host-only adapter.

---

# 7. Reproducibility Notes

### Why Snapshots Matter

* Instant rollback.
* Safe experimentation.

### Why Docker Ensures Reproducible Builds

* No dependency drift.
* Same stack on any machine.

### Rebuild SIEM

```
docker compose down
docker compose up -d
```

### Reset Entire Environment

* Restore VM snapshots.
* Re-clone repository.
* Re-run certificate generator.
