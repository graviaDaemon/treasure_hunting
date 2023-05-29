/* 
    Create the GUI with all information and tabs here. 
    This method is being called before anything else, but after the props has been setup
*/
CreateGui(props) {
    ; Create the GUI
    global requestGui := Gui("MaxSize1000x1000 +Resize", "InputRequest")

    ;#region GUI Controls
    ; Prepare the tab names, and their respective tab sections
    requestGui.Add("Tab3", "Center vTabs", ["Readme", "Info", "Drawing", "Settings"])

        ;#region Tab_Readme

        ; Use the readme tab
        requestGui["Tabs"].UseTab(1)
        
        ; The title of this tab
        requestGui.Add("Text", "h30 w600 vReadmeTitle Section", "How to use this program")
        requestGui["ReadmeTitle"].SetFont("bold s18")
        
        ; The header for the info tab explanation
        requestGui.Add("Text", "h30 w600 vReadMeHeader1 XS ", "Info Tab")
        requestGui["ReadmeHeader1"].SetFont("bold s12")
        requestGui.Add("Text", "vReadMeHeader1Body XS", "
        (
            Here you can find all settings set to what you have set them. Distance, Direction, map size, colours, and more`n`n
        )")

        ; The header for the drawing tab explanatin
        requestGui.Add("Text", "h30 w600 vReadMeHeader2 XS", "Drawing Tab")
        requestGui["ReadmeHeader2"].SetFont("bold s12")
        requestGui.Add("Text", "vReadMeHeader2Body XS", "
        (
            In the drawing tab you'll find two options, direction and distance.
            You read the map in game facing a direction of your choosing, and wait for the message for the location to pop up.
            For example when you face north you get: 'The marked spot is very far away ahead of you to the right'.
            This means you select distance 'Far Away' and direction should be set to 'North-East'.
            Now you can click the Draw button, and the program will do the rest!`n`n
        )")

        ; The header for the settings tab explanatin
        requestGui.Add("Text", "h30 w600 vReadMeHeader3 XS", "Settings Tab")
        requestGui["ReadmeHeader3"].SetFont("bold s12")
        requestGui.Add("Text", "vReadMeHeader3Body XS", "
        (
            In here you will find all kinds of useful settings, like the ingame map size of 1 through 32k maps,
            the size of the external map you're using (noted by the ingame command 'toggleexternalmap 1111' where the '1111' part is the value you put in the setting here,
            the colours for the smaller and larger pie slices;
            To pick a colour please get a hex from google's color picker (for example '#000000') and paste everything in the box
            leave the '#' and just take the numbers/letters in there.`n`n
        )")
        ;#endregion

        ;#region Tab_Info
        
        ; Use the info tab
        requestGui["Tabs"].UseTab(2)

        ; Info tab basic title
        requestGui.Add("Text", "h30 w600 vInfoSection Section", "Basic Information")
        requestGui["InfoSection"].SetFont("bold s18")

        ; Info tab info_1
        requestGui.Add("Text", "vInfoSection_1 XS Section w150", "External Map Size:")
        requestGui["InfoSection_1"].SetFont("underline")
        requestGui.Add("Text", "vInfoSection_1_value YS w200", props.screenSize " x" props.screenSize)
        requestGui["InfoSection_1_value"].Opt("+Redraw")

        requestGui.Add("Text", "vInfoSection_2 XS Section w150", "Ingame Map Size:")
        requestGui["InfoSection_2"].SetFont("underline")
        requestGui.Add("Text", "vInfoSection_2_value YS w200", props.mapSize " x" props.mapSize)
        requestGui["InfoSection_2_value"].Opt("+Redraw")

        requestGui.Add("Text", "vInfoSection_3 XS Section w150", "Large Slice:")
        requestGui["InfoSection_3"].SetFont("underline")
        requestGui.Add("Text", "vInfoSection_3_value YS w200", props.sizeLargePie " Tiles")
        requestGui["InfoSection_3_value"].Opt("+Redraw")

        requestGui.Add("Text", "vInfoSection_4 XS Section w150", "Small Slice:")
        requestGui["InfoSection_4"].SetFont("underline")
        requestGui.Add("Text", "vInfoSection_4_value YS w200", props.sizeSmallPie " Tiles")
        requestGui["InfoSection_4_value"].Opt("+Redraw")
        
        requestGui.Add("Text", "vInfoSection_5 XS Section w150", "Direction:")
        requestGui["InfoSection_5"].SetFont("underline")
        requestGui.Add("Text", "vInfoSection_5_value YS w200", FigureDirection(props.pieRadius))
        requestGui["InfoSection_5_value"].Opt("+Redraw")

        requestGui.Add("Text", "vInfoSection_6 XS Section w150", "Player X Position:")
        requestGui["InfoSection_6"].SetFont("underline")
        requestGui.Add("Text", "vInfoSection_6_value YS w200", props.xPosition)
        requestGui["InfoSection_6_value"].Opt("+Redraw")

        requestGui.Add("Text", "vInfoSection_7 XS Section w150", "Player Y Position:")
        requestGui["InfoSection_7"].SetFont("underline")
        requestGui.Add("Text", "vInfoSection_7_value YS w200", props.yPosition)
        requestGui["InfoSection_7_value"].Opt("+Redraw")

        requestGui.Add("Text", "vInfoSection_8 XS Section w150", "Tile size: ")
        requestGui["InfoSection_8"].SetFont("underline")
        requestGui.Add("Text", "vInfoSection_8_value YS w200", props.tileSize " Pixels per tile")
        requestGui["InfoSection_8_value"].Opt("+Redraw")

        requestGui.Add("Text", "vInfoSection_9 XS Section w150", "Large pie color: ")
        requestGui["InfoSection_9"].SetFont("underline")
        requestGui.Add("Text", "vInfoSection_9_value YS w200", "#" props.largePieColorString)
        requestGui["InfoSection_9_value"].Opt("+Redraw")
        requestGui["InfoSection_9_value"].SetFont(props.largePieColorString = "FFFFFF" or "ffffff" ? "c000000" : "c" props.largePieColorString)

        requestGui.Add("Text", "vInfoSection_10 XS Section w150", "Small pie color: ")
        requestGui["InfoSection_10"].SetFont("underline")
        requestGui.Add("Text", "vInfoSection_10_value YS w200", "#" props.smallPieColorString)
        requestGui["InfoSection_10_value"].Opt("+Redraw")
        requestGui["InfoSection_10_value"].SetFont(props.smallPieColorString = "FFFFFF" or "ffffff" ? "c000000" : "c" props.smallPieColorString)

        ; Add text boxes to show the information of the various settings
        
        ;#endregion

        ;#region Tab_Drawing
        
        ; Use the drawing tab
        requestGui["Tabs"].UseTab(3)

        requestGui.Add("Text", "h30 w600 vDrawSection Section", "Selections to draw with")
        ; Add dropdown boxes for distance
        requestGui.Add("Text", "h25 w150 XS Section vDrawSection_1", "Select your distance: ")
        requestGui
                .Add("DropDownList", 
                    "Choose1 w200 YS vDrawSection_1_value",
                    ["Very far", "Far", "Pretty far", "Rather a long distance", "Quite some distance", "Some distance"])

        ; Add dropdown boxes for the direction
        requestGui.Add("Text", "h25 w150 XS Section vDrawSection_2", "Select your direction: ")
        requestGui
                .Add("DropDownList", 
                    "Choose1 YS w200 vDrawSection_2_value",
                    ["North", "North-East", "East", "South-East", "South", "South-West", "West", "North-West"])
        
        ;#endregion

        ;#region Tab_Settings
        requestGui["Tabs"].UseTab(4)
        ; Add a dropdown box for the map size
        requestGui.Add("Text", "h25 w150 Section vIngameMapSize", "Select your ingame map size")
        requestGui
                .Add("DropDownList", 
                    "Choose3 YS vIngameMapSize_value w200",
                    ["1K", "2K", "4K", "8K", "16K", "32K"])

        requestGui.Add("Text", "h25 w150 XS Section vScreenSize", "Set Screen Size: ")
        requestGui.Add("Edit", "vScreenSizeSetting_Text_value h25 w200 YS")
        requestGui.Add("UpDown", "vScreenSizeSetting_Num_value Range0-32768", 1000)

        requestGui.Add("Text", "h25 w150 XS Section vLargePieColor", "Pick a color (Large pie): ")
        requestGui.Add("Edit", "vEditLargeColorBox h25 w200 YS", "000000")
        requestGui.Add("Text", "h25 w150 YS", "NOT IMPLEMENTED YET")

        requestGui.Add("Text", "h25 w150 XS Section vSmallPieColor", "Pick a color (Small pie): ")
        requestGui.Add("Edit", "vEditSmallColorBox h25 w200 YS", "ffffff")
        requestGui.Add("Text", "h25 w150 YS", "NOT IMPLEMENTED YET")
        ; TODO: Add setting for map screen size
        
        ;#endregion

        ;#region Tab_None
        
        ; these buttons must remain visible all times

        requestGui["Tabs"].UseTab()

            ;#region Buttons
        
            ; Add a button to start drawing
            requestGui.Add("Button", "w100 h25 vDraw Section Center", "Draw")
            ; Add a button to clear any remaining drawing
            requestGui.Add("Button", "w100 h25 vClear YS", "Clear")
            ; Add a button to exit the program manually
            requestGui.Add("Button", "w100 h25 vExit YS", "Exit")
        
            ;#endregion

            ;#region EventHandlers
        
            ; On change of this box, set the tile size anew
            requestGui["IngameMapSize_value"].OnEvent("Change", ChangeTileSize)
            ; On change of the text box, set the window size anew
            requestGui["ScreenSizeSetting_Num_value"].OnEvent("Change", ChangeScreenSize)
            ; or
            requestGui["ScreenSizeSetting_Text_value"].OnEvent("Change", ChangeScreenSize)

            ; OnChange of color box update the used color for the large pie
            requestGui["EditLargeColorBox"].OnEvent("Change", ChangeLargePieColor)
            ; OnChange of color box update the used color for the small pie
            requestGui["EditSmallColorBox"].OnEvent("Change", ChangeSmallPieColor)

            ; When the dropbox changes dor distance, set new sizes
            requestGui["DrawSection_1_value"].OnEvent("Change", SetSize)
            ; When the dropbox changes for direction, set new direction
            requestGui["DrawSection_2_value"].OnEvent("Change", SetDirection)

            ; Add an event handler for the drawing button
            requestGui["Draw"].OnEvent("Click", Draw)
            ; Add an event handler for the clear button
            requestGui["Clear"].OnEvent("Click", Clear)
            ; Add an event handler for the exit button
            requestGui["Exit"].OnEvent("Click", props.Drawn ? ExitProgram : ExitWithoutGraphics)
        
            ;#endregion

        ;#endregion

    ;#endregion

    

    ; Actually show the GUI
    requestGui.Show()
    ; END: Gui Setup for initial props
}

FigureDirection(direction) {
    switch direction {
        case 0:
            return "North"
        case 45:
            return "North-East"
        case 90:
            return "East"
        case 135:
            return "South-East"
        case 180:
            return "South"
        case 225:
            return "South-West"
        case 270:
            return "West"
        case 315:
            return "North-West"
        default:
            return "North"
    }
}