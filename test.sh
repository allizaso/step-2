#!/bin/bash

# This program takes either a .txt file of domain names:
#   ./domain-lookup.sh domains.txt
# Or a comma-separated list as an argument:
#   ./domain-lookup.sh my.domain.edu,my.domain.com,google.com

# Function to check if a domain resolves
check_domain() {
    local DOMAIN="$1"
    OUTPUT=$(nslookup "$DOMAIN" 2>&1)

    if echo "$OUTPUT" | grep -qi "non-existent domain"; then
        echo "$DOMAIN does NOT have a domain record"
    elif echo "$OUTPUT" | grep -qi "can't find"; then
        echo "$DOMAIN does NOT have a domain record"
    else
        echo "$DOMAIN has a domain record"
    fi
}

# Check if input was provided
if [ -z "$1" ]; then
    echo "Usage:"
    echo "  $0 domains.txt"
    echo "  $0 domain1.com,domain2.com,..."
    exit 1
fi

INPUT="$1"
DOMAINS=()

# If input is a file
if [ -f "$INPUT" ]; then
    while IFS= read -r LINE || [[ -n "$LINE" ]]; do
        LINE=$(echo "$LINE" | xargs)  # Trim whitespace
        [[ -z "$LINE" ]] && continue  # Skip empty lines
        DOMAINS+=("$LINE")
    done < "$INPUT"
else
    # Assume comma-separated list
    IFS=',' read -ra SPLIT <<< "$INPUT"
    for ITEM in "${SPLIT[@]}"; do
        ITEM=$(echo "$ITEM" | xargs)  # Trim whitespace
        [[ -z "$ITEM" ]] && continue
        DOMAINS+=("$ITEM")
    done
fi

# DNS lookup for each domain
echo "DNS Resolution Report"
echo "====================="

for DOMAIN in "${DOMAINS[@]}"; do
    check_domain "$DOMAIN"
done
