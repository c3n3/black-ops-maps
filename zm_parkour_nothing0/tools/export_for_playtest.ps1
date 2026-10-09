<#
Packages zm_parkour_nothing0 into a zip a friend can drop into their Black Ops III "usermaps" folder.
Nothing is published or uploaded; this only writes a local zip.

Run it AFTER a full Compile + Light + Link in the Mod Tools launcher:
    powershell -ExecutionPolicy Bypass -File "tools\export_for_playtest.ps1"
Optional: -OutFile "D:\somewhere\zm_parkour_nothing0_playtest.zip"
#>
param(
    [string]$OutFile = (Join-Path ([Environment]::GetFolderPath("Desktop")) "zm_parkour_nothing0_playtest.zip")
)

$ErrorActionPreference = "Stop"
$Map     = "zm_parkour_nothing0"
$MapDir  = Split-Path -Parent $PSScriptRoot                     # ...\usermaps\zm_parkour_nothing0
$Zone    = Join-Path $MapDir "zone"
$BO3     = Split-Path -Parent (Split-Path -Parent $MapDir)       # ...\Call of Duty Black Ops III

# ---- audit: everything the game needs is there, and the build isn't older than the sources ----
$required = @("$Map.ff", "en_$Map.ff", "$Map.xpak", "en_$Map.xpak", "snd")
$missing = $required | Where-Object { -not (Test-Path (Join-Path $Zone $_)) }
if ($missing) { throw "Missing from zone\: $($missing -join ', '). Run Compile + Light + Link in the launcher first." }

$built = (Get-Item (Join-Path $Zone "$Map.ff")).LastWriteTime
$sources = @(
    (Join-Path $BO3 "map_source\zm\$Map.map"),
    (Join-Path $MapDir "scripts\zm\$Map.gsc"),
    (Join-Path $MapDir "scripts\zm\$Map.csc"),
    (Join-Path $MapDir "scripts\zm\_zm_perk_mule_lick.gsc"),
    (Join-Path $MapDir "zone_source\$Map.zone"),
    (Join-Path $MapDir "gamedata\weapons\zm\${Map}_weapons.csv")
) | Where-Object { Test-Path $_ }
$stale = $sources | Where-Object { (Get-Item $_).LastWriteTime -gt $built }
if ($stale) {
    Write-Warning "These changed after the last Link ($built) - the zip would be out of date:"
    $stale | ForEach-Object { Write-Warning "  $_" }
    throw "Run Compile + Light + Link again, then re-run this script."
}
$bsp = Join-Path $BO3 "share\raw\maps\zm\$Map.d3dbsp"
$led = Join-Path $BO3 "share\raw\maps\zm\$Map.led"
if ((Test-Path $bsp) -and (Test-Path $led) -and ((Get-Item $led).LastWriteTime -lt (Get-Item $bsp).LastWriteTime)) {
    Write-Warning "Lighting (.led) is older than the compiled map (.d3dbsp): new lights won't be baked. Run Light + Link."
}
$gsc = Get-Content (Join-Path $MapDir "scripts\zm\$Map.gsc") -Raw
if ($gsc -match "level thread godmode_switch\(\);") {
    Write-Warning "The TESTING ONLY loadout switch is still enabled (spawn deck). Fine for a playtest; remove before publishing."
}

# ---- zip: <Map>\zone\... so it extracts straight into the usermaps folder ----
Add-Type -AssemblyName System.IO.Compression, System.IO.Compression.FileSystem
if (Test-Path $OutFile) { Remove-Item -LiteralPath $OutFile -Force }
$zip = [System.IO.Compression.ZipFile]::Open($OutFile, [System.IO.Compression.ZipArchiveMode]::Create)
try {
    $files = Get-ChildItem -LiteralPath $Zone -Recurse -File
    foreach ($f in $files) {
        $rel = $f.FullName.Substring($Zone.Length).TrimStart('\').Replace('\', '/')
        # the .xpak / .ff are already compressed: storing them is much faster and barely bigger
        $level = if ($f.Extension -in ".xpak", ".ff") { [System.IO.Compression.CompressionLevel]::NoCompression } `
                 else { [System.IO.Compression.CompressionLevel]::Optimal }
        Write-Host ("  adding {0,-45} {1,10:N1} MB" -f "$Map/zone/$rel", ($f.Length / 1MB))
        [void][System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip, $f.FullName, "$Map/zone/$rel", $level)
    }
    $readme = Join-Path $PSScriptRoot "PLAYTEST_README.txt"
    if (Test-Path $readme) {
        [void][System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip, $readme, "PLAYTEST_README.txt")
    }
}
finally { $zip.Dispose() }

# ---- verify the zip reads back ----
$check = [System.IO.Compression.ZipFile]::OpenRead($OutFile)
try {
    $names = $check.Entries | ForEach-Object FullName
    foreach ($r in $required | Where-Object { $_ -ne "snd" }) {
        if ("$Map/zone/$r" -notin $names) { throw "Zip check failed: $Map/zone/$r is missing" }
    }
    "Zip OK: {0} entries, {1:N2} GB -> {2}" -f $names.Count, ((Get-Item $OutFile).Length / 1GB), $OutFile
}
finally { $check.Dispose() }
