# YimMenu-player-list
A simple and very small lua script that can grab all players in a session.

> [!NOTE]
> This is not meant for users. This is for script developers to implement in their own scripts.

The current scripts written for YimMenu that have some sort of function executed on a player other than the current user, like a vehicle spawner for example, have to rely on the menu function call:
```lua
network.get_selected_player()
```
which isn't very practicle given that the user would have to click on a player in YimMenu's player list then go back to the script.

With this simple lua, script developers can have their own player list inside their scripts so the user won't have to click outside then go back.

#
>[!WARNING]
>This is for educational purposes only.
