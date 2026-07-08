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

Launch Instance

Configure Security Group

Create RSA Key Pair
NOTE : You should use ED25519 algorithm. It has faster execution, smaller key sizes, and higher security per bit than RSA. Completely secure against modern cryptographic vulnerabilities.

Download PEM file

Connect using SSH

## Verification

Successfully connected through SSH.

## Problems Faced

Windows PEM permission issue

Fixed using icacls.

## Learnings

Difference between Security Groups and Firewalls.