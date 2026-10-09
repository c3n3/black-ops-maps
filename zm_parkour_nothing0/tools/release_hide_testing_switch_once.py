"""Release: remove the testing switch (handle script_model + static body) from the spawn deck. The originals are in
map_source/zm/zm_parkour_nothing0.map.pre_release.bak; scripts also gate it behind TESTING_SWITCH."""

import sys

from maplib import *

m = Map(sys.argv[1])
gone = [i for i in range(1, len(m.ents)) if m.kv(i).get("targetname") == "godmode_switch_handle"
        or (m.kv(i).get("model") == "p7_zm_der_pswitch_body" and m.kv(i).get("origin") == "-208.375 -113.625 -7")]
assert len(gone) == 2, gone
m.ents = [e for i, e in enumerate(m.ents) if i not in gone]
m.save()
print("testing switch removed")
