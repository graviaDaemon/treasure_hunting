#Include <BaseProperties>

class PieProperties extends BaseProperties {
    __New(name) {
        this.MapName := name
        this.sizeLargePie := ((1000/4096) * 4096) * 2 ; diameter and width of the larger pie slice
        this.sizeSmallPie := ((1000/4096) * 2000) * 2 ; diameter and width of the smaller pie slice
        this.pieRadius := 0 ; The start rotation will always face north, so -120 degrees is when the pie slice faces north
        this.largePieColorString := "000000"
        this.smallPieColorString := "FFFFFF"
        this.largePieColorHex := this.__ParseToHex("0xFF000000")
        this.smallPieColorHex := this.__ParseToHex("0xFFffffff")
    }

    SetLargePieColor(color) {
        this.largePieColorString := color
        this.largePieColorHex := 0xFF000000 | this.__ParseToHex(color)
        ; this.__SetNewText("InfoSection_9_value", "#" this.largePieColorString, "c" this.largePieColorString, true)
    }

    SetSmallPieColor(color) {
        this.smallPieColorString := color
        this.smallPieColorHex := 0xFF000000 | this.__ParseToHex(color)
        ; this.__SetNewText("InfoSection_10_value", "#" this.smallPieColorString, "c" this.smallPieColorString, true)
    }

    ; Set the size of the two pie slices.
    ; Multiply by 2, because this looks to use half of the tile size we need 
    ; This is a quick fix, check the math!
    SetDistance(l, s) {
        this.sizeLargePie := (this.tileSize * l) * 2
        ; (times 2 because it draws this as diameter, instead of radius)
        this.sizeSmallPie := (this.tileSize * s) * 2
        ; this.__SetNewText("InfoSection_3_value", l " Tiles")
        ; this.__SetNewText("InfoSection_4_value", s " Tiles")
    }

    ; Set the direction the pie slice should face
    SetDirection(r) {
        this.pieRadius := r
        ; this.__SetNewText("InfoSection_5_value", FigureDirection(r))
    }
}