## Open Source Installation guidelines

This Installation guideline will allow you to use analog design, digital design and verification tools seamlessly by using nix shell, which would allow u use any tool under a same directory.

> [!NOTE]
> Nix-shell is a command provided by the Nix package manager that provisions a transient, isolated, and strictly reproducible development environment without modifying your global operating system.

> [!NOTE] 
> Instead of installing packages into `/usr/bin`, `/usr/local/lib`, or system-wide package registries, Nix fetches or builds the exact dependencies specified in an expression (like `shell.nix` or `flake.nix`), places them under cryptographic hashes in `/nix/store`, and spawns an ephemeral subshell with environment variables (`PATH`, `LD_LIBRARY_PATH`, `PYTHONPATH`) configured to point to them.

The open-source EDA (Electronic Design Automation) ecosystem spanning synthesizers (Yosys), place-and-route engines (nextpnr, OpenROAD), timing analyzers (OpenSTA), simulators (Verilator, Icarus), and PDK tooling (Magic, KLayout, Netgen)—has notoriously painful dependency matrices. Nix has become the best environment manager in this space (adopted heavily by projects like OpenROAD, Libre-SOC, and F4PGA) because it eliminates dependency hell and Bit-for-Bit determinism across compute environments.

The tools we will be going to install are listed [here](tools.md).

## Important
> [!IMPORTANT]
> Before any installation please go through the [requirements](requirements.md) and verify if your device meets the requirements.

Let's Install Nix first for the complete step-by-step guide to setting up the environment, please read [INSTALL.md](INSTALL.md).

> [!TIP]
> Instead of copy pasting `shell.nix` and `flake.nix` you can clone this repository and use already written [shell.nix](shell.nix) and [flake.nix](flake.nix) files.

# Open-Source Digital Design Exercises

In this module, you will get hands-on experience navigating the RTL-to-GDSII flow. You will learn how to configure LibreLane, debug timing and routing issues, integrate custom macros, and successfully implement a full chip design.

All the practical tasks are hosted in the [main workshop](https://heichips.github.io/) repository. There are **5 core exercises** designed to build your physical design skills step-by-step.

*[Go to the heichips26-digital-workshop Repository](https://github.com/kevalpattani/heichips26-digital-workshop)*

Instructions:
1. **Fork the repository** to your own GitHub account using the button at the top right of the repo page.
2. Clone your forked version to your local workspace.
3. Work your way through Exercises 1 to 5. 

> [!NOTE]
> Ensure you have already completed the Nix environment setup from the Installation section above before beginning the exercises. Your tools (`librelane`, `yosys`, `openroad`, etc.) need to be active in your terminal!
