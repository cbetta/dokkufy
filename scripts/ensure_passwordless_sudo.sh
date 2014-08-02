line="%$USER         ALL = (ALL) NOPASSWD: ALL"

if ! sudo grep -qe "$line" "/etc/sudoers"; then
  echo "Adding sudoers"
  sudo bash -c "echo '$line' >> /etc/sudoers"
fi
