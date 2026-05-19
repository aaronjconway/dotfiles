#!/usr/bin/env bash

timezone=$(timedatectl show --property=Timezone --value | cut -d/ -f2)
date +"%a %b %e %H:%M:%S %Z $timezone"
