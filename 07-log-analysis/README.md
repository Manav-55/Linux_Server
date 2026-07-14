# Log Analysis

## Overview

Logs are one of the most valuable sources of information on a Linux system. They help administrators troubleshoot issues, monitor services, investigate security incidents, and understand system behavior.

This module covers Linux logging, systemd journal logs, and common log analysis commands.

---

# Learning Objectives

- Understand Linux logging
- Learn where logs are stored
- View and filter logs using `journalctl`
- Monitor logs in real time
- Search logs efficiently
- Analyze system and application logs
- Build a basic troubleshooting workflow

---

# Linux Logging

Applications generate log messages to record:

- Errors
- Warnings
- Information
- Debug messages
- Security events

Logs help answer questions such as:

- Why did a service fail?
- Who logged into the server?
- When was the system rebooted?
- What caused an application crash?

---

# Common Log Locations

| Directory | Purpose |
|-----------|---------|
| `/var/log/` | Main log directory |
| `/var/log/syslog` | General system logs (Ubuntu) |
| `/var/log/auth.log` | Authentication logs |
| `/var/log/kern.log` | Kernel logs |
| `/var/log/dpkg.log` | Package installation history |
| `/var/log/nginx/` | Nginx logs |
| `/var/log/apache2/` | Apache logs |

---

# Viewing Logs

## View a file

```bash
cat /var/log/syslog
```

## Scroll through large logs

```bash
less /var/log/syslog
```

Useful shortcuts:

- `Space` → Next page
- `b` → Previous page
- `/text` → Search
- `q` → Quit

---

# Tail Logs

View the last lines:

```bash
tail /var/log/syslog
```

View last 50 lines:

```bash
tail -n 50 /var/log/syslog
```

Monitor continuously:

```bash
tail -f /var/log/syslog
```

---

# Searching Logs

Search using grep:

```bash
grep "error" /var/log/syslog
```

Case insensitive:

```bash
grep -i "failed" /var/log/auth.log
```

Count matches:

```bash
grep -c "error" /var/log/syslog
```

---

# journalctl

Modern Linux systems use **systemd-journald** for centralized logging.

---

## View all logs

```bash
journalctl
```

---

## Follow logs

```bash
journalctl -f
```

---

## Logs for a service

```bash
journalctl -u ssh

journalctl -u nginx

journalctl -u clock
```

---

## Today's logs

```bash
journalctl --since today
```

---

## Last hour

```bash
journalctl --since "1 hour ago"
```

---

## Last 20 entries

```bash
journalctl -n 20
```

---

## Reverse order

```bash
journalctl -r
```

---

# Log Levels

| Level | Meaning |
|-------|---------|
| emerg | System unusable |
| alert | Immediate action required |
| crit | Critical condition |
| err | Error |
| warning | Warning |
| notice | Normal but important |
| info | Informational |
| debug | Debugging information |

Example:

```bash
journalctl -p err
```

Shows only error logs.

---

# Service Troubleshooting Workflow

1. Check service status

```bash
systemctl status service_name
```

2. View service logs

```bash
journalctl -u service_name
```

3. Follow logs while testing

```bash
journalctl -u service_name -f
```

4. Identify the root cause

5. Fix and restart the service

---

# Useful Commands

```bash
journalctl -u ssh

journalctl -u nginx

journalctl -f

journalctl --since today

journalctl --since "30 minutes ago"

tail -f /var/log/syslog

grep "error" logfile

less logfile
```

---

# Labs Completed

- Viewed service logs using `journalctl`
- Followed live logs with `journalctl -f`
- Filtered logs by service
- Filtered logs by time
- Used `tail` for real-time monitoring
- Used `grep` to search logs
- Learned a structured troubleshooting workflow

---

# Key Takeaways

- Logs are the first place to investigate problems.
- `journalctl` is the primary logging tool on modern systemd systems.
- Use `tail -f` or `journalctl -f` for real-time monitoring.
- Combine `grep`, `less`, and `journalctl` to quickly locate issues.
- Always inspect logs before making configuration changes.