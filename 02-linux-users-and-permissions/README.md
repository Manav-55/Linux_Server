# Linux User Management

## Objective

Understand Linux users, groups and privilege management.

## Concepts

- UID [Unique Identifier]

used to identify the different users.

- GID [Group Identifier]

used to identify the differnent groups.

- Root

Root is the superUser . It has all the administrative privelages in the server.

- Normal User

Normal Users are the different users in the server . You can assign different privelages to the users according to their work . You can do that by editing the
 /etc/sudoers.d/<user> file . 

- Sudo

Short for superuser do . Command-line utility that allows a permitted user to execute a command with administrative (root) privileges.

- Groups

A group is a collection of user accounts that share identical access permissions to files, directories, and system resources.

- Ownership

Ownership defines which user and group have control over a specific file or directory. Every single file, folder, and process on a Linux system must belong to exactly one user and one group

- Permissions

Every group has a certain permissions on a file or a direcotry.
Mainly there are three kind of permission on the file :
    read (r), write(w), and execute(x)

 rwx  :   rwx   :  rwx
(user)  (group)  (other)


## Commands

- adduser

Command line utility that interactively creates users different from <useradd> . Also ask for the metadata information . 

- usermod

Command line utility that modifies a user account . Add a user to the supplementary groups .

- passwd

The passwd command changes passwords for user accounts. A normal user may only change the password for their own account,
While the superuser may change the password for any account.  passwd also changes the account or associated password validity period.

- id

Command line utility that print user and group information for each specified USER, or (when USER omitted) for the current process.

- groups

Print  group  memberships  for each USERNAME or, if no USERNAME is specified, for the current process (which may differ if the groups database has changed).

- whoami

Print the user name associated with the current UID . 

- sudo

sudo  allows  a permitted user to execute a command as the superuser or another user, as specified by the security policy.
The invoking user's real (not effective) user-ID is used to determine the user name with which to query the security  policy.
It supports a plugin architecture for security policies, auditing, and input/output logging.

- chmod

Command line utility that is used to change permission on a file or directory .
The  format  of  a symbolic mode is [ugoa...][[-+=][perms...]...], where perms is either zero or more letters from the set rwxXst, or a single letter from the set ugo.  Multiple symbolic modes can be given, separated by commas.
A combination of the letters ugoa controls which users' access to the file will be changed: the  user  who  owns  it  (u), other  users  in  the  file's  group (g), other users not in the file's group (o), or all users (a).  If none of these are given, the effect is as if (a) were given, but bits that are set in the umask are not affected.

- chown

Command line utility that is used to change ownership of a file or directory.
If only an owner (a user name or numeric user ID) is given, that user is made the owner of each given file, and the files' group is not changed.  If the owner is followed by a colon and a group name (or numeric group ID), with no spaces between them,  the group ownership of the files is changed as well.

## Practical

- Create manav

=> sudo adduser manav

- Grant sudo

=> sudo <command>

- Configure sudoers.d

=> echo "manav ALL=(ALL) ALL" | sudo tee /etc/sudoers.d/manav

User manav may run any command as any user using sudo.

=> sudo chmod 440 /etc/sudoers.d/manav

Because sudo refuses to read files that anyone can modify.

=> sudo visudo -cf /etc/sudoers.d/manav

This checks the syntax without editing.

- Create intern
=> sudo adduser intern

=> intern ALL=(ALL) /usr/bin/systemctl restart nginx

This allows intern to only run specific commands.

- Create service account

=> sudo useradd backup

=> sudo chown backup:backup /var/backups

Even if the backup process is compromised, it won't have root privileges.

## Learnings

Difference between authentication and authorization.

Principle of least privilege.