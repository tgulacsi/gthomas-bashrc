#!/usr/bin/env python
import pynotify
pynotify.init("foo")
pynotify.Notification("POWER WARNING!",
    "Battery capacity is critically low!", "battery-caution").show()
