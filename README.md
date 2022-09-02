# dotfiles

```
git clone --bare https://github.com/nitsky/dotfiles .dotfiles
git --git-dir .dotfiles --work-tree . checkout master
git --git-dir .dotfiles config status.showUntrackedFiles no
```

```
defaults write -g ApplePressAndHoldEnabled -bool false
```
