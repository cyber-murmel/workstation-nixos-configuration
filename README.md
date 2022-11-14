# workstation-nixos-configuration
/etc/nixos/ configuration for workstations

This repos contains all non-hardware specific configuration for a NixOS server setup.

## Installation
For installation it is easiest to clone this installation via https into the config directory.
```shell
# after generation of initial configuration files
sudo git clone https://github.com/cyber-murmel/workstation-nixos-configuration.git /mnt/etc/nixos/workstation-nixos-configuration
# import repo directory in config
sudo sed -i -e 's/.\/hardware-configuration.nix/.\/hardware-configuration.nix\n      .\/workstation-nixos-configuration/g' /mnt/etc/nixos/configuration.nix
# inspect
head /mnt/etc/nixos/configuration.nix -n 12
```

## Customization
Change the [password of the user](users/user.nix#L5).
Run `mkpasswd --method=sha-512` to enter the password interactively or `echo -ne ${PASSWORD} | mkpasswd --stdin --method=sha-512`.

## Runtime
First add the Home Manager channel.
```shell
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz home-manager
sudo nix-channel --update
```

For management of the configuration after installation I advise to clone this repository with a sudo user into its home and symlink it.
```shell
git clone https://github.com/cyber-murmel/server-nixos-configuration.git ~/repos/server-nixos-configuration
sudo rm -rf /etc/nixos/server-nixos-configuration
sudo ln -s ~/repos/server-nixos-configuration /etc/nixos/server-nixos-configuration
```

Test the config.
```shell
sudo nixos-rebuild test
```
