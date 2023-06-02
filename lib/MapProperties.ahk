#Include <BaseProperties>

class MapProperties extends BaseProperties {
    __New() {
        this.mapSize := 4096
        this.screenSize := 1000 ; height and width of the drawing screen
        this.tileSize := 1000 / 4096 ; 4.096 tiles per pixel, means that the pixel size per tile is 0.24414

        this.xPosition := 0 ; double
        this.yPosition := 0 ; double
        super.Drawn := false
    }

    SetScreenSize(w) {
        this.screenSize := w
        ; this.__SetNewText("InfoSection_1_value", this.screenSize " x" this.screenSize)
    }

    SetTileSize(size) {
        this.mapSize := size
        this.tileSize := this.screenSize / size
        ; this.__SetNewText("InfoSection_2_value", size " x " size)
        ; this.__SetNewText("InfoSection_8_value", this.tileSize " Pixels per tile")
    }

    ; Sets the X Coordinates in this class
    SetXCoord(value) {
        this.xPosition := value
        ; this.__SetNewText("InfoSection_6_value", this.xPosition)
    }

    ; Sets the Y Coordinates in this class
    SetYCoord(value) {
        this.yPosition := value
        ; this.__SetNewText("InfoSection_7_value", this.yPosition)
    }
}