# Snake River Dialogue Editor
Snake River Dialogue Editor is a Nodegraph based tool for creating branching dialogue flows. Snake River is different from other dialogue editors—it is opinionated, but completely system or style agnostic. Any node can have any arbritrary number of fields, including text, integers, nulls, and booleans. This is different from other free dialogue editors in the sense that you can write scripted game text for any function without having any extraneous features forced upon you. Don't need a "speaker" or "character" field for your content? That's fine, you won't have that forced on you. Need a piece of content to be assigned a number? That's not only possible but easily doable, just add an integer field.

Dialogue files are saved as readable JSON. You can immediately use them in any engine, you just have to write your own parser. This can be as simple as `print(node[fields][content]); node = node[output][0]; repeat` (this is pseudocode!) or as complex as you need it to be. You write the rules, you create the schema, you make your dialogue system. This allows for you to be creative when making dialogue mechanics, while still having an editor handy.

You can save nodes as templates! Need a node that is just for basic, untagged content? Create a node with a text field with the key "content," right click it, save as a template. Now you have a template for any vanilla dialogue node. Need a speaker, and a voice line ID? Add a field with "speaker" and "voiceID", then save that as a template.

Want your dialogue to execute code? Add a field, label it "lua", and add a Lua plugin to your engine of choice.

This app is a proof of concept and an Alpha—it requires further development to be considered for serious usage, and the JSON schema may change. I am mostly writing this editor for my own reasons, but I genuinely know of *nothing* on the market like this, and especially not for Linux.
