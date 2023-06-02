class HuntGui {
    __New(mp, pp) {
        this.MapProps := mp
        this.PieProps := pp
        this.EventObject := unset
    }

    Create(eventObj) {
        this.EventObject := eventObj
        ; Create the basic GUI
        global requestGui := Gui("+MinSize600x600 -Resize -MaximizeBox", "Gravia Daemon's Treasure Hunters", this.EventObject)
        ; Add tabs to the GUI
        requestGui.Add("Tab3", "Center +VScroll vTabs", ["Readme", "Info", "Drawing", "Settings"])

        ; Create elements within each tab
        ; The readme tab
        this.__ReadMeTab()
        ; The information tab
        this.__InfoTab() 
        ; The drawing tab
        this.__DrawingTab()
        ; the settings tab
        this.__SettingsTab()
        ; The event handlers
        this.__EventHandlers()
        ; The buttons at the bottom of the screen
        this.__Buttons()


        ; Show the GUI after everything has been created
        requestGui.Show()
        return
    }

    __ReadMeTab() {
        ; Use the readme tab
        requestGui["Tabs"].UseTab("Readme")
                
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
    }

    __InfoTab() {
        ; Use the info tab
        requestGui["Tabs"].UseTab("Info")

        ; Info tab - general information
        requestGui.Add("Text", "h30 w600 vGeneralInfo Section", "General Information")
        requestGui["GeneralInfo"].SetFont("bold s16")

        ; External Map Screen Size Information
        requestGui.Add("Text", "vExternalMapScreenSize XS Section w150", "External Map Size:")
        requestGui["ExternalMapScreenSize"].SetFont("underline")
        requestGui.Add("Text", "vExternalMapScreenSize_value YS w200", this.MapProps.screenSize " x" this.MapProps.screenSize)
        requestGui["ExternalMapScreenSize_value"].Opt("+Redraw")

        requestGui.Add("Text", "vIngameMapSizeInfo XS Section w150", "Ingame Map Size:")
        requestGui["IngameMapSizeInfo"].SetFont("underline")
        requestGui.Add("Text", "vIngameMapSizeInfo_value YS w200", this.MapProps.mapSize " x" this.MapProps.mapSize)
        requestGui["IngameMapSizeInfo_value"].Opt("+Redraw")

        requestGui.Add("Text", "vPlayerPosition XS Section w150", "Player X & Y Position:")
        requestGui["PlayerPosition"].SetFont("underline")
        requestGui.Add("Text", "vPlayerPosition_value YS w200", "X: " this.MapProps.xPosition ", Y: " this.MapProps.yPosition)
        requestGui["PlayerPosition_value"].Opt("+Redraw")

        ; Info tab - slice information information
        requestGui.Add("Text", "h30 w600 vMapInfo XS Section", "Maps Information")
        requestGui["MapInfo"].SetFont("bold s16")

        for item in this.PieProps {
            if A_Index = 1
                this.__AddMapInfo(item, true)
            else
                this.__AddMapInfo(item)
        }
    }

    __AddMapInfo(tMap, first := false) {
        Id := StrReplace(tMap.MapName, A_Space, "", false)
        infoGroup := first 
            ? "v" Id "_info Section w450 h110"
            : "v" Id "_info XS Section w450 h110"

        requestGui.Add("GroupBox", infoGroup, tMap.MapName)
        distance := tMap.sizeSmallPie = 2000
            ? tMap.sizeSmallPie "+ Tiles away"
            : tMap.sizeLargePie " - " tMap.sizeSmallPie " Tiles away"

        requestGui.Add("Text", "v" Id "_DistanceInfo XP+5 YP+20 w150", "Distance from you:")
        requestGui[Id "_DistanceInfo"].SetFont("underline")
        requestGui.Add("Text", "v" Id "_DistanceInfo_value XP+120 w200", distance)
        
        requestGui.Add("Text", "v" Id "_DirectionInfo XS+5 YP+20 w150", "Direction:")
        requestGui[Id "_DirectionInfo"].SetFont("underline")
        requestGui.Add("Text", "v" Id "_DirectionInfo_value XP+120 w200", this.__ParseDirection(tMap.pieRadius))
        requestGui[Id "_DirectionInfo_value"].Opt("+Redraw")

        requestGui.Add("Text", "vColoration" Id "_large XS+5 YP+20 w150", "Large pie color: ")
        requestGui["Coloration" Id "_large"].SetFont("underline")
        requestGui.Add("Text", "vColoration" Id "_large_value XP+120 w200", "#" tMap.largePieColorString)
        requestGui["Coloration" Id "_large_value"].Opt("+Redraw")
        requestGui["Coloration" Id "_large_value"].SetFont(tMap.largePieColorString = "FFFFFF" or "ffffff" ? "c000000" : "c" tMap.largePieColorString)

        requestGui.Add("Text", "vColoration" Id "_small XS+5 YP+20 w150", "Small pie color: ")
        requestGui["Coloration" Id "_small"].SetFont("underline")
        requestGui.Add("Text", "vColoration" Id "_small_value XP+120 w200", "#" tMap.smallPieColorString)
        requestGui["Coloration" Id "_small_value"].Opt("+Redraw")
        requestGui["Coloration" Id "_small_value"].SetFont(tMap.smallPieColorString = "FFFFFF" or "ffffff" ? "c000000" : "c" tMap.smallPieColorString)
    }

    __DrawingTab() {
        ; Use the drawing tab
        requestGui["Tabs"].UseTab("Drawing", true)

        for mItem in this.PieProps {
            if A_Index = 1
                this.__AddNewMap(mItem.MapName, true)
            else
                this.__AddNewMap(mItem.MapName)
        }

        ; Beneath all maps, we create an "Add" button to add more maps to the list
        ; Though currently it's hard to get a redraw working at all
        ; requestGui.Add("Button", "XS+" A_ScreenWidth / 9 " vAddMap", "Add")
    }

    /* 
        Creates a new GroupBox with 2 dropdowns in it, one for distance and one for direction
        also adds a button to draw that specific map's slices and to clear all those slices
    */
    __AddNewMap(input, first := false) {
        Id := StrReplace(input, A_Space, "", false)
        groupOptions := first 
            ? "v" Id " Section w450 h130"
            : "v" Id " XS Section w450 h130"

        requestGui.Add("GroupBox", groupOptions, input)
        requestGui.Add("Text", "h25 w150 XP+5 YP+20 v" Id "_distance", "Select your distance: ")
        requestGui
                .Add("DropDownList", 
                    "Choose1 w200 XP+150 v" Id "_distance_value",
                    ["---choose---", "Very far", "Far", "Pretty far", "Rather a long distance", "Quite some distance", "Some distance"])

        requestGui.Add("Text", "h25 w150 XS+5 YP+45 v" Id "_direction", "Select your direction: ")
        requestGui
                .Add("DropDownList", 
                    "Choose1 w200 XP+150 v" Id "_direction_value",
                    ["---choose---", "North", "North-East", "East", "South-East", "South", "South-West", "West", "North-West"])

        ; Buttons inside the box, meant for interaction with the map
        requestGui.Add("Button", "w75 h25 YP+30 XP-1 vDraw_" Id " Center", "Draw")
        requestGui.Add("Button", "w75 h25 XP+80 vClear_" Id " Center", "Clear")

        ; Button to the right of the map, for editing the name, or deleting
        requestGui.Add("Edit", "w150 h25 XP+230 YP-50 vEdit" Id "_value")
        requestGui.Add("Button", "w72 h25 XP+155 vEdit" Id ,"Edit")
        
        requestGui.Add("Button", "w72 h25 XP-155 YP+30 vDelete" Id, "Delete")
    }

    __SettingsTab() {
        requestGui["Tabs"].UseTab(4)

        requestGui.Add("Text", "h25 w150 Section vIngameMapSizeSetting", "Select your ingame map size")
        requestGui
                .Add("DropDownList", 
                    "Choose3 YS vIngameMapSizeSetting_value w200",
                    ["1K", "2K", "4K", "8K", "16K", "32K"])

        requestGui.Add("Text", "h25 w150 XS Section vScreenSize", "Set Screen Size: ")
        requestGui.Add("Edit", "vScreenSizeSetting_Text_value h25 w200 YS")
        requestGui.Add("UpDown", "vScreenSizeSetting_Num_value Range0-32768", 1000)

        for item in this.PieProps {
            if A_Index = 1 
                this.__AddMapSettings(item.MapName, true)
            else
                this.__AddMapSettings(item.MapName)
        }
    }

    __AddMapSettings(input, first := false) {
        Id := StrReplace(input, A_Space, "", false)

        requestGui.Add("GroupBox", "v" Id "_settings XS Section w450 h100", input)

        requestGui.Add("Text", "h25 w150 XP+5 YP+20 vColorPicker" Id "_Large", "Pick a color (Large pie): ")
        requestGui.Add("Edit", "vColorPicker" Id "_Large_value h25 w200 XP+150", "000000")

        requestGui.Add("Text", "h25 w150 XS+5 YP+45 vColorPicker" Id "_Small", "Pick a color (Small pie): ")
        requestGui.Add("Edit", "vColorPicker" Id "_Small_value h25 w200 XP+150", "ffffff")
    }

    __EventHandlers() {
        requestGui.OnEvent("Close", "CloseEvent") ; Closing up event
    }

    __Buttons() {
        ; Unused at the moment
    }

    __ParseDirection(direction) {
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
}