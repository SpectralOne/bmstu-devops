#!/usr/bin/env bash
set -e

printf "\nBuilding\n"

bun build --target=bun ./src/app.js --outdir ./dist
cp -r src/public dist

printf "\nDone\n"

printf "\nCI enrichment\n"

printf "\n\n CI = $CI \n\n"
printf "\n\n CI_COMMIT_AUTHOR = $CI_COMMIT_AUTHOR \n\n"
printf "\n\n CI_COMMIT_MESSAGE = $CI_COMMIT_MESSAGE \n\n"
printf "\n\n CI_COMMIT_SHA = $CI_COMMIT_SHA \n\n"
printf "\n\n CI_COMMIT_TIMESTAMP = $CI_COMMIT_TIMESTAMP \n\n"

export CI=$(echo $CI | tr '\n' ' ')
export CI_COMMIT_AUTHOR=$(echo $CI_COMMIT_AUTHOR | tr '\n' ' ')
export CI_COMMIT_MESSAGE=$(echo $CI_COMMIT_MESSAGE | tr '\n' ' ')
export CI_COMMIT_SHA=$(echo $CI_COMMIT_SHA | tr '\n' ' ')
export CI_COMMIT_TIMESTAMP=$(echo $CI_COMMIT_TIMESTAMP | tr '\n' ' ')

sed -i "s,===CI===,${CI},;\
        s,===CI_COMMIT_AUTHOR===,${CI_COMMIT_AUTHOR},;\
        s,===CI_COMMIT_MESSAGE===,${CI_COMMIT_MESSAGE},;\
        s,===CI_COMMIT_SHA===,${CI_COMMIT_SHA},;\
        s,===CI_COMMIT_TIMESTAMP===,${CI_COMMIT_TIMESTAMP}," \
        -- dist/public/pages/index.html

printf "\nDone\n"

printf "\nPacking\n"

tar -czvf dist.tar.gz dist && rm -R dist

printf "\nDone\n"
