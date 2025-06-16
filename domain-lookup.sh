#!/bin/bash

# This program takes either a .txt file of domain names:
#   ./domain-lookup.sh domains.txt
# Or a comma-separated list as an argument:
#   ./domain-lookup.sh my.domain.edu, my.domain.com, google.com

# Function to check if a domain has a DNS record in nslookup
check_domain() {
    local DOMAIN="$1"
    OUTPUT=$(nslookup "$DOMAIN" 2>&1)

    if echo "$OUTPUT" | grep -qi "non-existent domain"; then
        echo "❌ No domain record:        $DOMAIN"
    elif echo "$OUTPUT" | grep -qi "can't find"; then
        echo "❌ No domain record:        $DOMAIN"
    else
        echo "✅ Has domain record:       $DOMAIN"
    fi
}

# Check if input was provided
if [ -z "$1" ]; then
    echo "Usage:"
    echo "  $0 domains.txt"
    echo "  $0 domain1.com, domain2.com, domain3.com,..."
    exit 1
fi

INPUT="$1"
DOMAINS=()

# Export the DNS lookup reoprt to a .txt file
REPORT_FILE="domain-report.txt"
exec > >(tee "$REPORT_FILE")

# If the input is a file:
# Go over the .txt and separate into an array of domain names
# Use line break as a delimiter
# Skip empty lines
if [ -f "$INPUT" ]; then
    while IFS= read -r LINE || [[ -n "$LINE" ]]; do
        LINE=$(echo "$LINE" | xargs)  # Trim whitespace
        [[ -z "$LINE" ]] && continue  # Skip empty lines
        DOMAINS+=("$LINE")
    done < "$INPUT"
else
    # Handle comma-separated list ("domain1.com, domain2.com")
    IFS=',' read -ra SPLIT <<< "$INPUT"
    for ITEM in "${SPLIT[@]}"; do
        ITEM=$(echo "$ITEM" | xargs)  # Trim whitespace
        [[ -z "$ITEM" ]] && continue
        DOMAINS+=("$ITEM")
    done
fi


# Print DNS lookup for each domain
echo "======================================"
echo "Service Principal DNS Lookup Report"
echo "======================================"

for DOMAIN in "${DOMAINS[@]}"; do
    check_domain "$DOMAIN"
done