#!/bin/bash

# Define your specific wireless interface
WIRELESS_INTF="wlp0s20f3"

while true; do
    # -----------------------------------------------------------------
    # 1. WIRELESS SECTION
    # -----------------------------------------------------------------
    if [ -d "/sys/class/net/$WIRELESS_INTF" ] && [ "$(cat /sys/class/net/$WIRELESS_INTF/operstate)" = "up" ]; then
        # Fetch network details
        essid=$(iwgetid -r $WIRELESS_INTF 2>/dev/null || echo "Connected")
        ip_addr=$(ip addr show dev $WIRELESS_INTF | grep 'inet ' | awk '{print $2}' | cut -d/ -f1)

        # Pull signal statistics from /proc/net/wireless
        quality=$(awk -v iface="$WIRELESS_INTF" '$0 ~ iface {print int($3 * 100 / 70)"%"}' /proc/net/wireless)

        # Pull bitrate and frequency
        bitrate=$(iwconfig $WIRELESS_INTF 2>/dev/null | grep -o 'Bit Rate=[0-9.]* [A-Za-z/]*' | cut -d= -f2)
        frequency=$(iwconfig $WIRELESS_INTF 2>/dev/null | grep -o 'Frequency:[0-9.]* [A-Za-z]*' | cut -d: -f2)

        wifi_str="$essid ($quality) $bitrate $frequency $ip_addr"
    else
        wifi_str="offline"
    fi

    # -----------------------------------------------------------------
    # 2. BATTERY SECTION
    # -----------------------------------------------------------------
    if [ -d /sys/class/power_supply/BAT0 ]; then
        capacity=$(cat /sys/class/power_supply/BAT0/capacity)
        status_raw=$(cat /sys/class/power_supply/BAT0/status)

        # Map raw status to your explicit configurations
        case "$status_raw" in
            "Charging")    status="CHR" ;;
            "Discharging") status="BAT" ;;
            "Full")        status="FULL" ;;
            *)             status="UNK" ;;
        esac

        # Calculate time remaining if discharging (rough estimate from power_supply)
        if [ "$status" = "BAT" ]; then
            current_now=$(cat /sys/class/power_supply/BAT0/current_now)
            charge_now=$(cat /sys/class/power_supply/BAT0/charge_now)
            if [ "$current_now" -gt 0 ]; then
                hours=$(echo "scale=2; $charge_now / $current_now" | bc)
                empty_time="(${hours}h remaining)"
            fi
        else
            empty_time=""
        fi

        bat_str="$status $capacity% $empty_time"
    else
        bat_str="No battery"
    fi

    # -----------------------------------------------------------------
    # 3. TZTIME SECTION
    # -----------------------------------------------------------------
    # Matches your exact format: %a %B %-d %H:%M:%S %Z
    time_str=$(date +"%a %B %-d %H:%M:%S %Z")

    # -----------------------------------------------------------------
    # OUTPUT
    # -----------------------------------------------------------------
    # Output the components in your designated 'order' separated by columns/bars
    echo "$wifi_str | $bat_str | $time_str"

    sleep 1
done
