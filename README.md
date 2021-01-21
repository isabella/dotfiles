# dotfiles

```
git clone --bare https://github.com/nitsky/dotfiles .dotfiles
git --git-dir .dotfiles --work-tree . checkout master
git --git-dir .dotfiles config status.showUntrackedFiles no
```

```
efibootmgr --bootnum 0000 --delete-bootnum
efibootmgr --create --bootnum 0000 --disk /dev/nvme0n1 --label "linux" --loader /vmlinuz-linux --unicode 'root=UUID=782327a0-0bec-4cf5-8aea-fad05f25acee resume=UUID=bc69cd92-bab1-4a21-88ab-69b559e27873 rw initrd=\amd-ucode.img initrd=\initramfs-linux.img'
```
