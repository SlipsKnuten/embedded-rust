#!/usr/bin/env bash
# Connects gdb-multiarch to the GDB server started by `cargo embed`, using the
# most recently built ELF (debug or release) so symbols match what was flashed.
set -euo pipefail

cd "$(dirname "$0")/.."

elf=$(ls -t target/thumbv7em-none-eabihf/{debug,release}/embedded-rust 2>/dev/null | head -n1 || true)
if [[ -z "$elf" ]]; then
    echo "gdb.sh: no firmware built yet - run 'cargo embed' first." >&2
    exit 1
fi

echo "gdb.sh: using $elf" >&2
exec gdb-multiarch -q "$elf" -ex "target remote :1337" "$@"
