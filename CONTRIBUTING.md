# Contributing to f2b-manager

Thanks for your interest in contributing!

## How to contribute

1. **Fork** the repository
2. **Create a branch** for your feature or fix: `git checkout -b my-feature`
3. **Make your changes** — keep them focused and well-tested
4. **Test** on a system with fail2ban running
5. **Submit a pull request** with a clear description of what you changed and why

## Guidelines

- Keep it as a single bash script — no external runtimes (Python, Node, etc.)
- Maintain compatibility with `bash` 4+ and `dialog`
- Test on both Debian/Ubuntu and RHEL/Fedora if possible
- Follow the existing code style

## Reporting bugs

Open an [issue](https://github.com/gokcer/f2b-manager/issues) with:
- Your distro and version
- fail2ban version (`fail2ban-client --version`)
- Steps to reproduce
- Expected vs actual behavior

## Ideas for future features

- Per-jail configuration editing
- Ban duration management
- Log viewer / tail
- Export/import ban lists
- Systemd service management
