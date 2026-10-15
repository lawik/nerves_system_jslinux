# Changelog

This project does NOT follow semantic versioning. The version increases as
follows:

1. Major version updates are breaking updates to the build infrastructure.
   These should be very rare.
2. Minor version updates are made for every major Buildroot release. This
   may also include Erlang/OTP and Linux kernel updates. These are made four
   times a year shortly after the Buildroot releases.
3. Patch version updates are made for Buildroot minor releases, Erlang/OTP
   releases, and Linux kernel updates. They're also made to fix bugs and add
   features to the build infrastructure.

## v0.3.0

* Updated to Buildroot 2026.08 via nerves_system_br 1.35.1
* Updated Linux kernel to 6.18.57 (LTS). The config follows Frank's
  unfinished linux-6.1 branch: ARCH_VIRT, NONPORTABLE, RISCV_SBI_V01 for the
  BBL-provided legacy SBI
* Updated toolchain to GCC 15.3 (nerves_toolchain_riscv64_nerves_linux_musl 15.3.1)
* Updated Erlang/OTP to 29.1.1 and Elixir to 1.20
* Requires Nerves ~> 1.15

## v0.2.0

* Updated to Buildroot 2025.11.2 via nerves_system_br 1.33.4
* Updated Linux kernel to 5.15.180 (kept at 5.15 for TinyEMU compatibility)
* Updated toolchain to GCC 14.2.0 (nerves_toolchain_riscv64_nerves_linux_musl 14.2.0)
* Updated Erlang/OTP to 28 and Elixir to 1.17+
* Requires Nerves ~> 1.13

## v0.1.0

This is the initial release.
