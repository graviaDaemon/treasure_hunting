#Include <GdipHelper>

class GuiEvents {
    __New(mp, pp) {
        this.MapProps := mp
        this.PieProps := pp
    }

    DrawEvent(btn, btnparams) {
        ; global HuntDisplay := Hunt(this.MapProps, this.PieProps)

        ; HuntDisplay.Draw()
    }

    ClearEvent(btn, btnparams) {
        if this.MapProps.Drawn 
            huntDisplay.Clear(guiWindow)
        else
            MsgBox "Nothing was drawn yet, so noting is cleared", "Warning"
        return
    }

    CloseEvent(btn, btnparams := unset) {
        if MsgBox("Are you sure you want to close the treasure hunt?", "Are you leaving?", "YesNo") != "No" {
            if this.MapProps.Drawn
                Exitprogram("Close", 20)
            else 
                ExitWithoutGraphics("Close", 21)
        } else {
            return true
        }
    }

    EditMapNameEvent(ef, efparams) {
        ; MsgBox ef.ClassNN    
    }

    SetDistanceEvent(db, dbparams) {
        sizes := [
            [this.MapProps.mapSize, 2000],
            [1999, 1000],
            [999, 500],
            [499, 200],
            [199, 50],
            [49, 20]
        ]
        
        if (db.Value - 1 > 0 && db.Value - 1 <= sizes.Length) {
            size := sizes[db.Value]
            this.MapProps.SetDistance(size[1], size[2])
        } else {
            this.MapProps.SetDistance(4096, 2000)
        }
        return
    }

    SetDirectionEvent(db, dbparams) {
        directions := [0, 45, 90, 135, 180, 225, 270, 315]

        if db.Value - 1 > 0 && db.Value - 1 <= directions.Length {
            this.MapProps.SetDirection(db.Value)
        } else {
            this.MapProps.SetDirection(0)
        }
        return
    }

    ChangeTileSizeEvent(db, dbparams) {
        sizes := [1024, 2048, 4096, 8192, 16384, 32768]

        if (db.Value <= sizes.Length) {
            size := sizes[db.Value]
            this.MapProps.SetTileSize(size)
        }
    }

    ChangeScreenSizeEvent(tb, tbparams) {
        if (!IsNumber(tb.Value))
            MsgBox "Please input a number"

        this.MapProps.SetScreenSize(tb.Value)
        return
    }

    ChangeLargePieColorEvent(eb, ebparams) {
        if StrLen(eb.Value) = 6
            this.PieProps.SetLargePieColor(eb.Value)
        return
    }

    ChangeSmallPieColorEvent(eb, ebparams) {
        if StrLen(eb.Value) = 6
            this.PieProps.SetSmallPieColor(eb.Value)
        return
    }

    __SetNewText(title, value, fontValue?, font := false) {
        this.Graphics[title].Text := value
        if (font) {
            this.Graphics[title].SetFont(fontValue)
        }
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
}