#![no_main]
#![no_std]

use cortex_m::asm::delay;
use cortex_m_rt::entry;
use embassy_stm32 as hal;
use hal::gpio::{Level, Output, Speed};
use panic_halt as _;
use rtt_target::{rprintln, rtt_init_print};

#[entry]
fn main() -> ! {
    let p = hal::init(Default::default());
    let mut led = Output::new(p.PB3, Level::Low, Speed::Low);

    loop {
        led.toggle();
        delay(1_000_000);
    }
}
