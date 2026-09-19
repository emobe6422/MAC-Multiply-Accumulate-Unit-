# MAC-Multiply-Accumulate-Unit-
Mini project designed to help me get more familiar with timing closures, UVM and C++ emulation
NOTE (9/19/2026) I got familiar. Since im planning to do a tiny tapeout project in the future for my gpu, this project helped me get familiar w/ timing closures (WNS, WHS, etc.), UVM, DPI-C and a few other things. Most notably, this desgin actually CANNOT be implemented bc it has too many I/O ports, so I learned the importance of that constraint + what it intuitively means. Important since tiny tapeout only allows 26 I/O pins for everything. GPU project next.

NOTE (9/19/2026) The add pipeline is structured kinda poorly since I hard-coded the wires for a TAPS count of 8, so it would have to be tweaked to be scalable using parameters instead.
