# UFW Firewall

## Objective

Protect the server using host-based firewall rules.

## Theory

### What is a Firewall?

A firewall is a security mechanism that monitors and controls incoming and outgoing network traffic based on a predefined set of rules. It acts as the first line of defense by deciding which network connections are allowed to reach a system and which should be blocked.

Firewalls operate by examining packets and comparing them against configured rules. If a packet matches an allow rule, it is permitted; otherwise, it may be denied or rejected depending on the firewall policy.

---

### Why is a Firewall Needed?

A server connected to the Internet can be scanned continuously by automated bots and malicious actors searching for open ports and vulnerable services.

Without a firewall:

* Every service listening on the server is potentially reachable from the Internet.
* Unnecessary services increase the attack surface.
* Attackers can attempt to exploit exposed applications.

A properly configured firewall minimizes this risk by exposing only the services that are intended to be publicly accessible.

---

### Types of Firewalls

- Network Firewall

A network firewall filters traffic before it reaches the server.

In AWS, **Security Groups** act as a virtual network firewall for EC2 instances. They control inbound and outbound traffic at the cloud infrastructure level.

- Host-Based Firewall

A host-based firewall runs directly on the operating system and filters traffic that reaches the server.

On Ubuntu, **Uncomplicated Firewall (UFW)** is the recommended interface for managing Linux firewall rules. UFW simplifies the configuration of the Linux Netfilter framework.

---

### AWS Security Groups vs UFW

Both Security Groups and UFW can filter network traffic, but they operate at different layers.

| AWS Security Group                                    | UFW                                               |
| ----------------------------------------------------- | ------------------------------------------------- |
| Cloud-level firewall                                  | Operating system firewall                         |
| Configured from the AWS Console                       | Configured inside Ubuntu                          |
| Filters traffic before it reaches the instance        | Filters traffic after it reaches the instance     |
| Protects the EC2 instance at the infrastructure level | Protects services running on the operating system |

A packet must pass through both layers before reaching an application.

```
Internet
        │
        ▼
AWS Security Group
        │
        ▼
UFW (Ubuntu Firewall)
        │
        ▼
Application (SSH, Nginx, etc.)
```

---

### Default Firewall Policies

A secure firewall configuration follows the **Principle of Least Privilege**, allowing only the traffic required for the server to function.

Typical default policies are:

* Deny all incoming connections.
* Allow all outgoing connections.
* Explicitly allow only the required ports.

For example:

* TCP 22 – SSH
* TCP 80 – HTTP
* TCP 443 – HTTPS

---

### Allow vs Deny Rules

Firewall rules determine whether specific traffic is accepted or blocked.

* **Allow Rule:** Permits traffic that matches the specified criteria.
* **Deny Rule:** Blocks matching traffic.

Rules can be based on:

* IP address
* Port number
* Network protocol (TCP/UDP)
* Network interface

---

### Why UFW?

Although Linux provides firewall functionality through Netfilter, configuring it directly using iptables or nftables can be complex.

UFW provides a simpler interface for common administrative tasks while still configuring the underlying firewall framework.

Examples include:

* Allow SSH access
* Block unnecessary ports
* Enable or disable the firewall
* Display active firewall rules

---

### Principle of Least Privilege

A firewall should expose only the services that are necessary.

For a newly created EC2 instance used for administration, only SSH should be accessible.

When a web server is deployed, HTTP and HTTPS ports can be opened while keeping all other ports blocked.

This minimizes the attack surface and reduces the likelihood of unauthorized access.

---

## Commands

- ufw enable

reloads firewall and enables firewall on boot.

- ufw disable 

unloads firewall and disables firewall on boot.

- ufw status

show status of firewall and ufw managed rules. Use status verbose for extra  information.  In  the  status  output, 'Anywhere' is synonymous with 'any', 0.0.0.0/0 (IPv4) and ::/0 (IPv6). Note that when using status, there is a subtle difference when reporting interfaces.

use => sudo ufw status numbered

- ufw allow

Users can specify rules using either a simple syntax or a full syntax. The simple syntax only specifies the port  and  optionally the protocol to be allowed or denied on the host.

=> ufw allow 25/tcp

NOTE : Do this command  

=>sudo ufw allow OpenSSH

- ufw deny

=> ufw deny proto tcp to any port 80

- ufw delete

To delete a rule, simply prefix the original rule with delete with or without the rule comment.

=> sudo ufw delete 2

## Rules

- Allow SSH

=> sudo ufw allow OpenSSH

- Allow HTTP

=> sudo ufw allow 80/tcp

- Allow HTTPS

=> sudo ufw allow 443/tcp

## Verification

After configuring the firewall, verify that:

* The firewall is active.
* SSH access is still available.
* Only the required ports are open.
* Unnecessary services remain inaccessible.

Regular verification ensures that firewall rules continue to enforce the intended security policy.

## Learnings

Difference between cloud firewall and OS firewall.