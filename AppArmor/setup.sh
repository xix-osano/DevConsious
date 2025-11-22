#!/bin/bash
#
# AppArmor Infrastructure Setup Script (Arch Linux)
#
# This script performs the following actions:
# 1. Installs necessary packages (AppArmor, auditd, aa-notify dependencies).
# 2. Configures auditd logging permissions for the current user.
# 3. Creates the custom storage directory for your profiles.
# 4. Sets up aa-notify to run on desktop session login.
#
# Usage: ./setup_apparmor_infrastructure.sh

set -e # Exit immediately if a command exits with a non-zero status.

# --- USER-DEFINED VARIABLES ---
CUSTOM_PROFILE_STORAGE="/opt/apparmor-custom-profiles"
NOTIFY_UNIT_PATH="$HOME/.config/systemd/user/apparmor-notify.service"

echo "================================================="
echo "🛡️ AppArmor Infrastructure Setup Started"
echo "================================================="

## --- 1. Installation of Core Components ---
echo "1. Installing core packages: apparmor, auditd, and aa-notify dependencies..."
sudo pacman -S --noconfirm apparmor audit tk python-notify2 python-psutil || { echo "Failed to install core packages. Aborting."; exit 1; }
sudo systemctl enable --now auditd || { echo "Failed to enable auditd. Check logs."; exit 1; }

## --- 2. Configure Logging Permissions ---
echo "2. Configuring auditd logging permissions for user: ${USER}"
if ! grep -q "log_group = log" /etc/audit/auditd.conf; then
    echo "   Updating /etc/audit/auditd.conf (setting log_group = log)..."
    sudo sed -i 's/^log_group = root/log_group = log/' /etc/audit/auditd.conf
fi

if ! groups | grep -q "\blog\b"; then
    echo "   Adding user ${USER} to 'log' group. Requires log out/in to take effect."
    sudo usermod -aG log "${USER}"
fi

echo "   Reloading auditd to apply log_group change..."
sudo systemctl reload auditd

## --- 3. Create Custom Profile Storage ---
echo "3. Creating custom profile storage directory: ${CUSTOM_PROFILE_STORAGE}"
sudo mkdir -p "$CUSTOM_PROFILE_STORAGE"
sudo chown "${USER}":users "$CUSTOM_PROFILE_STORAGE"

## --- 4. Configure aa-notify Autostart (Systemd User Unit) ---
echo "4. Setting up aa-notify autostart via systemd user unit..."

mkdir -p "$HOME/.config/systemd/user"

# Create the user service unit file for aa-notify
tee "$NOTIFY_UNIT_PATH" > /dev/null << EOF
[Unit]
Description=AppArmor Denial Notifier
After=graphical-session.target

[Service]
ExecStart=/usr/bin/aa-notify -p -s 1 -w 60 -f /var/log/audit/audit.log
Restart=on-failure
StandardOutput=journal

[Install]
WantedBy=graphical-session.target
EOF

# Enable and start the user service
systemctl --user daemon-reload
systemctl --user enable --now apparmor-notify.service

echo "================================================="
echo "✅ Infrastructure Setup Complete!"
echo "================================================="
echo "NEXT STEPS (Manual Deployment):"
echo "1. Log out and log back in (required for group/notify changes)."
echo "2. Copy your AppArmor profiles into: ${CUSTOM_PROFILE_STORAGE}"
echo "3. Load them into the kernel using the command below:"
echo "   sudo ln -sf ${CUSTOM_PROFILE_STORAGE}/* /etc/apparmor.d/"
echo "   sudo apparmor_parser -r /etc/apparmor.d/*"