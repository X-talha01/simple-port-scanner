#!/bin/bash

# Function to check if a port is open
scan_port() {
    local ip=$1
    local port=$2
    timeout 1 bash -c "echo > /dev/tcp/$ip/$port" 2>/dev/null && echo -e "\e[32m[+] Port $port is OPEN\e[0m" &
}

# Main script execution
echo "📌 Simple Port Scanner"
read -p "🔹 Enter target IP address: " target_ip
read -p "🔹 Enter port range (e.g., 1-65000): " port_range

# Extract start and end ports
start_port=$(echo $port_range | cut -d'-' -f1)
end_port=$(echo $port_range | cut -d'-' -f2)

echo -e "\n🔎 Scanning $target_ip from port $start_port to $end_port...\n"

# Loop through the port range and scan ports in parallel
for ((port=start_port; port<=end_port; port++)); do
    scan_port "$target_ip" "$port"
done

wait  # Wait for all background jobs to finish

echo -e "\n✅ Scan Complete!"
