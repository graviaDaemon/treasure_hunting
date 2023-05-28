#Include Gdip.ahk

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

StartDrawGDIP() {
    global hbm := CreateDIBSection(Width, Height)

    global hdc := CreateCompatibleDC()

    global obm := SelectObject(hdc, hbm)

    global graphics := Gdip_GraphicsFromHDC(hdc)
}

EndDrawGDIP(xPos, yPos) {
    global
    UpdateLayeredWindow(hwnd, hdc, 0, 0, Width, Height)

    SelectObject(hdc, obm)

    DeleteObject(hbm)

    DeleteDC(hdc)

    Gdip_DeleteGraphics(graphics)
}

ClearDrawGDIP() {
    Gdip_GraphicsClear(graphics, 0x00000000)
}

ExitProgram(ExitReason, ExitCode) {
    ; gdi+ may now be shutdown on exiting the program
    Gdip_Shutdown(pToken)
    ExitApp
    return
}

ExitWithoutGraphics(ExitReason, ExitCode) {
    ExitApp
    return
}