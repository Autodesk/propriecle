# Propriétaire de la Clé ; The Key Owner

This tool provides safe interaction patterns around interactions with Vault master key concepts. As of now, it provides a Python/ncurses interface around the following operations

* Initializing a fresh Vault instance with GPG protected root and unseal keys
* Sealing of a Vault instance using a GPG protected root key
* Unsealing of a Vault instance using GPG protected unseal keys
* Rekeying with new GPG protected unseal keys
* Rotation of the master key
* Regeneration of a new GPG protected root key
* Stepping down of a HA Leader server

## Running

It is possible to run propricle both interactively and as a scriptable command line tool. If you invoke it with out any arguments (or setting any configuration parameters) it will look for it's configuration directory in `~/.propriecle` and a configuration file in `~/.proprieclerc` and start the interactive ncurses based GUI. You can override the file paths with the `PROPRIECLE_DIRECTORY` and `PROPRICLE_CONFIG` environment variables.

Non interactive mode makes use of the same environment variables and encapsulates what is available via the gui, plus a few other options. Each operation takes a single argument of a Vault instance name (as specified in the configuration file).

* `unseal` will attempt to use every applicable key to unseal the vault instance
* `seal` will make use of the root token to seal the vault instance
* `init` will initialize a fresh vault instance, properly encrypting the root and unseal keys
* `step_down` will ask a vault ha leader to step down and become standby
* `root_get` will print the root token to stdout
* `rekey_start` will begin the process of rekeying unseal keys
* `rekey_auth` will attempt to use every applicable key to rekey unseal keys
* `rekey_cancel` will cancel the process of rekeying unseal keys
* `regenreate_start` will begin the process of generating a new root token
* `regenerate_auth` will attempt to use every applicable key to generate a new root token

## Configuration

It is configured with a simple YML file. When refferring to GPG keys you may use either a shortened GPG fingerprint ID or a a keybase username with a prefix. I.e. `keybase:otakup0pe` would encrypt things against that keybase ID. The following configuration items are supported.

* `root_key` the GPG key to encode the root token against.
* `keys` a list of GPG keys to encode unseal keys against. This will affect how many _total_ keys are requested during init, rekey, and regenerate operations.
* `required` is the _minimum_ number of keys required for init, rekey, and regenerate operations.
* `backup` is a boolean that controls whether spares of the unseal keys are kept on the Vault instance.
* `vaults` is a list of Vault instances to interact with. You can specify both a friendly `name` and the `url`.

## TODO

* Ability to execute seal/unseal actions across entire cluster
* Tests, Docker
* Can you rekey gpg unseal keys?
* Start UI thread prior to http threads
* Make sure the http check thread timeout is low. Might have to mod hvac for this?
* Make sure Python3.5 works!
* Validate Keys at startup (remove the case of a init failing due to bad keys)
* Collapse associated servers to their parent
* Less terrible errors
* Friendly import/export of keys?
* Support non-root admin users

## Guidelines

* This project operates under a [Code of Conduct](https://autodesk.github.io/aomi/code_of_conduct).
* Changes are welcome via pull request!
* Please use informative commit messages and pull request descriptions.
* Please remember to update the documentation if needed.
* Please keep style consistent. This means PEP8 and pylint compliance at a minimum.
* Please add both unit and integration tests. Unit tests should run in complete isolation with all disk/network calls mocked out.

If you have any questions, please feel free to contact <jonathan.freedman@autodesk.com>.
