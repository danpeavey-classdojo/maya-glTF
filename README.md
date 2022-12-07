# maya-glTF
glTF exporter plugin for Autodesk Maya

# ClassDojo Modifications

This plugin has been adjusted to work specifically with ClassDojo's tech stack. 
This plugin is compatible with most modern versions of Maya.  Tested specifically with Maya 2023.

# Installation

1. Clone this repository.
2. In a terminal, open the repository.
3. Run `./install.sh <MAYA_VERSION>` from the root of the repository.

For example, for Maya 2023:
```shell
./install 2023 
```

This presently only supports installation for Mac OS systems, but the scripts work on Windows and Linux as well. [Read this Autodesk Knowledgebase article on how to find the correct folders](https://knowledge.autodesk.com/support/maya/learn-explore/caas/CloudHelp/cloudhelp/2023/ENU/Maya-Customizing/files/GUID-FA51BD26-86F3-4F41-9486-2C3CF52B9E17-htm.html). I also encourage reading the installation script to understand how the scripts are installed.

# Note from the original Author

Most of the glTF spec has been implemented, but this is still a work in progress.  For best material results use StingrayPBS shader.

# Usage

### Exporting through the File menu
1. Launch Maya.
1. Open the Plug-in Manager
   - ![Plug-in Manager 1](https://raw.githubusercontent.com/danpeavey-classdojo/maya-glTF/main/doc/images/find-plug-man.PNG)
1. Check on "Loaded" for "glTFTranslator.py" plug-in.
   - ![Plug-in Manager 2](https://raw.githubusercontent.com/danpeavey-classdojo/maya-glTF/main/doc/images/plug-in-man.PNG)
1. Export your scene: 
   - File->Export All...
   - ~~File->Export Selection~~ Exporting for selections are not yet implemented.
1. Choose "glTF Export" for the "Files of Type" option.
1. Set your filetype specific settings, then click "Export All".

### Filetype Specific Settings

- With the "Default File Extensions" checked, entering an extensionless filename will create a ".glb" file by default.
- The "Resources Format" setting only applies to files explictly named with a ".gltf" extension, and translates to the three different modes supported by that file extension.

# Exporting from Script
   ```python
   import glTFExport   
   glTFExport.export(r"/path/to/test.glb", resource_format='bin', anim='keyed', vflip=True)
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
   
