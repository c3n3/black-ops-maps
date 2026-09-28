"""Testing aid: godmode switch on the spawn deck (north-west corner, facing the players)."""

import sys

from maplib import *

DECK_TOP = 16
X, Y = -140, 44          # wall face; at angles 0 the switch's wall is on +y and players stand on -y

m = Map(sys.argv[1])
assert not m.find(targetname="godmode_switch_handle"), "the godmode switch is already in this map"
m.add_world(box(X - 16, X + 16, Y, Y + 8, DECK_TOP, DECK_TOP + 80, IRON))   # backing post
m.add(*switch(X, Y, "godmode_switch_handle", z=DECK_TOP))
m.save()
print("godmode switch at", (X, Y, DECK_TOP))
