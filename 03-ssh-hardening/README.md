# SSH Hardening

## Objective

Secure remote access to the EC2 instance.

---

## Theory

- What is SSH?

Secure Shell is a cryptographic protocol which allow you to securely connect , manage and execute commands on a remote server over an unsecured network .
Port 22 is the default port for SSH. 
To establish this connection safely, it utilizes three main cryptographic layers: 

1) Asymmetric Cryptography: Used initially to verify the identities of both the client and server, and to securely negotiate a temporary session key without exposing it to the network. 
2) Symmetric Cryptography: Used to encrypt the entire data transmission once the secure session is active, ensuring outsiders cannot read passwords or typed commands. 
3) Hashing: Formulates unique mathematical check-sums to prove data integrity and verify that packets have not been altered or tampered with in transit. 

- How SSH authentication works

It utilizes a cryptographic key pair: a Public Key placed on the server, and a matching Private Key kept strictly secret on your local device. The server issues a challenge that only the matching private key can solve, creating a secure, passwordless login environment. 

        Your Laptop
    ----------------------
        Private Key (.pem)
            |
            | proves identity
            v
          Internet
            |
            v
        EC2 Instance
    -------------------------
        authorized_keys
        (Public Key)

- Public Key & Private Key

Public and private keys are a pair of mathematically linked cryptographic codes used in asymmetric encryption. 

Private key Encryption, also termed as symmetric Key Encryption requires the key that is used to lock and the key used to unlock the message. This key must be kept concealed between the two communicating entities to have reasonable security.
Public Key Encryption, or Asymmetric Encryption, involves a pair of keys: There is the public key that is relatively known and the private key which is kept secret. While the public key where everyone can get it from the internet is for encoding or encryption, the private key is employed for decoding, decryption.

- authorized_keys

The AWS automatically places the public key into the /home/ubuntu/.ssh/authorized_keys . 
Your new user has no such key yet.
=> mkdir -p ~/.ssh

.ssh stores SSH configuration and keys.

=> chmod 700 ~/.ssh

only the owner can access the directory(every permission)

=>ssh-keygen -y -f ~/.ssh/id_rsa.pem > ~/.ssh/id_rsa.pub

now copy the id_rsa.pub content to the authorized_keys

=>chmod 600 ~/.ssh/authorized_keys

Owner can only read and Write .  SSH enforces these permissions for security.

- known_hosts

known_hosts file in Linux is a vital security feature of the Secure Shell (SSH) protocol. It acts as a local database that stores the unique public keys of all remote servers you have successfully connected to from your machine.

- SSH Daemon

An SSH Daemon (commonly known as sshd) is a continuous background process running on a Linux server that listens for incoming SSH connection requests. While the ssh command is the client you use to connect out, sshd is the server component that allows connections in.

- sshd_config

Master configuration file for the SSH Daemon (sshd). It dictates exactly how your Linux server handles security, user authentication, and network connections.

## Architecture

Laptop

↓

Private Key

↓

Internet

↓

EC2

↓

SSH Daemon

↓

authorized_keys

---

## Initial Configuration

- SSH service was running.
- Login was possible using the `ubuntu` user.
- SSH key authentication was enabled.
- Password authentication was enabled (or verify from the config).
- Root login policy was the Ubuntu default.
- Firewall (UFW) was disabled.
- Port 22 was used for SSH.

---

## Hardening Steps
For the hardening steps I have referred to this resource : https://linuxize.com/post/ssh-hardening-best-practices/

NOTE : Make sure you have another terminal or user with privelages or other ways to login the server.

1) Firstly backup the ssh_config file before editing
=>sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup

2) In the /etc/ssh/sshd_config file edit :

Password authentication is vulnerable to brute-force attacks. Key-based authentication is more secure because it requires possession of the private key.
- PasswordAuthentication no
- KbdInteractiveAuthentication no
- PubkeyAuthentication yes


Allowing direct root login over SSH is a security risk. Attackers commonly target the root account in brute-force attacks.
- PermitRootLogin no

The LoginGraceTime setting controls how long the server waits for a user to authenticate before disconnecting. The default is 120 seconds, which is too long:
- LoginGraceTime 30

Reduce the number of authentication attempts per connection to slow down brute-force attacks:
- MaxAuthTries 3 

If you do not need to forward graphical applications over SSH, disable X11 forwarding:
- X11Forwarding no

Agent forwarding lets a remote server use your local SSH agent for onward connections. Disable it unless users need to connect from this server to other hosts with forwarded credentials:
- AllowAgentForwarding no

- NOTE : You can add more security by adding other options but most of them are for particular use cases.

---

## Verification

After each change, test the configuration before restarting SSH:

=> sudo sshd -t

If the command prints no output, the configuration syntax is valid. Then restart the SSH service:
On some distributions the service is named sshd

=> sudo systemctl restart ssh/sshd


---

## Problems

Windows PEM permissions

Locked out risk

---

## Learnings

Difference between SSH client and daemon.

Difference between public and private keys.

Why root login should be disabled.

How SSH validates users.