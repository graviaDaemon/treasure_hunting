#Include <GuiSetup>
; A basic properties object. This class will hold all the properties required for the drawings on screen
class Props {
    __New() { 
        ;#region Pie properties
        this.sizeLargePie := ((1000/4096) * 4096) * 2 ; diameter and width of the larger pie slice
        this.sizeSmallPie := ((1000/4096) * 2000) * 2 ; diameter and width of the smaller pie slice
        this.pieRadius := 0 ; The start rotation will always face north, so -120 degrees is when the pie slice faces north
        this.largePieColorString := "000000"
        this.smallPieColorString := "FFFFFF"
        this.largePieColorHex := this.__ParseToHex("0xFF000000")
        this.smallPieColorHex := this.__ParseToHex("0xFFffffff")
        ;#endregion

        ;#region Map Properties
        this.mapSize := 4096
        this.screenSize := 1000 ; height and width of the drawing screen
        this.tileSize := 1000 / 4096 ; 4.096 tiles per pixel, means that the pixel size per tile is 0.24414

        this.xPosition := 0 ; double
        this.yPosition := 0 ; double
        ;#endregion

        this.Drawn := false ; the property that makes the code check if there was already someting drawn or not
    }

    /* 
        Created setter methods here instead of setting them by calling the props. 
        As an error prevention method. Easier to debug and less error prone this way
    */
    SetScreenSize(w) {
        this.screenSize := w
        this.__SetNewText("InfoSection_1_value", this.screenSize " x" this.screenSize)
    }

    SetTileSize(size) {
        this.mapSize := size
        this.tileSize := this.screenSize / size
        this.__SetNewText("InfoSection_2_value", size " x " size)
        this.__SetNewText("InfoSection_8_value", this.tileSize " Pixels per tile")
        
       
    }
    
    ; Set the size of the two pie slices.
    ; Multiply by 2, because this looks to use half of the tile size we need 
    ; This is a quick fix, check the math!
    SetDistance(l, s) {
        this.sizeLargePie := (this.tileSize * l) * 2
        ; (times 2 because it draws this as diameter, instead of radius)
        this.sizeSmallPie := (this.tileSize * s) * 2
        this.__SetNewText("InfoSection_3_value", l " Tiles")
        this.__SetNewText("InfoSection_4_value", s " Tiles")
    }

    ; Set the direction the pie slice should face
    SetDirection(r) {
        this.pieRadius := r
        this.__SetNewText("InfoSection_5_value", FigureDirection(r))
    }

    ; Sets the X Coordinates in this class
    SetXCoord(value) {
        this.xPosition := value
        this.__SetNewText("InfoSection_6_value", this.xPosition)
    }

    ; Sets the Y Coordinates in this class
    SetYCoord(value) {
        this.yPosition := value
        this.__SetNewText("InfoSection_7_value", this.yPosition)
    }

    SetLargePieColor(color) {
        this.largePieColorString := color
        this.largePieColorHex := 0xFF000000 | this.__ParseToHex(color)
        this.__SetNewText("InfoSection_9_value", "#" this.largePieColorString, "c" this.largePieColorString, true)
    }

    SetSmallPieColor(color) {
        this.smallPieColorString := color
        this.smallPieColorHex := 0xFF000000 | this.__ParseToHex(color)
        this.__SetNewText("InfoSection_10_value", "#" this.smallPieColorString, "c" this.smallPieColorString, true)
    }

    __ParseToHex(str) {
        VarSetStrCapacity(&s, 66)
        value := DllCall("msvcrt.dll\_wcstoui64", "Str", str, "UInt", 0, "UInt", 16, "CDECL Int64")
        DllCall("msvcrt.dll\_i64tow", "Int64", value, "Str", s, "UInt", 10, "CDECL")
        Return s
    }

    __SetNewText(title, value, fontValue?, font := false) {
        requestGui[title].Text := value
        if (font) {
            requestGui[title].SetFont(fontValue)
        }
    }
}

; ff4b4b