# How to use
The script is a standalone program `.exe` file, but it does require the external map mod to run while running Wurm Unlimited.
You can find that mod here: https://github.com/Snidor/ExternalMapMod/releases/tag/0.2.1

Set the external map to your desired size, and make sure to check the settigs tab to set the size in there too! The default size of the hunting program is 1000x1000 pixels.
You can set your external map to the default size by running the `toggleexternalmap 1000` in the console ingame.

In the `hunt.exe` file head over to the settings tab, and set the proper external screen size to the same size you've set it ingame.
Here you can check out any additional setings you might want to update. For example, if you're on Caza, set the ingame map size to 2K!

At the "Drawing" tab you can select the distance based on the treasure map reading. And the direction based on your orientation, and directions on the treasure map.
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
- Create tabs for the various sections (eg. drawing, settings, information) (COMPLETE)
- Add information to the window, to show what the current settings are, and which message is displayed (COMPLETE)
- Replace the dropdown selection with a "copy map line here" text box
- Add color picker for the smaller and larger pie slice (COMPLETE)
- Add the option to read multiple maps at the same time, which makes all of them drawn on screen
- Add a data analysis based on treasure map QL where a loot table/enemy table will be shown with % chance of drops

### Map related additions 
- Incorporate own external map window (If possible) Maybe by using the Sklotopolis live map from browser
- Remove the need for the external map mod entirely (if possible)
- Add zoom option to the map
- Recalculate tile sizes based on zoom levels

# Changelog (based on commits)

## v2.0.4-Alpha1
### Features
- Added a prompt when closing to make sure that's what you wanted

### Bugfixes
- Updated the methods for closing the program which fixed an issue where the slices would still be drawn on screen. Now they should always be removed

## v2.0.3-Alpha1
### Features
- Made sure when a new color is set, the drawing would be redrawn with the new color

### Bugfixes
- Fixed an issue where the selection of different size maps (1k, 2k, 4k, ...) would not resize the cone accordingly
- Fixed an issue where the GUI would not be part of the external map, and as such would stay on top of the game when alt+tab back to game

### Other updates
- Refactored the code so the Gui eventhandlers have their own respective section

## v2.0.2-Alpha1
### Bugfixes
- Fixed a bug where the default properties weren't being set properly
- Fixed a bug where the default settings drew a too large pie slice on the first draw

## v2.0.1-Alpha1
### Features
- Added the color picker implementation
- optimized the default settings

### Bugfixes
- Fixed an issue where the default settings would result in everything being drawn out of proportions
- Fixed an issue where the colors would result in errors

## v2.0.0-Alpha1
### Features
- Removed the hotkey functions
- Added a GUI that handles all the old hotkey functions
- Added tabs to the GUI
    - how to
    - info
    - draw
    - settings
- Added more settings, which allows for the selection of ingame map size, screen size, and colors

### Bugfixes
- Fixed an issue where the drawing was only half the size it was supposed to be

v1.0.0-Alpha1
### Initial release
- Added a GUI that enables the choice of direction and distance 
- Added the buttons for 'draw', 'clear', and 'exit'