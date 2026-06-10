#!/bin/bash

FIFO="/tmp/swaybar.fifo"
WIRELESS_INTF="wlp0s20f3"
STATE=""

swaybar-msg() {
    local msg="$1"
    file="/tmp/swaybar.fifo"
    echo "$msg" > "$file"
}

# Clean up existing instances and files
pkill -f "swaybar.fifo" 2>/dev/null
rm -f "$FIFO"
mkfifo "$FIFO"

render() {
    local wifi_str bat_str time_str

    # ---- WIFI ----
    if [ -d "/sys/class/net/$WIRELESS_INTF" ] && \
        [ "$(cat /sys/class/net/$WIRELESS_INTF/operstate)" = "up" ]; then

        essid=$(iwgetid -r "$WIRELESS_INTF" 2>/dev/null || echo "Connected")
        quality=$(awk -v iface="$WIRELESS_INTF" '$0 ~ iface {print int($3 * 100 / 70)"%"}' /proc/net/wireless)
        rx_speed=$(iw dev "$WIRELESS_INTF" link | grep rx | cut -d" "  -f3)
        tx_speed=$(iw dev "$WIRELESS_INTF" link | grep tx | cut -d" "  -f3)
        frequency=$(iwconfig "$WIRELESS_INTF" 2>/dev/null | grep -o 'Frequency:[0-9.]* [A-Za-z]*' | cut -d: -f2)
        vpn=$(ip link show dev proton0 >/dev/null 2>&1 && echo "[VPN]" || echo "")

        wifi_str="$essid ($quality) rx:$rx_speed tx:$tx_speed $frequency $vpn"
    else
        wifi_str="offline"
    fi

    # ---- BATTERY ----
    if [ -d /sys/class/power_supply/BAT0 ]; then
        capacity=$(cat /sys/class/power_supply/BAT0/capacity)
        status_raw=$(cat /sys/class/power_supply/BAT0/status)

        case "$status_raw" in
            Charging)    status="CHR" ;;
            Discharging) status="BAT" ;;
            Full)        status="FULL" ;;
            *)           status="UNK" ;;
        esac

        empty_time=""
        if [ "$status" = "BAT" ]; then
            current_now=$(cat /sys/class/power_supply/BAT0/current_now)
            charge_now=$(cat /sys/class/power_supply/BAT0/charge_now)

            if [ "$current_now" -gt 0 ]; then
                hours=$(echo "scale=2; $charge_now / $current_now" | bc)
                empty_time="(${hours}h remaining)"
            fi
        fi

        bat_str="$status $capacity% $empty_time"
    else
        bat_str="No battery"
    fi

    # ---- TIME ----
    time_str=$(date +"%a %B %-d %I:%M:%S %Z")

    echo "$STATE $wifi_str | $bat_str | $time_str"
}

(
    while true; do
        sleep 1
        echo "TICK" > "$FIFO"
    done
) &

last=$(date +%s)

while true; do
    if read -r msg < "$FIFO"; then
        current_time=$(date +%s)

        if [ "$msg" != "TICK" ]; then
            STATE="$msg"
            last=$current_time
        else
            if [ $((current_time - last)) -ge 1 ]; then
                STATE=""
            fi
        fi
        render
    fi
done
