#!/usr/bin/env bash
# Zhumakhan_Zhassulan_system.sh - prints student information and system information.

# The info file is in the project root, one level above scripts/
PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
INFO_FILE="$PROJECT_DIR/Zhumakhan_Zhassulan_info.txt"
LINE="=============================="

echo "$LINE"
echo "Student Information"
echo "$LINE"
echo
echo "Name: Zhassulan"
echo "Surname: Zhumakhan"
echo "Group: IT2-2308"
echo "Student ID: 37359"
echo
echo "$LINE"
echo "System Information"
echo "$LINE"
echo
echo "Username: $(whoami)"
echo "Hostname: $(hostname)"
echo "Current Date: $(date '+%Y-%m-%d %H:%M:%S')"
echo "Operating System: $(uname -s) $(uname -r) ($(uname -m))"
echo "Disk Usage:"
df -h /
echo "Memory Usage:"
free -h
echo

if [ -f "$INFO_FILE" ]; then
    echo "Student information file exists."
else
    echo "Student information file does not exist."
fi
