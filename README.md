# FPGA-Based Security Lock System

## 📝 Project Overview
This project implements a digital security lock system in VHDL. It allows a user to set a 3-digit security code, lock the system, and later attempt to unlock it by entering a matching code. The system uses a state-machine-like logic to transition between "Free" and "Occupied" (Locked) states.

## ⚙️ System Logic & Operation
The system operates as a state machine with two main phases managed in `PROIECT.vhd`:

1.  **Setup Phase (Free State)**: 
    * The system starts in the "Free" state (`liber_ocupat='0'`).
    * The user enters a 3-digit code using `introdu_cod.vhd`('test1' is the name for code 'introdu_cod').
    * **Validation**: The `comparator_cifre.vhd` module checks if the digits are unique. If they are not, the system rejects the code.
2.  **Locking**: 
    * Once the first code is set, the system enters the "Occupied/Locked" state (`liber_ocupat = '1'`).
3.  **Unlock Phase**: 
    * A second 3-digit code must be entered.
    * The 'comparator_cod.vhd' module validates the access by comparing two sets of 3-digit codes (12 bits total).
    * If the codes match, the system resets to the "Free" state.

## 📂 Module Descriptions
* **PROIECT.vhd**: The top-level entity that manages the global state, resets, and signal routing between modules.
* **introdu_cod.vhd**: The input interface. It handles button presses, manages the `careCounter` (to track which digit is being entered), and controls the 7-segment display multiplexing.
* **numarator_up_down.vhd**: A 4-bit reversible counter used to select digits from 0 to 15 (0 to F in Hexadecimal).
* **comparator_cod.vhd**: Performs the final 12-bit comparison (3 digits x 4 bits) between the "set" code and the "attempt" code.
* **BCD_decod.vhd**: A 4-bit Hexadecimal to 7-segment decoder. While named BCD, it supports the full 0-F range for enhanced code entry.
* **MPG.vhd**: Mono-Pulse Generator (Debouncer) to ensure clean signals from physical buttons.

## 🚀 Hardware Interface
* **Inputs**:
  - `btn_up` / `btn_down`: Navigate through numbers.
  - `btn_add`: Confirm/Enter the current digit.
  - `reset`: Clear the system state.
  - `clk`: System clock .
* **Outputs**:
  - `output_c [0:6]`: 7-segment display segments.
  - `output_a [3:0]`: Anode selection for multiplexing.
  - `liber_ocupat`: LED indicator for system status (Locked/Unlocked).
  - `introdu_caractere`: Indicator that an input is being processed.

## 🛠️ Simulation & Verification
The logic was verified using the `test1` (introdu_cod) architecture. The simulation ensures that:
- **Sequential Input**: The `careCounter` correctly advances after each `btn_add` pulse.
- **Clock Division & Multiplexing**: Confirmed that the frequency divider produces stable pulses for the 7-segment display, cycling through the anodes at a rate that eliminates flicker in a hardware environment.
