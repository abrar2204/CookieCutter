#!/bin/bash -e

cd tools || true
cd ../

if ! [[ "$OSTYPE" == "win32" || "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" ]]; 
then
    chmod +x tools/talisman/talisman-precommit.sh
    tools/talisman/talisman-precommit.sh
else
    mkdir .git/hooks
fi

cp tools/hooks/commit-msg .git/hooks
chmod +x .git/hooks/commit-msg
