# Datalogger OTA Repository

This repository contains firmware binaries for over-the-air updates.

## Directory Structure

- `bin/` - Firmware binaries
- `manifest.json` - Firmware manifest with version information

## Adding New Firmware

1. Add the binary to `bin/` with version in filename (e.g., `display_v1.0.0.bin`)
2. Update `manifest.json` with the new firmware information
3. Commit and push to main branch
