#Include <HuntGui>
#Include <Hunt>

class Handler {
    __New(mp, pp := [PieProperties("Map 1"), PieProperties("Map 2")]) {
        this.MapProps := mp
        this.PieProps := pp ; pp has to be an array of pie slices
        this.HuntGraphic := HuntGui(mp, pp)
    }

    OpenGui(eventObj) {
        this.HuntGraphic.Create(eventObj)
    }
    
    ; ########## START: Methods ##########
    ; Upon clicking the "Draw" button, this method will be called
    ; It checks if any previous drawing has been made, and destroys that
    ; Then it sets the size and direction of the slices
    ; Then it will intialize the class which will draw a whole new item
    ; And calls the "Draw" method. Passing in the previous gui
    DrawEvent(b, bparam) {
        if this.myP.Drawn
            huntDisplay.Clear(guiWindow)

        global huntDisplay := Hunt(this.myP)
        
        huntDisplay.Draw()
    }

    ; Upon clicking the "Clear" button, this method will be called
    ; It checks if any previous drawig has been made, and destroys that
    ; Otherwise it will return a message saying there was no drawing made
    ClearEvent(b, bparam) {
        if this.myP.Drawn
            huntDisplay.Clear(guiWindow)
        else
            MsgBox "Nothing was drawn yet, so nothing is cleared", "Warning"
        return
    }

    CloseEvent(btn, btnparams := unset) {
        if MsgBox("Are you sure you want to close the treasure hunt?","Are you leaving?", "YesNo") != "No" {
            if mapProps.Drawn 
                ExitProgram("Close",20)
            else 
                ExitWithoutGraphics("Close",21)
        } else {
            return true
        }
    }

    ; Sets the size based on the dropdown value, which in the Props class sets the right sizes
    SetDistanceEvent(db, dbparams) {
        sizes := [
            [this.myP.mapSize, 2000],
            [1999, 1000],
            [999, 500],
            [499, 200],
            [199, 50],
            [49, 20]
        ]

        if (db.Value <= sizes.Length) {
            size := sizes[db.Value]
            this.myP.SetDistance(size[1], size[2])
        } else {
            this.myP.SetDistance(4096, 2000)
        }
        return
    }

    ; Sets the direction based on the dropdown value, which in the Props class sets the right rotation
    SetDirectionEvent(db, dbparam) {
        directions := [0, 45, 90, 135, 180, 225, 270, 315]

        if (db.Value <= directions.Length) {
            direction := directions[db.Value]
            this.myP.SetDirection(direction)
        } else {
            this.myP.SetDirection(0)
        }
        return
    }

    ; Based on the map size dropdown value, this sets the map size, and thus the tile size in the props class
    ChangeTileSizeEvent(db, dbparams) {
        sizes := [1024, 2048, 4096, 8192, 16384, 32768]

        if (db.Value <= sizes.Length) {
            size := sizes[db.Value]
            this.myP.SetTileSize(size)
            this.__FireEventHandler(
                [requestGui["DrawSection_1_value"], "Dropdown"], ; Event 1 to be fired
                [requestGui["DrawSection_2_value"], "Dropdown"] ; Event 2 to be fired
            )
        } else {
            this.myP.SetTileSize(4096)
            this.__FireEventHandler(
                [requestGui["DrawSection_1_value"], "Dropdown"], ; Event 1 to be fired
                [requestGui["DrawSection_2_value"], "Dropdown"] ; Event 2 to be fired
            )
        }
        return
    }

    ; Sets the screen size based on the input fields in the settings tab
    ChangeScreenSizeEvent(tb, tbparams) {
        if (!IsNumber(tb.Value))
            MsgBox "Please input a number"
        
        ; Actually set the new screen size
        this.myP.SetScreenSize(tb.Value)
        
        ; Just to be sure, I fire the drawing settings events here as well
        this.__FireEventHandler(
            [requestGui["DrawSection_1_value"], "Dropdown"], ; Event 1 to be fired
            [requestGui["DrawSection_2_value"], "Dropdown"], ; Event 2 to be fired
            [requestGui["IngameMapSize_value"], "Dropdown"] ; Event 3 to be fired
        )
        return
    }

    ; Sets the new color for the large pie based on the input field in the settings tab
    ChangeLargePieColor(eb, ebparams) {
        if StrLen(eb.Value) = 6 {
            this.myP.SetLargePieColor(eb.Value)
            this.__FireEventHandler([requestGui["Draw"], "Click"])
        }
        return
    }

    ; Sets the new color for the small pie based on the input field in the settings tab
    ChangeSmallPieColor(eb, ebparams) {
        if StrLen(eb.Value) = 6 {
            this.myP.SetSmallPieColor(eb.Value)
            this.__FireEventHandler([requestGui["Draw"], "Click"])
        }
        return
    }

    __FireEventHandler(events*) {
        for event in events {
            if event.Length != 2 {
                MsgBox "Not the right amount of items in parameter.`nShould be '[control, eventString]'", "Error"
                break
            }

            switch(event[2]) {
                case "Dropdown":
                    this.__FireDropdownHandler(event[1])
                    break
                case "Edit":
                    this.__FireEditHandler(event[1])
                    break
                case "Click":
                    this.__FireClickHandler(event[1])
                    break
                default:
                    MsgBox "Not the right event selected.`nOptions are: 'Dropdown', 'Edit', or 'Click'", "error"
            }
        }
        return
    }

    __FireDropdownHandler(control) {
        ControlChooseIndex control.Value, control
        return
    }

    __FireClickHandler(control) {
        ControlClick control
        return
    }

    __FireEditHandler(control) {
        ControlSetText control.Value, control
        return
    }
    ; ########## END: Methods ##########
}