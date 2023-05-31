#Include <GuiSetup>
#Include <Hunt>

class Requester {
    __New(myP) {
        this.myP := myP
    }

    static OpenGui(eventObj) {
        CreateGui(myP, eventObj)
    }
    
    ; ########## START: Methods ##########
    ; Upon clicking the "Draw" button, this method will be called
    ; It checks if any previous drawing has been made, and destroys that
    ; Then it sets the size and direction of the slices
    ; Then it will intialize the class which will draw a whole new item
    ; And calls the "Draw" method. Passing in the previous gui
    Draw(b, bparam) {
        if this.myP.Drawn
            huntDisplay.Clear(guiWindow)

        global huntDisplay := Hunt(this.myP)
        
        huntDisplay.Draw()
    }

    ; Upon clicking the "Clear" button, this method will be called
    ; It checks if any previous drawig has been made, and destroys that
    ; Otherwise it will return a message saying there was no drawing made
    Clear(b, bparam) {
        if this.myP.Drawn
            huntDisplay.Clear(guiWindow)
        else
            MsgBox "Nothing was drawn yet, so nothing is cleared", "Warning"
        return
    }

    ; Sets the size based on the dropdown value, which in the Props class sets the right sizes
    SetSize(db, dbparams) {
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
            this.myP.SetSize(size[1], size[2])
        } else {
            this.myP.SetSize(4096, 2000)
        }
        return
    }

    ; Sets the direction based on the dropdown value, which in the Props class sets the right rotation
    SetDirection(db, dbparam) {
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
    ChangeTileSize(db, dbparams) {
        sizes := [1024, 2048, 4096, 8192, 16384, 32768]

        if (db.Value <= sizes.Length) {
            size := sizes[db.Value]
            this.myP.SetTileSize(size)
            this.__FireEventHandlers(
                requestGui["DrawSection_1_value"], ; Event 1 to be fired
                requestGui["DrawSection_2_value"], ; Event 2 to be fired
            )
        } else {
            this.myP.SetTileSize(4096)
            this.__FireEventHandlers(
                requestGui["DrawSection_1_value"], ; Event 1 to be fired
                requestGui["DrawSection_2_value"], ; Event 2 to be fired
            )
        }
        return
    }

    ; Sets the screen size based on the input fields in the settings tab
    ChangeScreenSize(tb, tbparams) {
        if (IsNumber(tb.Value)) {
            this.myP.SetScreenSize(tb.Value)
            this.myP.SetTileSize(this.myP.mapSize)
            ; Just to be sure, I fire the drawing settings events here as well
            this.__FireEventHandlers(
                requestGui["DrawSection_1_value"], ; Event 1 to be fired
                requestGui["DrawSection_2_value"], ; Event 2 to be fired
            )
        } else{
            MsgBox "Please input a number"
        }
        return
    }

    ; Sets the new color for the large pie based on the input field in the settings tab
    ChangeLargePieColor(eb, ebparams) {
        if StrLen(eb.Value) = 6 {
            this.myP.SetLargePieColor(eb.Value)
            this.__FireBaseHandlers(requestGui["Draw"])
        }
        return
    }

    ; Sets the new color for the small pie based on the input field in the settings tab
    ChangeSmallPieColor(eb, ebparams) {
        if StrLen(eb.Value) = 6 {
            this.myP.SetSmallPieColor(eb.Value)
            this.__FireBaseHandlers(requestGui["Draw"])
        }
        return
    }

    __FireEventHandlers(controls*) {
        for control in controls {
            ControlChooseIndex control.Value, control
        }
        return
    }

    __FireBaseHandlers(controls*) {
        for control in controls {
            ControlClick control
        }
    }
    ; ########## END: Methods ##########
}