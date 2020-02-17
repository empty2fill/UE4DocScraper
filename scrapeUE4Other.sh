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

httrack -%l "en" -F "Mozilla/4.5 (compatible; HTTrack 3.0x; Windows 98)" \
    -%F "<!-- Mirrored from %s%s by HTTrack Website Copier/3.x, %s -->" \
    https://docs.unrealengine.com:443/en-US/GettingStarted/index.html \
    https://docs.unrealengine.com:443/en-US/Programming/index.html \
    https://docs.unrealengine.com:443/en-US/Blueprints/index.html \
    https://docs.unrealengine.com:443/en-US/Gameplay/index.html \
    https://docs.unrealengine.com:443/en-US/Resources/index.html \
    https://docs.unrealengine.com:443/en-US/Platforms/index.html \
    https://docs.unrealengine.com:443/en-US/Support/index.html \
    https://docs.unrealengine.com:443/en-US/EarlyAccessFeatures/index.html \
    https://docs.unrealengine.com:443/en-US/ExperimentalFeatures/index.html \
    -i -O ./$1/ -%v ${disableSec} ${linkLimit} ${connects} ${maxConnects} ${rateLimit} ${robots} \
    +docs.unrealengine.com:443/en-US/GettingStarted/* \
    +docs.unrealengine.com:443/en-US/Programming/* \
    +docs.unrealengine.com:443/en-US/Blueprints/* \
    +docs.unrealengine.com:443/en-US/Gameplay/* \
    +docs.unrealengine.com:443/en-US/Resources/* \
    +docs.unrealengine.com:443/en-US/Platforms/* \
    +docs.unrealengine.com:443/en-US/Support/* \
    +docs.unrealengine.com:443/en-US/EarlyAccessFeatures/* \
    +docs.unrealengine.com:443/en-US/ExperimentalFeatures/* \
    +docs.unrealengine.com:443/include/* \
    +docs.unrealengine.com:443/images/* \
    +static-assets-prod.epicgames.com/*
