#![no_main]
#![no_std]

use cortex_m::asm::nop;
use cortex_m_rt::entry;
use panic_halt as _;
use rtt_target::{rprintln, rtt_init_print};

#[entry]
fn main() -> ! {
    let mut ticker: i32 = 0;
    loop {
        ticker += 1;
        for _ in 0..ticker {
            nop();
        }
    }
}
