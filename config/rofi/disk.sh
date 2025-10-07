#!/bin/bash

# Root and boot partition
get_system_disks() {
    df -h | awk 'NR>1 {
        if ($6 == "/") {
            printf " Root (%s used of %s - %s full)\n", $3, $2, $5
        } else if ($6 ~ /^\/boot/) {
            printf " Boot (%s used of %s - %s full)\n", $3, $2, $5
        }
    }'
}

# disk external partition
get_external_disks() {
    # mounted disk
    df -h | awk 'NR>1 {
        if ($1 ~ /^\/dev/ && $6 != "/" && $6 !~ /^\/boot/) {
            dev_name = gensub(/\/dev\//, "", "g", $1)
            printf "  %s (%s used of %s - %s full)\n", dev_name, $3, $2, $5
        }
    }'

    # unmount disk
    lsblk -o NAME,MOUNTPOINT,TYPE,FSTYPE | grep 'part$' | awk '!$2 && $4 !~ /swap|sda|nvme/ {
        system("udisksctl mount -b /dev/"$1" >/dev/null 2>&1")
        mountpoint=$(lsblk -o MOUNTPOINT /dev/"$1" | tail -1)
        if (mountpoint) {
            cmd = "df -h " mountpoint " | awk \"NR==2 {print \\$3 \\\" used of \\\" \\$2 \\\" (\\\" \\$5 \\\" full)\\\"}\""
            cmd | getline usage
            close(cmd)
            printf " %s (%s)\n", $1, usage
        }
    }'
}

entries=$( (get_system_disks; get_external_disks) )

# Show Rofi Menu
selected=$(echo -e "$entries" | rofi -dmenu -p "Storage Menu" -theme ~/.config/rofi/disktheme.rasi)

# Handle selection
if [[ -n "$selected" ]]; then
    if [[ "$selected" == *"Root"* ]]; then
        dolphin /
    elif [[ "$selected" == *"Boot"* ]]; then
        [[ -d "/boot/efi" ]] && dolphin /boot/efi || dolphin /boot
    else
        dev=$(echo "$selected" | awk '{print $2}')
        mountpoint=$(lsblk -o MOUNTPOINT /dev/"$dev" | tail -1)
        [[ -n "$mountpoint" ]] && dolphin "$mountpoint"
    fi
fi
