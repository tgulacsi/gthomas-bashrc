--
-- An example, simple ~/.xmonad/xmonad.hs file.
-- It overrides a few basic settings, reusing all the other defaults.
--

import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig
import XMonad

main = xmonad $ defaultConfig
    { borderWidth        = 2
    , modMask            = mod4Mask
    , focusFollowsMouse  = True
    , terminal           = "x-terminal-emulator" }
    `additionalKeysP`
    [ ("M-x f", spawn "firefox")
    , ("M-<Up>", windows W.swapUp)
    ]
