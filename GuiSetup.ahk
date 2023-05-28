CreateGui() {
    ; START: GUI Setup for initial props
    global requestGui := Gui("+AlwaysOnTop MaxSize1000x1000", "InputRequest") ; Setup a new GUI for the variables selection procedure

    requestGui.Add("Text", "h25 w400 r2", "Select the various options here. The buttons are meant to save the settings, draw the pie, and clear the pie.")

    ; Properties
    requestGui.Add("Text", "h25 YP+50 Right Section", "Select your distance: ")
    requestGui ; Setting the dropdown for the size of the pie
            .Add("DropDownList", 
                "Choose1 YS vDistanceBox",
                ["Very far", "Far", "Pretty far", "Rather a long distance", "Quite some distance", "Some distance"])

    requestGui.Add("Text", "h25 XS Right Section", "Select your direction: ")
    requestGui ; Setting the dropdown for the rotation of the pie
            .Add("DropDownList", 
                "Choose1 YS vDirectionBox",
                ["North", "North-East", "East", "South-East", "South", "South-West", "West", "North-West"])

    requestGui.Add("Text", "h25 XS Right Section", "Select your map size")
    requestGui ; Setting the dropdown for the rotation of the pie
            .Add("DropDownList", 
                "Choose3 YS vSizeBox",
                ["1K", "2K", "4K", "8K", "16K", "32K"])
    requestGui["SizeBox"].OnEvent("Change", ChangeTileSize)

    ; Add a button for submitting the data
    requestGui.Add("Button", "w100 h25 vDraw XS Section Center", "Draw")
    requestGui.Add("Button", "w100 h25 vClear YS", "Clear")
    requestGui.Add("Button", "w100 h25 vExit YS", "Exit")

    requestGui["Draw"].OnEvent("Click", Draw)
    requestGui["Clear"].OnEvent("Click", Clear)
    requestGui["Exit"].OnEvent("Click", myP.Drawn ? ExitProgram : ExitWithoutGraphics)


    ; Actually show the GUI
    requestGui.Show()
    ; END: Gui Setup for initial props
}