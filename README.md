# How to use
The script is a standalone program `.exe` file, but it does require the external map mod to run while running Wurm Unlimited.
You can find that mod here: https://github.com/Snidor/ExternalMapMod/releases/tag/0.2.1

Set the external map to 1000 pixels by 1000 pixels (which is what I am basing all tile calculations of at the moment)
you can do this by pressing F1 in game and running the command `toggleexternalmap 1000`.

After this you can run the `hunt-v[version].exe` file.

Here you'll see a UI that looks like this: https://imgur.com/a/mpB2A3L
Here you can select the distance based on the treasure map reading. And the direction based on your orientation, and directions on the treasure map.
For example:
you face north, and you get a reading that states: `The marked spot is very far away ahead of you to the right`
This means you select "Very far" from the first dropdown, and "North-East" from the second dropdown

Now you click draw, and the program will try to find the external map mod (based on the name of the window, which is currently set to "Sklotopolis")
and then find your little square. After which it will draw two pie slices in the direction you gave it. https://imgur.com/a/A57LzJN
Beyond the white line, and before the end of the largest slice is where you should look for maps.
However!!: The Very far away option, means the map is 2000+ tiles away from you, so the white line is the 2000 tiles, and everything after that is up to you.
but the slices do give you an indication of the direction to look for

The clear button does exactly as it states. It clears the drawings, and the Exit button will attempt to clear any drawings before it exits the program.


## Final note:
The "Select map size" option is meant for when the map you're playing on is an actual larger or smaller size map. Pick carefully. 
Sklotopolis plays at 2 4K maps and 1 2K map, so use the selection accordingly!

Happy hunting!

# Roadmap

### General additions
- Create tabs for the various sections (eg. drawing, settings, information)
- Add information to the window, to show what the current settings are, and which message is displayed
- Replace the dropdown selection with a "copy map line here" text box
- Add color picker for the smaller and larger pie slice

### Map related additions 
- Incorporate own external map window (If possible) Maybe by using the Sklotopolis live map from browser
- Remove the need for the external map mod entirely (if possible)
- Add zoom option to the map
- Recalculate tile sizes based on zoom levels

# Changelog (based on commits)

### v2.0.0-Alpha1
## features
- Added comments to all the methods
- Refactored the Gui.Clear() parts that would double destroy a GUI, resulting in errors
- removed the hotkey functions
- added a GUI that handles all the old hotkey functions
- added tabs to the GUI
    - how to
    - info
    - draw
    - settings
- added more settings, which allows for the selection of ingame map size, screen size,

## bugfixes
- fixed an issue where drawing was only half the size it was supposed to be

### v2.0.1-Alpha1
#### Features
- Added the color picker implementation
- optimized the default settings

#### Bugfixes
- fixed an issue where the default settings would result in everything being drawn out of proportions
- Fixed an issue where the colors would result in errors