# Dokkufy

A [Dokku](https://github.com/progrium/dokku) toolbelt inspired by the [Heroku toolbelt](https://toolbelt.heroku.com/)

## Planned commands

```sh
dokkufy <command>
  help              shows this list
  server            installs Dokku on a Ubuntu 12.04 or 14.04 server
  server:upgrade    upgrades a Dokku server
  plugin:list       shows a list of Dokku plugins
  plugin:install    installs a plugin on the server
  plugin:uninstall  uninstalls a plugin on the server
  app               adds a dokku remote for a server to an app

dokku <command>     runs dokku commands on the server attached to this app
```

## Implemented commands

Most commands take their parameters as command line arguments or through an interactive prompt.

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

## Release notes

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
