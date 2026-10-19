#!/usr/bin/env bash
# test.sh - "Test" stage of the pipeline: checks that the project is complete
# and that the scripts are valid. Exits with 1 if any check fails.

cd "$(dirname "$0")/.." || exit 1
fail=0

ok()  { echo "[OK]   $1"; }
bad() { echo "[FAIL] $1"; fail=1; }

for f in Zhumakhan_Zhassulan_info.txt \
         scripts/Zhumakhan_Zhassulan_system.sh \
         config/app.conf \
         app/app.py \
         Dockerfile \
         docker-compose.yml \
         Jenkinsfile \
         .gitignore; do
    if [ -f "$f" ]; then ok "$f exists"; else bad "$f not found"; fi
done

if bash -n scripts/Zhumakhan_Zhassulan_system.sh; then
    ok "system script syntax is valid"
else
    bad "system script has syntax errors"
fi

if grep -q "Student ID: 37359" Zhumakhan_Zhassulan_info.txt; then
    ok "info file contains the Student ID"
else
    bad "info file does not contain the Student ID"
fi

if [ "$fail" -eq 0 ]; then
    echo "All tests passed."
else
    echo "Some tests failed."
fi
exit "$fail"
