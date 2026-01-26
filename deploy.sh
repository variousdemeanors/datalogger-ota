#!/bin/bash
# Usage: ./deploy.sh sender v1.0.1 path/to/build.bin

TYPE=$1    # sender or display
VERSION=$2 # e.g. v1.0.1
BIN_PATH=$3

if [ -z "$BIN_PATH" ]; then
    echo "Usage: ./deploy.sh [sender|display] [version] [bin_path]"
    exit 1
fi

DEST_BIN="bin/${TYPE}_${VERSION}.bin"
cp "$BIN_PATH" "$DEST_BIN"

# Update manifest.json (requires jq)
# If jq isn't installed, we can use a simple sed or python script
python3 -c "
import json
with open('manifest.json', 'r') as f:
    data = json.load(f)
data['${TYPE}']['version'] = '${VERSION}'
data['${TYPE}']['url'] = 'https://raw.githubusercontent.com/variousdemeanors/datalogger-ota/main/${DEST_BIN}'
with open('manifest.json', 'w') as f:
    json.dump(data, f, indent=2)
"

git add "$DEST_BIN" manifest.json
git commit -m "Deploy ${TYPE} ${VERSION}"
git push origin master
