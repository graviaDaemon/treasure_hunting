#Include <GuiSetup>
; A basic properties object. This class will hold all the properties required for the drawings on screen
class BaseProperties {
    __New() { 
        this.Drawn := false ; the property that makes the code check if there was already someting drawn or not
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