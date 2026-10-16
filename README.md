# JSLinux Support

[![CircleCI](https://circleci.com/gh/fhunleth/nerves_system_jslinux.svg?style=svg)](https://circleci.com/gh/fhunleth/nerves_system_jslinux)
[![Hex version](https://img.shields.io/hexpm/v/nerves_system_jslinux.svg "Hex version")](https://hex.pm/packages/nerves_system_jslinux)

This is the base Nerves System configuration for a [JSLinux](#jslinux): Nerves
running on a RISC-V machine emulated by TinyEMU in a web browser. Since 0.4.0 it
boots the way a real device does: OpenSBI, then U-Boot, which reads the Nerves
U-Boot environment from a virtio disk image laid out by fwup (MBR, A/B kernel
slots, A/B rootfs partitions, an f2fs application partition) and boots the
active slot. Firmware updates, reverts and a persistent application partition
all work in the browser, and the disk is kept in the browser's IndexedDB
(see jsnerves) so the application partition and firmware state survive
page loads.

![JSLinux Screenshot](assets/images/screenshot.png)

| Feature              | Description                     |
| -------------------- | ------------------------------- |
| CPU                  | 64 bit RISC-V                   |
| Boot                 | OpenSBI 1.8 + U-Boot 2026.07    |
| Memory               | 128 MB (configurable)           |
| Storage              | VirtIO block, A/B + app partition (in-memory in the browser) |
| Linux kernel         | 6.18                            |
| IEx terminal         | VirtIO `ttyhvc0`                |
| GPIO, I2C, SPI       | Emulated - [Elixir Circuits](https://github.com/elixir-circuits) |
| Display              | Yes, but not supported yet      |
| ADC                  | No                              |
| PWM                  | No                              |
| UART                 | No                              |
| Camera               | No                              |
| Ethernet             | VirtIO, but not supported yet   |
| WiFi                 | No                              |
| RTC                  | No                              |
| HW Watchdog          | Software                        |

## Using

The most common way of using this Nerves System is create a project with `mix
nerves.new` and add `jslinux` references where needed and in a similar way
to the default systems like `bbb`, etc. Then export `MIX_TARGET=jslinux`.
See the [Getting started
guide](https://hexdocs.pm/nerves/getting-started.html#creating-a-new-nerves-app)
for more information.

If you need custom modifications to this system for your device, clone this
repository and update as described in [Making custom
systems](https://hexdocs.pm/nerves/customizing-systems.html).

## Example use

This example assumes some familiarity with Nerves. To use this system, you'll
need OTP 29. Follow the [Nerves installation
instructions](https://github.com/nerves-project/nerves/blob/main/docs/Installation.md)
for additional system dependencies.

Creating a new hello world application:

```sh
mix nerves.new hello_jslinux
cd hello_jslinux
```

Open up your `mix.exs` and add `:jslinux` to the `@all_targets` list at
the top. It's ok to delete targets that you don't plan on using.

Then add the `:nerves_system_jslinux` dependency to the `deps` function:

```elixir
    {:nerves_system_jslinux, "~> 0.3", runtime: false, targets: :jslinux},
```

This will load the latest released version. To use the latest code on the `main`
branch here, add the following line:

```elixir
    {:nerves_system_jslinux, runtime: false, targets: :jslinux, nerves: [compile: true], git: "https://github.com/fhunleth/nerves_system_jslinux", branch: "main"}
```

To build, run:

```sh
export MIX_TARGET=jslinux
mix deps.get
mix firmware
...
```

## Console access

The console appears in the JSTerm Window.

## Networking

The board has a VirtIO network interfaces. I haven't figured out how to use it
yet.

## Thanks

This port uses Fabrice Bellard's [TinyEMU](https://bellard.org/tinyemu/).
[Ahmad Fatoum's fork](https://github.com/a3f/TinyEMU) had a super helpful fix
for newer versions of Emscripten. This unblocked me when I got stuck trying out
various Emscripten versions to try to fix runtime errors.

