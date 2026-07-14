# Systemd Learning Notes

## The Great Init Evolution: From SysV to Systemd
To appreciate systemd's significance, we need to understand what came before it. Traditional SysV init systems used a sequential approach to starting services, meaning each service had to wait for the previous one to complete before starting. This was like having a single-file line at a coffee shop – functional, but painfully slow when you're in a hurry.

SysV init relied heavily on shell scripts stored in directories like /etc/rc.d, with complex symbolic link structures to manage different runlevels. While this worked, it had several critical limitations:

1) Sequential startup: Services started one after another, leading to longer boot times
2) Poor dependency management: No automatic resolution of service dependencies
4) Limited monitoring: No built-in mechanism to restart failed services
5) Shell script complexity: Debugging initialization problems was often a nightmare

Systemd revolutionized this approach by introducing parallel service startup, sophisticated dependency management, and integrated monitoring capabilities. The result? Boot times that went from minutes to seconds, and a system that could automatically recover from service failures.


## What is Systemd?

**systemd** is the **init system** used by most modern Linux distributions.

* It is the first userspace process started after the Linux kernel boots.
* It always runs with **PID 1**.
* It is responsible for managing background services and other system resources.

Verify that `systemd` is running as PID 1:

```bash
ps -p 1
```

Example output:

```text
PID TTY          TIME CMD
1 ?          00:00:02 systemd
```

---

# Responsibilities of Systemd

Systemd is responsible for:

* Starting services
* Stopping services
* Restarting services
* Enabling services at boot
* Monitoring running services
* Managing dependencies between services
* Managing different types of system resources called **Units**

---

# Viewing Running Processes

=> htop

`htop` is an interactive process viewer that displays CPU usage, memory usage, running processes, and process IDs.

---

# Systemd Units

Systemd supports multiple unit types, each serving distinct purposes:

## Common Systemd Unit Types

| Unit Type   | Extension  | Purpose                                                            | Example               |
| ----------- | ---------- | ------------------------------------------------------------------ | --------------------- |
| **Service** | `.service` | Manages daemons and background processes                           | `nginx.service`       |
| **Target**  | `.target`  | Groups units together to achieve a specific system state           | `multi-user.target`   |
| **Socket**  | `.socket`  | Manages network or IPC sockets and can activate services on demand | `sshd.socket`         |
| **Timer**   | `.timer`   | Schedules tasks and services (similar to `cron`)                   | `backup.timer`        |
| **Mount**   | `.mount`   | Manages filesystem mount points                                    | `home.mount`          |
| **Device**  | `.device`  | Represents and manages hardware devices                            | `dev-sda1.device`     |
| **Path**    | `.path`    | Monitors files or directories and triggers services on changes     | `config-watcher.path` |


This module primarily focuses on **Service Units**.

---

# The Boot Process: Systemd in Action

When your system boots, systemd orchestrates a complex dance of initialization tasks. Unlike the sequential approach of SysV, systemd analyzes dependencies and starts services in parallel whenever possible.

The boot process typically follows this flow:

1) Kernel handoff: The kernel starts systemd as PID 1
2) Basic system setup: Mount essential filesystems, initialize hardware
3) Target resolution: Determine the default target (usually graphical.target or multi-user.target)
4) Dependency analysis: Build the dependency tree for required units
5) Parallel activation: Start services concurrently based on dependencies
6) Target achievement: Reach the desired system state

---

# Apache Service Example

Install Apache:

```bash
sudo apt update
sudo apt install apache2
```

---

## Check Service Status

```bash
sudo systemctl status apache2
```

## Start the Apache web server

```bash
sudo systemctl start apache2
```

## Stop the Apache web server  

```bash
sudo systemctl stop apache2
```

## Full restart - stops and starts the service with new PID

```bash
sudo systemctl restart nginx
```

## Reload configuration - keeps the same PID, reloads config

```bash 
sudo systemctl reload nginx
```

## Try reload first, fall back to restart if unsupported

```bash
sudo systemctl reload-or-restart nginx
```

## Attempt reload/restart only if service is running

```bash
sudo systemctl try-reload-or-restart nginx
```

## Enable Service at Boot

```bash
sudo systemctl enable apache2
```

## Disable Service at Boot

```bash
sudo systemctl disable apache2
```

## Check if a service is enabled

```bash
systemctl is-enabled ssh
```


## The Nuclear Option: Masking Services

Sometimes you need to prevent a service from starting under any circumstances . This is where masking comes in:

### Mask a service - prevents it from starting even manually

```bash
sudo systemctl mask apache2
```
### Unmask a service - restore normal functionality

```bash
sudo systemctl unmask apache2
```

### Check if a service is masked

```bash
systemctl is-enabled apache2
```

## Access Apache

Open your browser and navigate to:

```text
http://<EC2_PUBLIC_IP>
```

If Apache is running and your EC2 Security Group allows inbound HTTP (port 80), you'll see the default Apache welcome page.

---

# Systemd Unit Files

Systemd reads **Unit Files** to determine how services should be managed.

Common locations:

```text
/etc/systemd/system
/run/systemd/system
/lib/systemd/system
```

---

## Directory Priority

### `/etc/systemd/system`

* Highest priority
* Recommended location for custom services
* Safe from package updates

---

### `/run/systemd/system`

* Runtime-generated units
* Temporary
* Cleared after reboot

---

### `/lib/systemd/system`

* Default unit files installed by packages
* Can be overwritten during software updates


---

---

# The Boot Process: Systemd in Action

When your system boots, systemd orchestrates a complex dance of initialization tasks. Unlike the sequential approach of SysV, systemd analyzes dependencies and starts services in parallel whenever possible.

The boot process typically follows this flow:

1) Kernel handoff: The kernel starts systemd as PID 1
2) Basic system setup: Mount essential filesystems, initialize hardware
3) Target resolution: Determine the default target (usually graphical.target or multi-user.target)
4) Dependency analysis: Build the dependency tree for required units
5) Parallel activation: Start services concurrently based on dependencies
6) Target achievement: Reach the desired system state

---

# Rescue and Emergency Modes

When normal boot fails, systemd provides specialized targets for recovery :

1) Rescue mode: Mounts local filesystems and starts essential services, but no network or multiuser access

2) Emergency mode: Only mounts root filesystem as read-only, minimal services for critical repairs
You can switch to these modes from a running system:

## Enter rescue mode
sudo systemctl isolate rescue.target

## Enter emergency mode (use with caution)
sudo systemctl isolate emergency.target

---

# Service File Structure

```ini
[Unit]
Description=Service Description
After=network.target

[Service]
Type=simple
User=username
WorkingDirectory=/path/to/project
ExecStart=/path/to/executable
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
```

---

# Important Directives

## [Unit]

- `Description`
- `After`
- `Before`
- `Requires`
- `Wants`

## [Service]

- `Type`
- `User`
- `WorkingDirectory`
- `ExecStart`
- `Restart`
- `RestartSec`

## [Install]

- `WantedBy`

---
# Service Types

| Type | Use Case |
|------|----------|
| `simple` | Long-running applications |
| `oneshot` | Executes once and exits |
| `forking` | Legacy daemon processes |
| `notify` | Services that notify systemd when ready |

---

# Service Lifecycle

```text
systemctl start service
        │
        ▼
Read Unit File
        │
        ▼
Execute ExecStart
        │
        ▼
Monitor Process
        │
        ▼
Restart (if configured)
```

---

---

# journalctl Commands

```bash
journalctl -u <service>

journalctl -u <service> -f

journalctl -u <service> -n 20

journalctl --since today

journalctl --since "1 hour ago"
```

---

# Timers

Timers execute **services**, not scripts.

```text
Timer
   │
   ▼
Service
   │
   ▼
Script
```

Example timer:

```ini
[Unit]
Description=Cleanup Timer

[Timer]
OnCalendar=monthly
Persistent=true

[Install]
WantedBy=timers.target
```

---

# Timer Scheduling Examples

| Schedule | Example |
|----------|---------|
| Every minute | `*-*-* *:*:00` |
| Every hour | `hourly` |
| Every day | `daily` |
| Every week | `weekly` |
| Every month | `monthly` |
| Every year | `yearly` |

Other useful directives:

```ini
OnBootSec=30
OnActiveSec=5min
OnUnitActiveSec=10min
```

---

# Targets

Targets represent system states.

Common targets:

- `multi-user.target`
- `graphical.target`
- `rescue.target`
- `emergency.target`

Useful commands:

```bash
systemctl get-default

systemctl list-units --type=target
```

---

# Dependencies

| Directive | Meaning |
|-----------|---------|
| `After=` | Start order |
| `Before=` | Reverse start order |
| `Requires=` | Hard dependency |
| `Wants=` | Soft dependency |

---

# Resource Control (cgroups)

Systemd manages services using Linux cgroups.

Example limits:

```ini
CPUQuota=25%
MemoryMax=200M
TasksMax=20
```

Useful commands:

```bash
systemd-cgls

systemd-cgtop
```

---

# Boot Analysis

```bash
systemd-analyze

systemd-analyze blame

systemd-analyze critical-chain
```

---

# Debugging Workflow

1. Check service status

```bash
systemctl status <service>
```

2. Read logs

```bash
journalctl -u <service>
```

3. Reload unit files

```bash
sudo systemctl daemon-reload
```

4. Restart service

```bash
sudo systemctl restart <service>
```

5. Verify executable path and permissions

---

# Labs Completed

- Created a custom `clock.service`
- Learned service lifecycle
- Managed services using `systemctl`
- Viewed logs with `journalctl`
- Created `auto_clean.service`
- Created `auto_clean.timer`
- Scheduled periodic execution using timers
- Explored targets and dependencies
- Learned cgroups and resource control
- Analyzed the Linux boot process

---
---
# Resources
- https://youtu.be/Kzpm-rGAXos?si=L44NO7BOGu9bdIhO
- https://blog.alphabravo.io/systemd-zero-to-hero-part-1-understanding-the-modern-linux-init-system/
- https://blog.alphabravo.io/systemd-zero-to-hero-part-2-managing-services-and-targets-with-systemctl/
