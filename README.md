# Dokkufy

A [Dokku](https://github.com/progrium/dokku) toolbelt inspired by the [Heroku toolbelt](https://toolbelt.heroku.com/)

## Planned commands

```sh
dokkufy <command>
  help              shows this list
  server            installs Dokku on a Ubuntu 12.04 or 14.04 server
  server:upgrade    upgrades a Dokku server
  plugins           shows a list of Dokku plugins
  plugins:install   installs a plugin on the server
  app               adds a dokku remote for a server to an app

dokku <command>     runs dokku commands on the server attached to this app
```

## Implemented commands

### dokkufy server

```sh
dokkufy server <hostname> <username> <domain> --version <version>
```

Installs dokku on server at IP or Hostname `<hostname>`, using the `<username>` account to install the software.

It also sets up the app on domain `<domain>`, resulting in all apps being served as a subdomain of that domain.

Optionally this takes a `<version>` to specify the [Dokku tag](https://github.com/progrium/dokku/tags).
## Release notes

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
