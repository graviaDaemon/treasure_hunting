#Include <GraphicUserInterface\BaseGui>
#Include <GraphicUserInterface\Components\TextComponent>
#Include <GraphicUserInterface\Components\DropdownComponent>
#Include <GraphicUserInterface\Components\EventComponent>
#Include <GraphicUserInterface\GuiEvents>

class HuntGui {
    __New(mp, pp) {
        eventObj := GuiEvents(mp, pp)
        this.MapProps := mp
        this.PieProps := pp
        this.RGUI := BaseGui("+MinSize600x600 -Resize -MaximizeBox", "Gravia Daemon's Treasure Hunters", eventObj)
    }

    Create() {
        ; Add tabs to the GUI
        this.RGUI.AddTabControl("Center vTabs", ["Readme", "Info", "Drawing", "Settings"])

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

        ; Show the GUI after everything has been created
        this.RGUI.GraphicInterface.Show()
        return
    }

    __ReadMeTab() {
        ; Use the readme tab
        this.RGUI.UseTabcontrol("Tabs", "Readme")
                
        this.RGUI.AddTextControls([
            TextComponent("ReadmeTitle", "Section h30 w600", "How to use this program", "bold s18"),
            TextComponent("InformationTabExplanation", "XS h30 w600", "Info Tab", "bold s12"),
            TextComponent("InformationTabExplanation_body", "XS", "
            (
                Here you can find all settings set to what you have set them. Distance, Direction, map size, colours, and more`n`n
            )"),
            TextComponent("DrawingTabExplanation", "XS h30 w600", "Drawing Tab", "bold s12"),
            TextComponent("DrawingTabExplanation_value", "XS", "
            (
                In the drawing tab you'll find two options, direction and distance.
                You read the map in game facing a direction of your choosing, and wait for the message for the location to pop up.
                For example when you face north you get: 'The marked spot is very far away ahead of you to the right'.
                This means you select distance 'Far Away' and direction should be set to 'North-East'.
                Now you can click the Draw button, and the program will do the rest!`n`n
            )"),
            TextComponent("SettingsTabExplanation", "XS h30 w600", "Settings Tab", "bold s12"),
            TextComponent("SettingsTabExplanation_value", "XS", "
            (
                In here you will find all kinds of useful settings, like the ingame map size of 1 through 32k maps,
                the size of the external map you're using (noted by the ingame command 'toggleexternalmap 1111' where the '1111' part is the value you put in the setting here,
                the colours for the smaller and larger pie slices;
                To pick a colour please get a hex from google's color picker (for example '#000000') and paste everything in the box
                leave the '#' and just take the numbers/letters in there.`n`n
            )")
        ])
    }

    __InfoTab() {
        ; Use the info tab
        this.RGUI.UseTabControl("Tabs", "Info")

        this.RGUI.AddTextControls([
            TextComponent("GeneralInfo", "h30 w600 Section", "General Information", "bold s16"),
            TextComponent("ExternalMapScreenSize", "XS Section w150", "External Map Size:", "underline"),
            TextComponent("ExternalMapScreenSize_value", "YS w200", this.MapProps.screenSize " x" this.MapProps.screenSize),
            TextComponent("IngameMapSizeInfo", "XS Section w150", "Ingame Map Size:", "underline"),
            TextComponent("IngameMapSizeInfo_value", "YS w200", this.MapProps.mapSize " x" this.MapProps.mapSize),
            TextComponent("PlayerPosition", "XS Section w150", "Player X & Y Position:", "underline"),
            TextComponent("PlayerPosition_value", "YS w200", "X: " this.MapProps.xPosition ", Y: " this.MapProps.yPosition),
            TextComponent("MapInfo", "XS Section h30 w600", "Maps Information", "bold s16")
        ])

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

        distance := tMap.sizeSmallPie = 2000
            ? tMap.sizeSmallPie "+ Tiles away"
            : tMap.sizeLargePie " - " tMap.sizeSmallPie " Tiles away"

        this.RGUI.AddGroupControl(infoGroup, tMap.MapName)

        this.RGUI.AddTextControls([
            TextComponent(Id "_DistanceInfo", "XP+5 YP+20 w150", "Distance from you:", "underline"),
            TextComponent(Id "_DistanceInfo_value", "XP+120 w200", distance),
            TextComponent(Id "_DirectionInfo", "XS+5 YP+20 w150", "Direction:", "underline"),
            TextComponent(Id "_DirectionInfo_value", "XP+120 w200", this.__ParseDirection(tMap.pieRadius)),
            TextComponent(Id "_Coloration_Large", "XS+5 YP+20 w150", "Large pie color: ", "underline"),
            TextComponent(Id "_Coloration_Large_value", "XP+120 w200", "#" tMap.largePieColorString, tMap.largePieColorString = "FFFFFF" or "ffffff" ? "c000000" : "c" tMap.largePieColorString),
            TextComponent(Id "_Coloration_Small", "XS+5 YP+20 w150", "Small pie color: ", "underline"),
            TextComponent(Id "_Coloration_Small_value", "XP+120 w200", "#" tMap.smallPieColorString, tMap.smallPieColorString = "FFFFFF" or "ffffff" ? "c000000" : "c" tMap.smallPieColorString),
        ])
    }

    __DrawingTab() {
        ; Use the drawing tab
        this.RGUI.UseTabControl("Tabs", "Drawing")

        for mItem in this.PieProps {
            if A_Index = 1
                this.__AddNewMap(mItem.MapName, true)
            else
                this.__AddNewMap(mItem.MapName)
        }
    }
    
    __AddNewMap(input, first := false) {
        Id := StrReplace(input, A_Space, "", false)
        groupOptions := first 
            ? "v" Id " Section w450 h130"
            : "v" Id " XS Section w450 h130"

        this.RGUI.AddGroupControl(groupOptions, input)

        this.RGUI.AddDropdownComponents([
            DropdownComponent(
                Id "_Distance_value", 
                "Choose1 XP+150 w200", 
                TextComponent(Id "_Distance", "XP+5 YP+20 h25 w150", "Select your distance: "), 
                ["---choose---", "Very far", "Far", "Pretty far", "Rather a long distance", "Quite some distance", "Some distance"]),
            DropdownComponent(
                Id "_Direction_value", 
                "Choose1 XP+150 w200", 
                TextComponent(Id "_Direction", "XS+5 YP+45 h25 w150", "Select your direction: "), 
                ["---choose---", "North", "North-East", "East", "South-East", "South", "South-West", "West", "North-West"]),
        ])

        this.RGUI.AddButtonControl("v" Id "_Draw YP+30 XP-1 Center w75 h25", "Draw")
        this.RGUI.AddButtonControl("v" Id "_Clear XP+80 Center w75 h25", "Clear")
        this.RGUI.AddEditControl("v" Id "_Edit_value XP+230 YP-50 w150 h25", input)
        this.RGUI.AddButtonControl("v" Id "_Edit XP+155 w72 h25", "Edit")
        this.RGUI.AddButtonControl("v" Id "_Delete XP-155 YP+30 w72 h25", "Delete")
    }

    __SettingsTab() {
        this.RGUI.UseTabControl("Tabs", "Settings")

        this.RGUI.AddDropdownComponents([
            DropdownComponent(
                "IngameMapSizeSetting_value", 
                "Choose3 YS w200", 
                TextComponent("IngameMapSizeSetting", "Section h25 w150", "Select your ingame map size: "), 
                ["1K", "2K", "4K", "8K", "16K", "32K"])
        ])

        this.RGUI.AddTextControl("vScreenSize XS Section h25 w150", "Set Screen Size: ")
        this.RGUI.AddEditControl("vScreenSizeSetting_Text_value h25 w200 YS")
        this.RGUI.AddUpDownControl("vScreenSizeSetting_Num_value Range0-32768", 1000)

        for item in this.PieProps {
            if A_Index = 1 
                this.__AddMapSettings(item.MapName, true)
            else
                this.__AddMapSettings(item.MapName)
        }
    }

    __AddMapSettings(input, first := false) {
        Id := StrReplace(input, A_Space, "", false)

        this.RGUI.AddGroupControl("v" Id "_settings XS Section w450 h100", input)

        this.RGUI.AddTextControl("v" Id "_ColorPicker_Large XP+5 YP+20 h25 w150", "Pick a color (Large pie): ")
        this.RGUI.AddEditControl("v" Id "_ColorPicker_Large_value XP+150 h25 w200", "000000")

        this.RGUI.AddTextControl("v" Id "_ColorPicker_Small XS+5 YP+45 h25 w150", "Pick a color (Small pie): ")
        this.RGUI.AddEditControl("v" Id "_ColorPicker_Small_value XP+150 h25 w200", "ffffff")
    }

    __EventHandlers() {
        
        events := [
            EventComponent("Change", "ChangeScreenSizeEvent", this.RGUI.GetControl("ScreenSizeSetting_Text_value")),
            EventComponent("Change", "ChangeScreenSizeEvent", this.RGUI.GetControl("ScreenSizeSetting_Num_value")),
            EventComponent("Change", "ChangeTileSizeEvent", this.RGUI.GetControl("IngameMapSizeSetting_value")),
            EventComponent("Close", "CloseEvent")
        ]
        
        if (this.PieProps.Length > 0){
            for item in this.PieProps {
                Id := StrReplace(item.MapName, A_Space, "", false)
                events.Push(
                    EventComponent("Change", "SetDistanceEvent", this.RGUI.GetControl(Id "_Distance_value")),
                    EventComponent("Change", "SetDirectionEvent", this.RGUI.GetControl(Id "_Direction_value")),
                    EventComponent("Click", "DrawEvent", this.RGUI.GetControl(Id "_Draw")),
                    EventComponent("Click", "ClearEvent", this.RGUI.GetControl(Id "_Clear")),
                    EventComponent("Click", "EditMapNameEvent", this.RGUI.GetControl(Id "_Edit")),
                    EventComponent("Change", "ChangeLargePieColorEvent", this.RGUI.GetControl(Id "_ColorPicker_Large_value")),
                    EventComponent("Change", "ChangeSmallPieColorEvent", this.RGUI.GetControl(Id "_ColorPicker_Small_value"))
                )
            }   
        }

        this.RGUI.AddEventHandlers(events)
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