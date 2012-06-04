import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Config.Xfce

myManageHook = composeAll
    [ className =? "Gimp"      --> doFloat
    , className =? "Vncviewer" --> doFloat
    , className =? "Xfrun4"    --> doFloat
    ]

main = xmonad $ xfceConfig
    { manageHook = manageDocks <+> myManageHook
                   <+> manageHook defaultConfig
    , layoutHook = avoidStruts $ layoutHook defaultConfig
    , modMask = mod4Mask
    , terminal = "x-terminal-emulator"
    } `additionalKeys`
    [ ((mod4Mask, xK_v), spawn "edit")
    , ((mod4Mask .|. shiftMask, xK_f), spawn "x-www-browser")
    , ((mod4Mask .|. shiftMask, xK_F12), spawn "$HOME/bin/susp-hiber susp")
    , ((mod4Mask .|. controlMask, xK_F12), spawn "$HOME/bin/susp-hiber hiber")
    , ((0, xK_Print), spawn "scrot")
    ]
