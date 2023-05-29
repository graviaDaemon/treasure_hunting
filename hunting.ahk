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
; Upon clicking the "Draw" button, this method will be called
; It checks if any previous drawing has been made, and destroys that
; Then it sets the size and direction of the slices
; Then it will intialize the class which will draw a whole new item
; And calls the "Draw" method. Passing in the previous gui
Draw(b, bparam) {
    if myP.Drawn
        guiWindow.Destroy()

    SetSize(requestGui["DistanceBox"].Value)
    SetDirection(requestGui["DirectionBox"].Value)

    global huntDisplay := Hunt(myP)
    huntDisplay.Draw()
}

; Upon clicking the "Clear" button, this method will be called
; It checks if any previous drawig has been made, and destroys that
; Otherwise it will return a message saying there was no drawing made
Clear(b, bparam) {
    if myP.Drawn
        huntDisplay.Clear(guiWindow)
    else
        MsgBox "Nothing was drawn yet, so nothing is cleared", "Warning"
    return
}

; Sets the size based on the dropdown value, which in the Props class sets the right sizes
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

; Sets the direction based on the dropdown value, which in the Props class sets the right rotation
SetDirection(value) {
    directions := [0, 45, 90, 135, 180, 225, 270, 315]

    if (value <= directions.Length) {
        direction := directions[value]
        myP.SetDirection(direction)
    } else {
        myP.SetDirection(0)
    }
}

; Based on the map size dropdown value, this sets the map size, and thus the tile size in the props class
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