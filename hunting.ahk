; Include the Hunt class as well as the Props class
#Include <Props>
#Include <Requester>
#SingleInstance Force

; ########## START: Basic Setup ##########

myP := Props()

Requester.OpenGui(Requester(myP))

; ########## END:   Basic Setup ##########