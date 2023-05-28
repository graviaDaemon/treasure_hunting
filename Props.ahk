; A basic properties object. This class will hold all the properties required for the drawings on screen
class Props {
    sizeLargePie := 0 ; radius and width of the larger pie slice
    sizeSmallPie := 0 ; radius and width of the smaller pie slice
    tileSize := 1000 / 4096 ; 4.096 tiles per pixel, means that the pixel size per tile is 0.24414
    pieRadius := -120 ; The start rotation will always face north, so -120 degrees is when the pie slice faces north
    xPosition := 0 ; double
    yPosition := 0 ; double
    Width := 1000 ; widht of the drawing screen
    Height := 1000 ; height of the drawing screen
    Drawn := false
    ; The __New() constructor doesn't do much, but we have to include it
    __New() { 

    }

    ; Set the size of the two pie slices.
    SetSize(l, s) {
        this.sizeLargePie := this.tileSize * l
        this.sizeSmallPie := this.tileSize * s
    }

    ; Set the direction the pie slice should face
    SetDirection(r) {
        this.pieRadius := r
    }

    ; Sets the X Coordinates in this class
    SetXCoord(value) {
        this.xPosition := value
    }

    ; Sets the Y Coordinates in this class
    SetYCoord(value) {
        this.yPosition := value
    }

    SetTileSize(size) {
        this.tileSize := 1000 / size
    }
}