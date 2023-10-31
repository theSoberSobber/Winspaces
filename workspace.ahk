; AutoHotkey v2 script
SetWorkingDir(A_ScriptDir)

; Path to the DLL, relative to the script
VDA_PATH := A_ScriptDir . "\VirtualDesktopAccessor.dll"
hVirtualDesktopAccessor := DllCall("LoadLibrary", "Str", VDA_PATH, "Ptr")

GetDesktopCountProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "GetDesktopCount", "Ptr")
GoToDesktopNumberProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "GoToDesktopNumber", "Ptr")
GetCurrentDesktopNumberProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "GetCurrentDesktopNumber", "Ptr")
IsWindowOnCurrentVirtualDesktopProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "IsWindowOnCurrentVirtualDesktop", "Ptr")
IsWindowOnDesktopNumberProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "IsWindowOnDesktopNumber", "Ptr")
MoveWindowToDesktopNumberProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "MoveWindowToDesktopNumber", "Ptr")
IsPinnedWindowProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "IsPinnedWindow", "Ptr")
GetDesktopNameProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "GetDesktopName", "Ptr")
SetDesktopNameProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "SetDesktopName", "Ptr")
CreateDesktopProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "CreateDesktop", "Ptr")
RemoveDesktopProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "RemoveDesktop", "Ptr")

MoveCurrentWindowToDesktop(number) {
    global MoveWindowToDesktopNumberProc, GoToDesktopNumberProc
    activeHwnd := WinGetID("A")
    DllCall(MoveWindowToDesktopNumberProc, "Ptr", activeHwnd, "Int", number, "Int")
    DllCall(GoToDesktopNumberProc, "Int", number, "Int")
}

MoveOrGotoDesktopNumber(num) {
    GoToDesktopNumber(num)
    return
}

GoToDesktopNumber(num) {
    global GoToDesktopNumberProc
    DllCall(GoToDesktopNumberProc, "Int", num, "Int")
    return
}

MoveToDesktopNumber(num) {
	; current := DllCall(GetCurrentDesktopNumberProc, "Int")
	MoveCurrentWindowToDesktop(num)
    ; MoveOrGotoDesktopNumber(current)
	return
}

# Win+Num
#1:: MoveOrGotoDesktopNumber(0)
#2:: MoveOrGotoDesktopNumber(1)
#3:: MoveOrGotoDesktopNumber(2)
#4:: MoveOrGotoDesktopNumber(3)!
#5:: MoveOrGotoDesktopNumber(4)
#6:: MoveOrGotoDesktopNumber(5)
#7:: MoveOrGotoDesktopNumber(6)
#8:: MoveOrGotoDesktopNumber(7)
#9:: MoveOrGotoDesktopNumber(8)
#0:: MoveOrGotoDesktopNumber(9)

# Win+Shift+Num
#+1:: MoveToDesktopNumber(0)
#+2:: MoveToDesktopNumber(1)
#+3:: MoveToDesktopNumber(2)
#+4:: MoveToDesktopNumber(3)
#+5:: MoveToDesktopNumber(4)
#+6:: MoveToDesktopNumber(5)
#+7:: MoveToDesktopNumber(6)
#+8:: MoveToDesktopNumber(7)
#+9:: MoveToDesktopNumber(8)
#+0:: MoveToDesktopNumber(9)
