# f2b-manager

An interactive terminal UI (TUI) for managing **fail2ban** bans and whitelists.

Built with [`dialog`](https://invisible-island.net/dialog/) — no Python, no extra runtimes, just a single bash script.

![screenshot](https://github.com/user-attachments/assets/placeholder)

## Features

- **Status overview** — see all jails at a glance: currently banned, total banned, failed attempts
- **View banned IPs** — browse banned IPs per jail with option to unban
- **Ban / Unban** — manually ban or unban single or multiple IPs
- **Bulk unban** — unban all IPs from a jail with one action
- **Whitelist management** — view, add, and remove whitelisted (ignored) IPs
- **Flexible whitelisting** — choose runtime-only, persistent (`jail.local`), or both
- **IP search** — search an IP across all jails (banned status, whitelist, log history)

## Requirements

- **Linux** with `bash` 4+
- **fail2ban** installed and running
- **dialog** — TUI framework (`apt install dialog` / `dnf install dialog`)
- **Root access** (fail2ban requires it)

## Installation

### One-liner

```bash
curl -fsSL https://raw.githubusercontent.com/gokcer/f2b-manager/main/install.sh | sudo bash
```

### From source

```bash
git clone https://github.com/gokcer/f2b-manager.git
cd f2b-manager
sudo ./install.sh
```

### Manual

```bash
sudo curl -fsSL https://raw.githubusercontent.com/gokcer/f2b-manager/main/f2b-manager -o /usr/local/bin/f2b-manager
sudo chmod +x /usr/local/bin/f2b-manager
```

## Usage

```bash
sudo f2b-manager
```

### Menu Options

| Key | Action |
|---|---|
| `STATUS` | Overview of all jails |
| `BANNED` | View banned IPs per jail |
| `BAN` | Manually ban an IP |
| `UNBAN` | Unban selected IPs (checklist) |
| `UNBAN_ALL` | Unban all IPs from a jail |
| `WHITELIST` | View whitelisted IPs |
| `WL_ADD` | Add IP to whitelist |
| `WL_REMOVE` | Remove IP from whitelist |
| `SEARCH` | Search IP across all jails |

## Uninstall

```bash
sudo ./uninstall.sh
# or simply:
sudo rm /usr/local/bin/f2b-manager
```

## Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

[MIT](LICENSE)
