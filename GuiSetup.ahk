/* 
    Create the GUI with all information and tabs here. 
    This method is being called before anything else, but after the props has been setup
*/
CreateGui() {
    ; Create the GUI
    global requestGui := Gui("+AlwaysOnTop MaxSize1000x1000", "InputRequest")

    ; ########## Gui Controls ##########
    ; Add a text box at the top explaining the basics
    requestGui.Add("Text", "h25 w400 r2", "Select the various options here. The buttons are meant to save the settings, draw the pie, and clear the pie.")

    ; Add dropdown boxes for distance
    requestGui.Add("Text", "h25 YP+50 Right Section", "Select your distance: ")
    requestGui
            .Add("DropDownList", 
                "Choose1 YS vDistanceBox",
                ["Very far", "Far", "Pretty far", "Rather a long distance", "Quite some distance", "Some distance"])

    ; Add dropdown boxes for the direction
    requestGui.Add("Text", "h25 XS Right Section", "Select your direction: ")
    requestGui
            .Add("DropDownList", 
                "Choose1 YS vDirectionBox",
                ["North", "North-East", "East", "South-East", "South", "South-West", "West", "North-West"])

    ; Add a dropdown box for the map size
    requestGui.Add("Text", "h25 XS Right Section", "Select your map size")
    requestGui
            .Add("DropDownList", 
                "Choose3 YS vSizeBox",
                ["1K", "2K", "4K", "8K", "16K", "32K"])
    ; ########## ########## ########## ##########

    ; ########## BUTTONS ##########
    ; Add a button to start drawing
    requestGui.Add("Button", "w100 h25 vDraw XS Section Center", "Draw")
    ; Add a button to clear any remaining drawing
    requestGui.Add("Button", "w100 h25 vClear YS", "Clear")
    ; Add a button to exit the program manually
    requestGui.Add("Button", "w100 h25 vExit YS", "Exit")
    ; ########## ########## ########## ##########

    ; ########## EventHandlers ##########
    ; On change of this box, set the tile size anew
    requestGui["SizeBox"].OnEvent("Change", ChangeTileSize)
    ; Add an event handler for the drawing button
    requestGui["Draw"].OnEvent("Click", Draw)
    ; Add an event handler for the clear button
    requestGui["Clear"].OnEvent("Click", Clear)
    ; Add an event handler for the exit button
    requestGui["Exit"].OnEvent("Click", myP.Drawn ? ExitProgram : ExitWithoutGraphics)
    ; ########## ########## ########## ##########

    ; Actually show the GUI
    requestGui.Show()
    ; END: Gui Setup for initial props
}