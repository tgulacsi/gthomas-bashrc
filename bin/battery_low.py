#!/usr/bin/env python
import pynotify
pynotify.init("foo")
pynotify.Notification("Power warning", "Battery capacity is low.",
    "battery-low").show()
