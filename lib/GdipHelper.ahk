#Include Gdip.ahk

/*
    This entire file serves as assistance in setting up GDI+
    Creating and destroying any drawings created
*/

/* 
    This just adds the basics, namely startup GDI+ 
    and set an Exit method that is called when GDI+ has not been able to start
*/
JustTheBasics() {
    global pToken := Gdip_Startup()
    ; Start GDI+
    if !pToken
    {
        MsgBox "GdiPlus failed to start. Please ensure you have gdiplus on your system", "Error"
        ExitApp
    }
    OnExit(ExitProgram)
    return    
}

/* 
    Setup all the GDI+ items, including the GUI window with the width and height given by the calling objects
*/
SetupGDIP(iWidth, iHeight) {
    global Width := iWidth
    global Height := iHeight
    
    if (Width < 0) {
        Width := A_ScreenWidth
    }

    if (Height < 0) {
        Height := A_ScreenHeight
    }

    JustTheBasics()

    global guiWindow := Gui("-Caption +E0x80000 +LastFound +AlwaysOnTop +ToolWindow +OwnDialogs", "guiWindow")
    guiWindow.Show("NA")

    global hwnd := WinExist("guiWindow")
    if hwnd {
        WinMove -1920, 0
    }
    WinMove 

    return
}

/* 
    Start the drawing of the given object including the Width and Height of the bitmap
*/
StartDrawGDIP() {
    global hbm := CreateDIBSection(Width, Height)

    global hdc := CreateCompatibleDC()

    global obm := SelectObject(hdc, hbm)

    global graphics := Gdip_GraphicsFromHDC(hdc)
}

; Cleanup after drawing
EndDrawGDIP() {
    global
    UpdateLayeredWindow(hwnd, hdc, 0, 0, Width, Height)

    SelectObject(hdc, obm)

    DeleteObject(hbm)

    DeleteDC(hdc)

    Gdip_DeleteGraphics(graphics)
}

; Clear the drawing from the board without removing the GUI
ClearDrawGDIP(guiWindow) {
    Gdip_GraphicsClear(graphics)
    guiWindow.Destroy()
}

; Exit the program when GDI+ has been started
ExitProgram(ExitReason, ExitCode) {
    ; gdi+ may now be shutdown on exiting the program
    Gdip_Shutdown(pToken)
    ExitApp
    return
}

; Exit the program before any GDI+ has been started
ExitWithoutGraphics(ExitReason, ExitCode) {
    ExitApp
    return
}