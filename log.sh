#!/bin/bash

# Configuration
LOG_DIRS=("/var/log/httpd" "/var/log/sshd") # Directories to rotate logs for specified services
RETENTION_DAYS=30
ADMIN_EMAIL="admin@mycomp.com"
LOG_FILE="/var/log/log_rotate.log"  # Path to log file

# Function to log messages
log_message() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Rotate logs
rotate_logs() {
  log_message "Starting log rotation..."
  for dir in "${LOG_DIRS[@]}"; do
    if [ -d "$dir" ]; then
      for file in "$dir"/*.log; do
        if [ -f "$file" ]; then
          mv "$file" "$file.$(date +%Y%m%d%H%M%S)"
          touch "$file"
          log_message "Rotated: $file"
        fi
      done
    else
      log_message "Directory not found: $dir"
    fi
  done
}

# Compress old logs
compress_logs() {
  log_message "Starting log compression..."
  for dir in "${LOG_DIRS[@]}"; do
    if [ -d "$dir" ]; then
      find "$dir" -type f -name "*.log.*" -exec gzip {} \;
      log_message "Compression completed for directory: $dir"
    else
      log_message "Directory not found: $dir"
    fi
  done
}

# Remove logs older than retention period
remove_old_logs() {
  log_message "Removing old logs..."
  for dir in "${LOG_DIRS[@]}"; do
    if [ -d "$dir" ]; then
      find "$dir" -type f -name "*.gz" -mtime +$RETENTION_DAYS -exec rm {} \;
      log_message "Old logs removed for directory: $dir"
    else
      log_message "Directory not found: $dir"
    fi
  done
}

# Send notification
send_notification() {
  log_message "Sending notification email..."
  echo "Log rotation completed on $(date)" | mail -s "Log Rotation Notification" $ADMIN_EMAIL
  log_message "Notification email sent."
}

# Main
rotate_logs
compress_logs
remove_old_logs
send_notification

