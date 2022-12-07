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
if [[ ! $TARGET_VERSION =~ ^2{1}0{1}[0-9]{2}$ ]]
then 
  echo "$ERROR"
  echo Expecting a maya version number, such as \"2023\".
  echo ""
  return 1
fi

TARGET_PLUGIN_DIR="$HOME/Library/Preferences/Autodesk/maya/$TARGET_VERSION/plug-ins"
TARGET_SCRIPT_DIR="$HOME/Library/Preferences/Autodesk/maya/$TARGET_VERSION/scripts"
if [[ ! -d "$TARGET_PLUGIN_DIR" ]] || [[ ! -d "$TARGET_SCRIPT_DIR" ]]
then
    echo "$ERROR"
    echo "Could not find Maya plugin directory on your system."
    echo "Please make sure you are specifying the correct Maya version."
    echo ""
    echo "Expected paths:"
    echo "  $WARNSTART$TARGET_PLUGIN_DIR"
    echo "  $TARGET_SCRIPT_DIR$COLOREND"
    echo ""
    return 1
fi

cp "$PLUGIN_FILE" "$TARGET_PLUGIN_DIR/$(basename $PLUGIN_FILE)"
cp "$EXPORT_SCRIPT" "$TARGET_SCRIPT_DIR/$(basename $EXPORT_SCRIPT)"
cp "$OPTS_SCRIPT" "$TARGET_SCRIPT_DIR/$(basename $OPTS_SCRIPT)"

MSG="Installed scripts to $HOME/Library/Preferences/Autodesk/maya/$TARGET_VERSION/ successfully."
echo "$SUCCESS$MSG$COLOREND"