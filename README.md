# Log Rotation Script for MyComp

This project contains a Bash script that automates the process of log rotation for specified services like `httpd` and `sshd`. The script rotates logs, compresses old logs to save disk space, removes logs older than a specified period, and sends a notification email once the log rotation is complete.

## Features

- **Log Rotation**: Automatically rotates log files for specified services (`httpd`, `sshd`, etc.).
- **Compression**: Compresses old log files to save disk space.
- **Retention Policy**: Removes log files older than a specified number of days (default is 30 days).
- **Notification**: Sends an email notification to the system administrator after each log rotation operation.
- **Automation**: The script can be scheduled to run automatically at regular intervals using cron.

## Files

- `log_rotation.sh`: The main script that handles log rotation, compression, log file deletion, and notification.

## Prerequisites

1. **mailutils**: Required to send email notifications.
   ```bash
   sudo apt-get install mailutils  # For Debian-based systems
   sudo yum install mailx          # For Red Hat-based systems
   suod dnf insatll procmail       # For Red Hat-based systems
gzip: The script uses gzip to compress log files (usually pre-installed on most Linux systems).
How to Use
Clone this repository to your server:

bash
git clone https://github.com/your-username/log-rotation.git
cd log-rotation-mycomp
Make the script executable:

bash
chmod +x log.sh
Update the script configuration:

LOG_DIRS: List the directories where log files for the specified services are stored (e.g., /var/log/httpd, /var/log/sshd).
RETENTION_DAYS: Specify how many days to retain old log files (default is 30 days).
ADMIN_EMAIL: Set the system administrator's email address to receive notifications.
Run the script manually to verify functionality:

bash
sudo ./log.sh
The log file for the operation will be stored at /var/log/log_rotate.log.

Setting up Automation with Cron
To automate the script and run it weekly:

Open the crontab editor:

bash
crontab -e
Add the following line to schedule the script to run every Sunday at midnight:

bash
0 0 * * 0 /path/to/log_rotation.sh
Verify the cron job is set up correctly:

bash
crontab -l
Example Output
Upon running the script, the following messages will be logged in /var/log/log_rotate.log:

lua
2024-10-10 00:00:01 - Starting log rotation...
2024-10-10 00:00:02 - Rotated: /var/log/httpd/access.log
2024-10-10 00:00:02 - Rotated: /var/log/httpd/error.log
2024-10-10 00:00:03 - Starting log compression...
2024-10-10 00:00:04 - Compression completed for directory: /var/log/httpd
2024-10-10 00:00:05 - Sending notification email...
2024-10-10 00:00:06 - Notification email sent.
The log file provides a detailed account of each step taken, including the rotation, compression, and notification status.

Verifying the Script
To check if the logs are rotated and compressed, you can list the log files in the specified directories:

bash
ls /var/log/httpd
After the script runs, you should see the compressed logs (with .gz extension) and a new log file for the current day.

You can also check the /var/log/log_rotate.log file for a summary of the operations performed.

To verify that the email notification was sent, check the inbox of the specified ADMIN_EMAIL.

