# Snake River Dialogue Editor
Snake River Dialogue Editor is a nodegraph tool for editing dialogue.

## Features

Nodes are composed of sets of fields. These fields can be any data type which is implemented (currently including strings, ints, floats, arrays.)

Node's field composition can be saved as a 'template' to be reused.

Dialogue files are saved as readable JSON. They can, naturally, be used in any engine. For an example written in Godot, see [this repository.](https://github.com/genderfreak/snake-river-dialogue-parser-example)

Since you are writing the parser, integrating Lua scripting is possible by having a 'Lua' field in your node.

This app should be used with caution and careful version control. Many quality of life features such as autosaving, save precautions, and certain features are still buggy. You should save often. Report bugs to the issue tracker so I can triage them and make the app better.
