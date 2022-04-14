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
    https://docs.unrealengine.com/4.27/en-US/WhatsNew/index.html \
    https://docs.unrealengine.com/4.27/en-US/Basics/index.html \
    https://docs.unrealengine.com/4.27/en-US/WorkingWithContent/index.html \
    https://docs.unrealengine.com/4.27/en-US/BuildingWorlds/index.html \
    https://docs.unrealengine.com/4.27/en-US/RenderingAndGraphics/index.html \
    https://docs.unrealengine.com/4.27/en-US/ProgrammingAndScripting/index.html \
    https://docs.unrealengine.com/4.27/en-US/InteractiveExperiences/index.html \
    https://docs.unrealengine.com/4.27/en-US/AnimatingObjects/index.html \
    https://docs.unrealengine.com/4.27/en-US/WorkingWithAudio/index.html \
    https://docs.unrealengine.com/4.27/en-US/WorkingWithMedia/index.html \
    https://docs.unrealengine.com/4.27/en-US/ProductionPipelines/index.html \
    https://docs.unrealengine.com/4.27/en-US/TestingAndOptimization/index.html \
    https://docs.unrealengine.com/4.27/en-US/SharingAndReleasing/index.html \
    -i -O ./$1/ \
    -%v ${disableSec} ${linkLimit} ${connects} ${maxConnects} ${rateLimit} ${robots} \
    -docs.unrealengine.com/4.27/en-US/API/* \
    -docs.unrealengine.com/4.27/en-US/BlueprintAPI/* \
    -docs.unrealengine.com/4.27/en-US/PythonAPI/* \
    -docs.unrealengine.com/4.27/en-US/Resources/* \
    +docs.unrealengine.com/4.27/en-US/WhatsNew/* \
    +docs.unrealengine.com/4.27/en-US/Basics/* \
    +docs.unrealengine.com/4.27/en-US/WorkingWithContent/* \
    +docs.unrealengine.com/4.27/en-US/BuildingWorlds/* \
    +docs.unrealengine.com/4.27/en-US/RenderingAndGraphics/* \
    +docs.unrealengine.com/4.27/en-US/ProgrammingAndScripting/* \
    +docs.unrealengine.com/4.27/en-US/InteractiveExperiences/* \
    +docs.unrealengine.com/4.27/en-US/AnimatingObjects/* \
    +docs.unrealengine.com/4.27/en-US/WorkingWithAudio/* \
    +docs.unrealengine.com/4.27/en-US/WorkingWithMedia/* \
    +docs.unrealengine.com/4.27/en-US/ProductionPipelines/* \
    +docs.unrealengine.com/4.27/en-US/TestingAndOptimization/* \
    +docs.unrealengine.com/4.27/en-US/SharingAndReleasing/* \
    +docs.unrealengine.com/4.27/Include/* \
    +docs.unrealengine.com/4.27/Images/* \
    +static-assets-prod.unrealengine.com/*
