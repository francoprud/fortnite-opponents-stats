#!/usr/bin/python

'''
Script to take a screenshot from the monitor given.

Arguments are (argv[0] is script name...):
  argv[1]: monitor number
  argv[2]: amount of pixels from top
  argv[3]: amount of pixels from left
  argv[4]: width in pixels
  argv[5]: height in pixels
  argv[6]: output folder to leave screenshots
'''

import sys
import mss
import mss.tools
import calendar
import time

with mss.mss() as sct:
  mon = sct.monitors[int(sys.argv[1])]
  sct_img = sct.grab({
    'top': mon['top'] + int(sys.argv[2]),
    'left': mon['left'] + int(sys.argv[3]),
    'width': int(sys.argv[4]),
    'height': int(sys.argv[5]),
    'mon': int(sys.argv[1]),
  })
  output = f'{sys.argv[6]}/{calendar.timegm(time.gmtime())}.png'
  mss.tools.to_png(sct_img.rgb, sct_img.size, output = output)
