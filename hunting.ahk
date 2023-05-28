; Include the Hunt class as well as the Props class
#Include Hunt.ahk
#Include Props.ahk
#Include GuiSetup.ahk

; ########## START: Basic Setup ##########

; START: Basic Variables
myP := Props()
CreateGui()
; END: Basic Variables

; ########## END:   Basic Setup ##########

; ########## START: Methods ##########
Draw(b, bparam) {
    if myP.Drawn
        guiWindow.Destroy()

    SetSize(requestGui["DistanceBox"].Value)
    SetDirection(requestGui["DirectionBox"].Value)

    global huntDisplay := Hunt(myP)
    huntDisplay.Draw()
}

Clear(b, bparam) {
    huntDisplay.Clear()
    guiWindow.Destroy()
}

; Sets the size based on the dropdown value, which in the Props class sets the right sizes
; TODO: Clean this up if possible. It looks like a LOT
SetSize(value) {
    sizes := [
        [4096, 2000],
        [1999, 1000],
        [999, 500],
        [499, 200],
        [199, 50],
        [49, 20]
    ]

    if (value <= sizes.Length) {
        size := sizes[value]
        myP.SetSize(size[1], size[2])
    } else {
        myP.SetSize(0, 0)
    }
}

; TODO: Clean this up if possible. It looks like a LOT
SetDirection(value) {
    directions := [0, 45, 90, 135, 180, 225, 270, 315]

    if (value <= directions.Length) {
        direction := directions[value]
        myP.SetDirection(direction)
    } else {
        myP.SetDirection(0)
    }
}

ChangeTileSize(db, dbparams) {
    sizes := [1024, 2048, 4096, 8192, 16384, 32768]

    if (db.Value <= sizes.Length) {
        size := sizes[db.Value]
        myP.SetTileSize(size)
    } else {
        myP.SetTileSize(4096)
    }
}
; ########## END: Methods ##########