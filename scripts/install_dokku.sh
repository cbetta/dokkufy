# wget -qO- https://raw.github.com/progrium/dokku/v0.2.3/bootstrap.sh | sudo DOKKU_TAG=v0.2.3 bash
VERSION=$(lsb_release -sr)
OLD_VERSION="12.04"

if [ "$VERSION" == "$OLD_VERSION" ]; then
  # required for 12.04
  sudo apt-get install -y python-software-properties
else
  # required workaround for bug on 14.04
  wget -qO- https://raw.github.com/progrium/dokku/$OPTION1/bootstrap.sh | sudo DOKKU_TAG=v0.2.3 bash
fi

wget -qO- https://raw.github.com/progrium/dokku/$OPTION1/bootstrap.sh | sudo DOKKU_TAG=v0.2.3 bash
