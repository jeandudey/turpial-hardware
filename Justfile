profile := "KiCAD/Turpial.pro"

top_footprint_possition_file := "KiCAD/Turpial-top-pos.csv"
top_feed_file:= "assembly/top-feed.csv"
top_ic_file:= "assembly/top-ic.csv"
top_feed_dpv :=  "assembly/top-feed.dpv"
top_ic_dpv :=  "assembly/top-ic.dpv"

deps:
    cargo install --git https://github.com/sanantonio-tech/rust-kichm.git

kicad:
    #!/bin/sh
    (kicad {{profile}} >/dev/null 2>&1 &)

# To open LibreOffice for edition of the top layer feeders and IC tray
# files, e.g:
#
# - just edit top-feed
# - just edit top-ic
edit file:
    #!/bin/sh
    (libreoffice assembly/{{file}}.csv >/dev/null 2>&1 &)

# Convert footprint position file to Charmhigh work file
# by using both feeders and IC trays.
#
# Output file can be set manually on the CLI
#
# - just convert turpial
#
# Will generate a turpial.dpv workfile
convert-all output:
    kichm convert --feeders {{top_feed_file}} --ic-tray {{top_ic_file}} {{top_footprint_possition_file}} {{output}}.dpv

convert-feeders:
    kichm convert --feeders {{top_feed_file}} {{top_footprint_possition_file}} {{top_feed_dpv}}

convert-ic-trays:
    kichm convert --ic-tray {{top_ic_file}} {{top_footprint_possition_file}} {{top_ic_dpv}}

# Normal conversion
convert: convert-feeders convert-ic-trays
