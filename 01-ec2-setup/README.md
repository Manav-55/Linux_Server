# EC2 Instance Setup

## Objective

Launch an Ubuntu Server 24.04 EC2 instance.

## Concepts

- Amazon EC2
- Key Pair
- Security Groups
- Elastic IP
- Public vs Private IP
- SSH

## Steps

1) Launch Instance


2) Configure Security Group
    For the Inbound Rules:
| Type  | Port | Source                                                 |
| ----- | ---- | ------------------------------------------------------ |
| SSH   | 22   | **My IP** (recommended)                                |
| HTTP  | 80   | Anywhere (`0.0.0.0/0`)                                 |
| HTTPS | 443  | Anywhere (`0.0.0.0/0`)                                 |

NOTE : If your router has a Dynamic IP address , you' ll have to cahnge the SSH source everytime.

3) Create RSA Key Pair

NOTE : You should use ED25519 algorithm. It has faster execution, smaller key sizes, and higher security per bit than RSA. Completely secure against modern cryptographic vulnerabilities.

4) Download PEM file

5) Connect using SSH

=> ssh -i "path_to_your_PrivateKey" <user>@IP_of_server

Note: Your private key should have read and write privelages through administrative only . 

## Verification

Successfully connected through SSH.

## Problems Faced

Windows PEM permission issue

Fixed using icacls.

## Learnings

Difference between Security Groups and Firewalls.