# Backup Project

## Features

- Reads configuration from `config.conf`
- Creates archive directory automatically
- Backs up multiple source directories
- Creates timestamped `.tar.gz` archives
- Logs all backup operations
- Deletes archives older than the configured retention period
- Supports automated execution using cron

## Project Structure

```
backup-project/
├── backup.sh
├── config.conf
├── logs/
│   └── backup.log
├── archives/
│   └── *.tar.gz
└── README.md
```

## Run Manually

bash
=> chmod +x backup.sh
=> ./backup.sh


## Schedule with Cron

=> crontab -e

Add:

cron
0 2 * * * /home/<username>/backup-project/backup.sh
