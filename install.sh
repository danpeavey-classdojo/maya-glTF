#!/bin/zsh

# Vars...
ERROR=`echo "\n\e[31m!! [ERROR]\e[0m"`
WARNSTART="\e[91m"
SUCCESS="\e[92m"
COLOREND="\e[0m"

# Validate operating system...
if [[ ! "$OSTYPE" == "darwin"* ]]
then
  echo "Installation only supported for Mac OS."
fi

# Validate source...
EXEC_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
PLUGIN_FILE="$EXEC_PATH/plug-ins/glTFTranslator.py"
EXPORT_SCRIPT="$EXEC_PATH/scripts/glTFExport.py"
OPTS_SCRIPT="$EXEC_PATH/scripts/glTFTranslatorOpts.mel"
if [[ ! -f "$PLUGIN_FILE"  ]] || [[ ! -f "$EXPORT_SCRIPT" ]] || [[ ! -f "$OPTS_SCRIPT" ]]
then 
  echo "$ERROR"
  echo "One or more installation scripts appear to be missing."
  echo "Please \`git pull\` the latest and try again, or contact an engineer."
  echo ""
  echo "Expected file paths:"
  echo "  $WARNSTART$PLUGIN_FILE"
  echo "  $EXPORT_SCRIPT"
  echo "  $OPTS_SCRIPT$COLOREND"
  echo ""
  return 1
fi

# Validate version and install destination...
TARGET_VERSION="$1"
TARGET_MAYAPREFS_DIR="$HOME/Library/Preferences/Autodesk/maya"
if [[ ! $TARGET_VERSION =~ ^2{1}0{1}[0-9]{2}$ ]]
then 
  REGEX="^$TARGET_MAYAPREFS_DIR/2{1}0{1}[0-9]{2}$"
  FOUND=$(find -E $TARGET_MAYAPREFS_DIR -type d -regex $REGEX | sort -n | tail -1);
  TARGET_VERSION=$(basename $FOUND)

  if [ -z "$FOUND" ]; then
    echo "Could not find any relevant maya installations at path: $TARGET_MAYAPREFS_DIR"
    return 1
  fi
  
  echo "Defaulting to most recent version found at path: $FOUND"
fi

TARGET_ROOT_DIR="$TARGET_MAYAPREFS_DIR/$TARGET_VERSION"
TARGET_PLUGIN_DIR="$TARGET_ROOT_DIR/plug-ins"
TARGET_SCRIPT_DIR="$TARGET_ROOT_DIR/scripts"
if [[ ! -d "$TARGET_ROOT_DIR" ]]
then
    echo "$ERROR"
    echo "Could not find Maya plugin directory on your system."
    echo "Please make sure you are specifying the correct Maya version."
    echo ""
    echo "Expected path:"
    echo "  $WARNSTART$TARGET_ROOT_DIR$COLOREND"
    echo ""
    return 1
fi

if [ ! -d "$TARGET_PLUGIN_DIR" ]; then
  mkdir -p "$TARGET_PLUGIN_DIR";
fi

if [ ! -d "$TARGET_SCRIPT_DIR" ]; then
  mkdir -p "$TARGET_SCRIPT_DIR";
fi

cp "$PLUGIN_FILE" "$TARGET_PLUGIN_DIR/$(basename $PLUGIN_FILE)"
cp "$EXPORT_SCRIPT" "$TARGET_SCRIPT_DIR/$(basename $EXPORT_SCRIPT)"
cp "$OPTS_SCRIPT" "$TARGET_SCRIPT_DIR/$(basename $OPTS_SCRIPT)"

MSG="Installed scripts to $HOME/Library/Preferences/Autodesk/maya/$TARGET_VERSION/ successfully."
echo "$SUCCESS$MSG$COLOREND"