#!/usr/bin/env bash
# Cargo runner: makes sure the ST-Link is attached to WSL and accessible, then
# flashes the given ELF with probe-rs and streams RTT output.
set -euo pipefail

CHIP="STM32L432KCUx"
VIDPID="0483:374b" # ST-Link V2-1 on the Nucleo board

# Attach the probe to WSL via usbipd-win if it isn't already.
line=$(usbipd.exe list 2>/dev/null | tr -d '\r' | grep -m1 "$VIDPID" || true)
if [[ -z "$line" ]]; then
    echo "flash.sh: ST-Link ($VIDPID) not found by Windows - is the board plugged in?" >&2
    exit 1
fi
busid=${line%% *}
case "$line" in
    *"Not shared"*)
        echo "flash.sh: run 'usbipd bind --busid $busid --force' in an admin PowerShell first." >&2
        exit 1
        ;;
    *Attached*) ;;
    *)
        echo "flash.sh: attaching ST-Link (busid $busid) to WSL..." >&2
        usbipd.exe attach --wsl --busid "$busid" >/dev/null 2>&1
        sleep 2
        ;;
esac

# No udev in this WSL setup, so new device nodes are root-only; open them up.
for node in /dev/bus/usb/*/*; do
    if [[ ! -w "$node" ]]; then
        echo "flash.sh: fixing USB device permissions..." >&2
        wsl.exe -u root -e sh -c 'chmod a+rw /dev/bus/usb/*/*'
        break
    fi
done

exec probe-rs run --chip "$CHIP" "$@"
