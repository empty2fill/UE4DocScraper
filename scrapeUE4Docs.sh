#!/bin/bash

# These are big web sites so we need to increase the max to get everything
linkLimit="-#L500000" # Max number of links traversed

# If you are going to use the risky setting below, you need this
disableSec="--disable-security-limits" # Disable some built in security standards

# These settings attempt to speed up httrack but are RISKY
# Consider your network, the server, and other factors when adjusting.
robots="-s0" # Ignore the robots.txt limits (0 is ignore)
rateLimit="-A0" # Bitrate limit (0 means no limit)
maxConnects="-%c0" # Max connections per second (0 means no limit)
connects="-c4" # Number of simultaneous connections
debug="-z -Z -v" # z extra infos log, Z debug log, v verbose screen mode

httrack -%l "en" -F "Mozilla/4.5 (compatible; HTTrack 3.0x; Windows 98)" \
    -%F "<!-- Mirrored from %s%s by HTTrack Website Copier/3.x, %s -->" \
    https://docs.unrealengine.com/4.27/en-US/$1/index.html \
    -i -O ./$2/ \
    -%v ${disableSec} ${linkLimit} ${connects} ${maxConnects} ${rateLimit} ${robots} \
    $3 \
    -*/SiteIndex/index.html?tags=* \
    +docs.unrealengine.com/4.27/en-US/$1/* \
    +docs.unrealengine.com/4.27/Include/* \
    +docs.unrealengine.com/4.27/Images/* \
    +static-assets-prod.unrealengine.com/*
