# Warn

[![Build Status](https://travis-ci.com/inferno-collection/Warn.svg?branch=master)](https://travis-ci.com/inferno-collection/Warn)

A very basic warn command, created in responce to [this post on the FiveM Forums](https://forum.fivem.net/t/help-please-warn-command/732378). Resource contains one commad, and a steam hex whitelist file.

```
/warn <player id> {optional details}
```
Displays a message on the persons screen. Automatically adds issuer's name on end of warning.

## Install
1. [Download a copy](https://github.com/inferno-collection/Warn/archive/master.zip) of the resource.
2. Move the `[inferno-collection]` folder into your `resources` folder.
3. Add `start inferno-warn` to your `server.cfg` file.
4. Open the `[infero-collection]/inferno-warn/whitelist.json` file.
5. [Using VACBanned.com](http://vacbanned.com/), find your `Steam3 ID (64bit)` `(Hex)`, and replace it with the one in the `whitelist.json` file.
6. To add more than one person, copy and paste the entry, [as seen in this image](https://i.imgur.com/BN405bH.png).
7. Enjoy!

## Pictures
### Example usage of Warning Command
![Example usage of Warning Command](https://i.imgur.com/Z66lOmY.png)
### Reciving a custom Warning
![Reciving a Warning](https://i.imgur.com/4e6bLfM.png)
### Reciving a default Warning
![Reciving a Warning](https://i.imgur.com/tjLZFT6.png)
### Access Denied
![Access Denied](https://i.imgur.com/t4sKTQj.png)
