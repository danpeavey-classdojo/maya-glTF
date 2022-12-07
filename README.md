# maya-glTF
glTF exporter plugin for Autodesk Maya

# ClassDojo Modifications

This plugin has been adjusted to work specifically with ClassDojo's tech stack. 
This plugin is compatible with most modern versions of Maya.  Tested specifically with Maya 2023.

# Installation

Run `./install.sh` from the root of the repository.


# Note from the original Author

Most of the glTF spec has been implemented, but this is still a work in progress.  For best material results use StingrayPBS shader.


## Old Install Instructions 
| OS | Path |
|---------|----------|
|(Windows)|  `C:/Users/<username>/Documents/maya/<version>/scripts`|  
|(Mac OS X) |`Library/Preferences/Autodesk/maya/<version>/scripts`|  
|(Linux)  |  `$MAYA_APP_DIR/maya/<version>/scripts`|  

- `glTFTranslator.py` from the `plug-ins` folder needs to be copied to the plug-ins folder here (create a plug-ins folder if you don't have one):  

| OS | Path |
|----|-----|
(Windows) | `C:/Users/<username>/Documents/maya/<version>/plug-ins`  
(Mac OS X) |`Library/Preferences/Autodesk/maya/<version>/plug-ins`  
(Linux)   | `$MAYA_APP_DIR/maya/<version>/plug-ins`  

# Usage

### Exporting through the File menu
1. Launch Maya.
1. Open the Plug-in Manager
   - ![Plug-in Manager 1](https://github.com/matiascodesal/maya-glTF/blob/master/doc/images/find-plug-man.PNG)
1. Check on "Loaded" for "glTFTranslator.py" plug-in.
   - ![Plug-in Manager 2](https://github.com/matiascodesal/maya-glTF/blob/master/doc/images/plug-in-man.PNG)
1. Export your scene: 
   - File->Export All...
   - ~~File->Export Selection is not yet implemented~~.
1. Choose "glTF Export" for the "Files of Type" option.
1. Set file-specific options, then click "Export All".


# Exporting from Script
   ```python
   import glTFExport   
   glTFExport.export(r"C:\Temp\test.glb", resource_format='bin', anim='keyed', vflip=True)
   ```

## Export parameters

| Parameter | Description |   
| --------- | ----------- |   
|file_path|Path to export the file to.  File extension should be .glb or .gltf|   
|resource_format| How to export binary data. Only applies to .gltf format.  Valid value: 'bin', 'source', 'embedded'. **bin** - A single .bin file next to the .gltf file. **source** - Images are copied next to the .gltf file. **embedded** - Everything is embedded within the .gltf.|   
|anim|How to deal with animation. Valid values: 'none', 'keyed'.  **none** - Don't export animation. **keyed** - Respect current keys|   
|vFlip|GL renderers want UVs flippedin V compared to Maya.  Set to False if you don't need to fix the flipping.|   

# Current Features
- Export whole scene from Maya
- Exports transform nodes and meshes with hierarchy
- Exports single material shader per mesh currently.
   - Picks the first shader.
- Lambert, Blinn, Phong use a PBR conversion approximation
   - Base color comes from color attribute as texture or value.
   - Metallic and roughness are derived from the other attribute values and do not support textures.
- Recommend StingrayPBS shader for best material conversion.
- Node animation supported for translation, rotation, scale.
- glTF and glb supported
- Options for embedded binary data, single external bin, or preserved external images.
   
