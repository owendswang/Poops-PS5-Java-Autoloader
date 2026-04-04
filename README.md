# POOPS PS5 - BD-J Kernel Exploit & ELF Loader

A complete Java port of the [`poops_ps5.lua`](https://github.com/Gezine/Luac0re/blob/main/payloads/poops_ps5.lua) IPv6 UAF kernel exploit originally developed by [Gezine](https://github.com/Gezine) and [egycnq](https://github.com/egycnq), based on the [`ExploitNetControlImpl`](https://gist.github.com/TheOfficialFloW/7174351201b5260d7780780f4059bebf) vulnerability discovered by [TheFlow](https://github.com/TheOfficialFloW). This project is designed to run natively within the PlayStation 5 BD-J (Blu-ray Java) environment. 

This payload chains a Netgraph/`sys_netcontrol` Use-After-Free (UAF) vulnerability, leveraging IPv6 routing headers for heap spraying, to achieve arbitrary kernel read/write, patches system credentials for root privileges, enables Debug Settings via a GPU DMA memory patch, and deploys an ELF loader.

## Features

* **Full Kernel R/W:** Stable UAF execution with dynamic triplet repair and Kqueue reclamation to prevent kernel panics.
* **Privilege Escalation:** Patches process credentials (`ucred`) to achieve root access.
* **Debug Settings:** Uses GPU DMA to patch QA flags, target ID, and UTOKEN in protected kernel memory.
* **ELF Loader:** Safely allocates and maps executable memory using shared memory aliasing (respecting FreeBSD W^X protections) and spawns a system thread listening on port 9021 for payload execution.

## Project History & Development

This project began as a technical challenge. Due to a lack of initial in-depth knowledge regarding FreeBSD internals and the PS5 kernel, the initial port of [`poops_ps5.lua`](https://github.com/Gezine/Luac0re/blob/main/payloads/poops_ps5.lua) to Java was generated using Large Language Models (LLMs). 

Starting from that AI-generated foundation, extensive reverse engineering, iterative hardware testing, and debugging were performed to stabilize the exploit chain.

## Credits & Acknowledgements

This project relies heavily on the research and open-source contributions of the PlayStation security community:

* **[Gezine](https://github.com/Gezine) & [egycnq](https://github.com/egycnq):** For the original [`poops_ps5.lua`](https://github.com/Gezine/Luac0re/blob/main/payloads/poops_ps5.lua) script and the core implementation of the exploitation chain.
* **[TheFlow (Andy Nguyen)](https://github.com/TheOfficialFloW):** For the discovery of the [`ExploitNetControlImpl`](https://gist.github.com/TheOfficialFloW/7174351201b5260d7780780f4059bebf) vulnerability and the original BD-J sandbox escape research.
* **[SpecterDev (Cryptogenic)](https://github.com/Cryptogenic), [ChendoChap](https://github.com/ChendoChap), [John Törnblom](https://github.com/john-tornblom), and the [ps5-payload-dev](https://github.com/ps5-payload-dev) contributors:** For their foundational work on PS5 ELF loading, memory mapping, and the overall payload ecosystem.
* **Testers: A massive thank you to [DrYenyen](https://github.com/DrYenyen), [EchoStretch](https://github.com/EchoStretch), and [Viktorious-x](https://github.com/Viktorious-x), who generously volunteered their time and consoles to test and debug this payload despite not knowing me beforehand.**

## Requirements

* A PS5 on firmware 12.00 or below with an unpatched BD-J environment.
* A functional BD-J Loader environment running on the console.
  * *Note: For our testing and development, we successfully used the [BD-UN-JB 1.0 ISO](https://github.com/Gezine/BD-UN-JB/releases/download/1.0/BD-UN-JB_1.0.iso), which includes the Jar Loader utilizing TheFlow's API.*

## Execution

1. Send the compiled `.jar` file to the listening BD-J loader on your console (typically via port 9025).
2. Wait for the process to complete all 7 stages. Once finished, the Debug Settings will become visible, and the ELF loader will be active.
3. Close the Blu-ray application.
4. Send your final payload (e.g., an `.elf` file) to **port 9021**.

## Support ☕

If you found this project helpful and want to support my work, consider buying me a coffee!

[![ko-fi](https://ko-fi.com/jaime_cyber)]
