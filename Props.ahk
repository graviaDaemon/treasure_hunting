; A basic properties object. This class will hold all the properties required for the drawings on screen
class Props {
    sizeLargePie := 4096 ; radius and width of the larger pie slice
    sizeSmallPie := 2000 ; radius and width of the smaller pie slice
    mapSize := 4096
    screenSize := 1000
    tileSize := this.screenSize / this.mapSize ; 4.096 tiles per pixel, means that the pixel size per tile is 0.24414
    pieRadius := 0 ; The start rotation will always face north, so -120 degrees is when the pie slice faces north
    xPosition := 0 ; double
    yPosition := 0 ; double
    Width := this.screenSize ; widht of the drawing screen
    Height := this.screenSize ; height of the drawing screen

    largePieColor := "000000"
    smallPieColor := "ffffff"
    smallPieColorNum := 0
    Drawn := false
    ; The __New() constructor doesn't do much, but we have to include it
    __New() { 

    }

    /* 
        Created setter methods here instead of setting them by calling the props. 
        As an error prevention method. Easier to debug and less error prone this way
    */
    SetScreenSize(w) {
        this.screenSize := w
        this.Width := this.screenSize
        this.Height := this.screenSize
        requestGui["InfoSection_1_value"].Text := this.Width " x" this.Height
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
        this.largePieColor := color
        requestgui["InfoSection_9_value"].Text := "#" color
        requestgui["InfoSection_9_value"].SetFont("c" color)
    }

    SetSmallPieColor(color) {
        this.smallPieColor := color
        requestGui["InfoSection_10_value"].Text := "#" color
        requestGui["InfoSection_10_value"].SetFont("c" color)
    }
}