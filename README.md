# Dokkufy

[![Gem Version](https://badge.fury.io/rb/dokkufy.svg)](http://badge.fury.io/rb/dokkufy) [![Code Climate](https://codeclimate.com/github/cbetta/dokkufy/badges/gpa.svg)](https://codeclimate.com/github/cbetta/dokkufy) ![](http://ruby-gem-downloads-badge.herokuapp.com/dokkufy?type=total)


A [Dokku](https://github.com/progrium/dokku) toolbelt inspired by the [Heroku toolbelt](https://toolbelt.heroku.com/)

## Installation

```
gem install dokkufy
```

## Basic usage

Want to build your own Heroku? Dokku and Dokkufy make this possible.

1. Spin up a Ubuntu 12.04 or 14.04 server
2. Dokkufy your server using `dokkufy server`
3. Change directories to your app
4. Dokkufy your app `dokkufy app`
5. Deploy your app `git push dokku master`
6. Control your app using the `dokku` command (see `dokku help` for available commands)

## Commands

Most commands take their parameters as command line arguments or through an interactive prompt.

```
dokkufy <command>
  help              shows this list
  server            installs Dokku on a Ubuntu 12.04 or 14.04 server
  server:upgrade    upgrades a Dokku server
  plugin:list       shows a list of Dokku plugins
  plugin:install    installs a plugin on the server
  plugin:uninstall  uninstalls a plugin on the server
  app               adds a dokku remote for a server to an app
  app:clear         removes a dokku remote for a server for an app

dokku <command>     runs dokku commands on the server attached to this app
```

### dokkufy server

```sh
dokkufy server <hostname> <username> <domain> --version <version>
```

Installs Dokku on server at IP or Hostname `<hostname>`, using the `<username>` account to install the software.

It also sets up the app on domain `<domain>`, resulting in all apps being served as a subdomain of that domain.

Optionally this takes a `<version>` to specify the [Dokku tag](https://github.com/progrium/dokku/tags).

### dokkufy plugin:list

```sh
dokkufy plugin:list
```

Lists all plugins as listed on the [Dokku wiki](https://github.com/progrium/dokku/wiki/Plugins). Only supports plugins that follow the standard install procedure.

### dokkufy plugin:install

```sh
dokkufy plugin:install <plugin_name_or_id> [<hostname> <username>]
```

Installs a Dokku plugin either by name or ID (as received by `dokkufy plugin:list`) on a server. Only supports the standard install procedure. Check the plugins wiki for any additional install notes.

### dokkufy plugin:uninstall

```sh
dokkufy plugin:uninstall <plugin_name_or_id> [<hostname> <username>]
```

Uninstalls a Dokku plugin either by name or ID (as received by `dokkufy plugin:list`) on a server. Simply performs a delete of the folder. Server instances already deployed with this plugin will need to be redeployed.

### dokkufy app

```sh
dokkufy app <git_repo> [OR <hostname> <dokku_username>]
```

Adds a dokku remote to the local git repository for an app. Also writes this remote to a `.dokkurc` file.

### dokkufy app:clear

```sh
dokkufy app:clear
```

Removes any `dokku` remotes for the local git repository and deletes the `.dokkurc` file.

### dokku

```sh
dokku <command>
```

Runs the command on the Dokku server attached to this app. Intelligently determines the remote address if the app has been dokkufied, and automatically adds the app name where needed.

Some examples:

```sh
dokku help    # runs `dokku help` on server
dokku run ls  # runs `dokku run <app_name> ls` on server
```

Every `dokku` command translates to an auto generated ssh call. The `<app_name>` is automatically added if the response returns a "App <command> not found".

Some examples

```sh
cat .dokkurc # content of the .dokkurc
$ dokku@example.com:test_app
dokku help
$ ssh -t dokku@example.com help # the actual command executed
dokku run ls # a command that requires an app name
$ ssh -t dokku@example.com run test_app ls
```

## Release notes

* **0.1.5** Using classic style commander 
* **0.1.4** Checks for SSH key before installing on server
* **0.1.3** Applies double install fix on 14.04
* **0.1.0** Adds the `dokku` command
* **0.0.7** Adds the (un)dokkufication of apps
* **0.0.6** Adds plugin uninstall
* **0.0.5** Small bug fix to plugin installs
* **0.0.4** Adds plugin listing and installing
* **0.0.3** Determines latest version from Dokku github page
* **0.0.2** Added `server` command
* **0.0.1** Gem skeleton

## Contributing

1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request

## License

See [LICENSE](https://github.com/cbetta/dokkufy/blob/master/LICENSE)
