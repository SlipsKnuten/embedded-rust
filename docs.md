Kör med cargo run --release eller cargo embed --release

Kör gdb debugger:
cd ~/projects/embedded-rust
gdb-multiarch target/thumbv7em-none-eabihf/debug/embedded-rust -ex "target remote :1337"

info register = visar nuvarande cpu register
pc = program counter
sp = stack pointer
lr = link register

set print asm-demangle on = disassemble visar funktionernas namn som finns i rust när vi visar assembly kod

stepi = exekvera 1 assembly instruktion
step = exekvera 1 källkods statement/line

break = sett break point på en rad

continue = kör till nästa breakpoint

info locals = visa info om alla lokala variabler

print variable = visar värde på den variabeln

print &variable = visar minnesadressen på variabeln

set variable = ändra variabel värde

info break = lista breakpoints

delete 1? = ta bort specifik breakpoint

disable 1 = inaktivera breakpoint
