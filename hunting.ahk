; Include the Hunt class as well as the Props class
#Include <MapProperties>
#Include <PieProperties>
#Include <GraphicUserInterface\HuntGui>
#SingleInstance Force

; ########## START: Basic Setup ##########
mapProps := MapProperties()
pieProps := [PieProperties("Map 1"), PieProperties("Map 2")]

global huntDisplay := Hunt(mapProps, pieProps)

hgui := HuntGui(mapProps, pieProps)
hgui.Create()
; ########## END:   Basic Setup ##########