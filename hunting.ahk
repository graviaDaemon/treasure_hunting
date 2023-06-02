; Include the Hunt class as well as the Props class
#Include <Props>
#Include <Handler>
#SingleInstance Force

; ########## START: Basic Setup ##########
myP := Props()

Handler.OpenGui(Handler(myP))
; ########## END:   Basic Setup ##########