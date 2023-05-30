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
        this.largePieColorHex := this.ParseToHex("0xFF000000")
        this.smallPieColorHex := this.ParseToHex("0xFFffffff")
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
        requestGui["InfoSection_1_value"].Text := this.screenSize " x" this.screenSize
    }

    SetTileSize(size) {
        this.mapSize := size
        this.tileSize := this.screenSize / size
        requestGui["InfoSection_2_value"].Text := size " x " size
        requestGui["InfoSection_8_value"].Text := this.tileSize " Pixels per tile"
    }
    
    ; Set the size of the two pie slices.
    ; Multiply by 2, because this looks to use half of the tile size we need 
    ; This is a quick fix, check the math!
    SetSize(l, s) {
        this.sizeLargePie := (this.tileSize * l) * 2
        ; (times 2 because it draws this as diameter, instead of radius)
        this.sizeSmallPie := (this.tileSize * s) * 2
        requestGui["InfoSection_3_value"].Text := l " Tiles"
        requestGui["InfoSection_4_value"].Text := s " Tiles"
    }

    ; Set the direction the pie slice should face
    SetDirection(r) {
        this.pieRadius := r
        requestGui["InfoSection_5_value"].Text := FigureDirection(r)
    }

    ; Sets the X Coordinates in this class
    SetXCoord(value) {
        this.xPosition := value
        requestGui["InfoSection_6_value"].Text := this.xPosition
    }

    ; Sets the Y Coordinates in this class
    SetYCoord(value) {
        this.yPosition := value
        requestGui["InfoSection_7_value"].Text := this.yPosition
    }

    SetLargePieColor(color) {
        this.largePieColorString := color
        this.largePieColorHex := 0xFF000000 | this.ParseToHex(color)
        requestgui["InfoSection_9_value"].Text := "#" this.largePieColorString
        requestgui["InfoSection_9_value"].SetFont("c" this.largePieColorString)
    }

    SetSmallPieColor(color) {
        this.smallPieColorString := color
        this.smallPieColorHex := 0xFF000000 | this.ParseToHex(color)
        requestGui["InfoSection_10_value"].Text := "#" this.smallPieColorString
        requestGui["InfoSection_10_value"].SetFont("c" this.smallPieColorString)
    }

    ParseToHex(str) {
        VarSetStrCapacity(&s, 66)
        value := DllCall("msvcrt.dll\_wcstoui64", "Str", str, "UInt", 0, "UInt", 16, "CDECL Int64")
        DllCall("msvcrt.dll\_i64tow", "Int64", value, "Str", s, "UInt", 10, "CDECL")
        Return s
    }
}

; ff4b4b