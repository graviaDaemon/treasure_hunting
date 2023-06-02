; Include the Hunt class as well as the Props class
#Include <Handler>
#Include <MapProperties>
#Include <PieProperties>
#SingleInstance Force

; ########## START: Basic Setup ##########
global mapProps := MapProperties()

eventHand := Handler(mapProps)
eventHand.OpenGui(eventHand)
; ########## END:   Basic Setup ##########