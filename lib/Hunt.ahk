#Include <GdipHelper>

class Hunt {
; ########## START: Variables ##########
    props := Props ; this is its own class, included at the top
    skloWindow := 0
; ########## END:   Variables ##########
    __New(props) {
        this.props := props
        this.FindWindow() ; Find the window over which to create the GUI (eg. the Sklotopolis map)
    }
    
    ; Find the specified window, which is the Sklotopolis external map
    FindWindow() {
        this.skloWindow := WinExist("Sklotopolis") ; Find the actual external map window
        if this.skloWindow { ; Check if the window actually exists
            WinActivate "Sklotopolis" ; Activate the window
            WinMove 0, 0 ; move the window to the x: 0, y: 0 coordinates
            CoordMode "Pixel", "Screen" ; Set the coordinate mode to search for pixels and find it on the entire screen
            PixelSearch &Ox, &Oy, 0, 0, 1008, 1031, 0xff1493
            this.props.SetXCoord(Ox) ; Set the X coordinates of the pixel
            this.props.SetYCoord(Oy) ; Set the Y coordinates of the pixel
        }
        else { ; If the window does not exist
            retried := MsgBox("The external map does not exist, please open it and try again", "Warning", "RetryCancel") ; Return a message to the uer to activate it
            if (retried = "Retry") ; If the user clicks retry
                this.FindWindow() ; Restart this method
            else
                ExitApp(ExitProgram)
                return ; Otherwise stop here
        }
        
        return
    }

    ; Draw the actual pie slices on screen
    Draw() {
        this.props.Drawn := true

        ; These three methods are the GDIP helper methods to startup the GDIP methods
        ; Which will actually allow us to draw on the screen
        SetupGDIP(this.props.screenSize, this.props.screenSize)
        StartDrawGDIP()

        guiWindow.Opt("+Parent" this.skloWindow)

        ; Create the first brush for the smaller pie slice. Which we set to white now. 
        pBrush := Gdip_CreatePen(this.props.smallPieColorHex, 3)

        ; Draw the pie slice with the set parameters
        Gdip_DrawPie(
            graphics, ; The graphic to draw in 
            pBrush, ; The brush to use
            this.__GetAbsoluteCoord(this.props.xPosition, this.props.sizeSmallPie), ; The calculated absolute x coordinate point
            this.__GetAbsoluteCoord(this.props.yPosition, this.props.sizeSmallPie), ; the calculated absolute y coordinate point
            this.props.sizeSmallPie, ; the smaller pie size is set here as the width 
            this.props.sizeSmallPie, ; the smaller pie size is set here as the height
            ; The direction is set here where the pieRadius property is in steps of 45 degrees
            ; Whereas the -112.5 is to offset the rotation to the actual north point.
            ; This is because the 0 point of the DrawPie method is set to a horizontal position
            this.props.pieRadius + -112.5, 
            45 ; This is the actual radius of the pie slice, 45 degrees because it's in 8 steps (see dropdown menu items for direction)
        )
        ; And here we delete the brush from memory, so we don't use that memory space anymore
        Gdip_DeletePen(pBrush)

        ; Repeat the same process as above here, but for the larger pie slice
        pBrush := Gdip_CreatePen(this.props.largePieColorHex, 3)
        Gdip_DrawPie(
            graphics, 
            pBrush, 
            this.__GetAbsoluteCoord(this.props.xPosition, this.props.sizeLargePie), ; The calculated absolute x coordinate point
            this.__GetAbsoluteCoord(this.props.yPosition, this.props.sizeLargePie), ; The calculated absolute y coordinate point
            this.props.sizeLargePie, 
            this.props.sizeLargePie, 
            this.props.pieRadius + -112.5,
            45
        )
        Gdip_DeletePen(pBrush)

        ; And here we stop the drawing process
        ; TODO: Add a dialog that restarts the program and removes any previous drawings
        EndDrawGDIP()
        return
    }

    Clear(guiWindow) {
        ClearDrawGDIP(guiWindow)
        return
    }

    ; The position is set here, minus the radius of the circle that is being drawn
    ; I figured out that the pie slices are being cut from a circle
    ; So I get the radius of said circle, and move the center of the circle to the actual coordinate
    ; by subtracting the radius from the axisPosition.
    ; We also remove 8 tiles from the x position, to get to the center of the square on the external map
    __GetAbsoluteCoord(axisCoord, size) {
        return axisCoord - ((size / 2) - (this.props.tileSize * 8))
    }
}

