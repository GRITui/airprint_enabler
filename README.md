# AirPrint Enabler for Brother HL-1110 on macOS

This repository preserves the setup for printing from iPhone/iPad to a
non-AirPrint Brother HL-1110 connected by USB to a Mac.

## What it does

- Enables and shares the macOS CUPS queue.
- Downloads the MIT-licensed `AirPrint_Bridge` script at a pinned commit.
- Installs the bridge as a persistent `launchd` service.
- Keeps the printer-specific queue name and migration steps documented.

The Mac must stay powered on and connected to the same LAN as the iPhone or
iPad. The printer remains connected to the Mac by USB.

## Install on a new Mac

1. Install the Brother HL-1110 macOS driver and add the USB printer in
   **System Settings > Printers & Scanners**.
2. Clone this repository:

   ```bash
   git clone https://github.com/GRITui/airprint_enabler.git
   cd airprint_enabler
   ```

3. Run the setup script:

   ```bash
   ./setup.sh
   ```

   It will ask for the macOS administrator password when required.
4. Test from the iPhone in **Files > Share > Print**.
5. If the printer appears and prints, the persistent service is already
   installed by the script.

## Queue name

The expected queue is `Brother_HL_1110_series`. If macOS assigns a different
queue name on a replacement Mac, run:

```bash
./setup.sh --queue "actual_queue_name"
```

## Diagnostics

```bash
./diagnose.sh
```

This reports the CUPS queue, bridge process, Bonjour advertisement, and recent
CUPS errors. It does not collect documents, credentials, or private files.

## Remove the bridge

```bash
./uninstall.sh
```

This removes only the AirPrint bridge service and restores normal macOS
printer sharing. It does not remove the Brother printer or its driver.

## Source and license

The bridge implementation is from
[sapireli/AirPrint_Bridge](https://github.com/sapireli/AirPrint_Bridge), licensed
under MIT. This repository contains only setup and migration scripts.
