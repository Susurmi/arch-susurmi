## Setting up steam on arch

Enable multilib repos by uncommenting these lines in:

> /etc/pacman.conf

```
[multilib]
Include = /etc/pacman.d/mirrorlist
```

then upgrade the system by :

```sh
sudo pacman -Syyu
```

it should now show the multilib repo.

afterwards follow driver install guide from the [Lutris Repo](https://github.com/lutris/docs/blob/master/InstallingDrivers.md#arch--manjaro--other-arch-linux-derivatives).

then install steam :

```sh
sudo pacman -S steam
```

optional download [proton ge](https://github.com/GloriousEggroll/proton-ge-custom/releases/)

and set it up as shown in the [repo instructions](https://github.com/GloriousEggroll/proton-ge-custom#installation).
