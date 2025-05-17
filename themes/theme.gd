@tool
extends ProgrammaticTheme

var background_color = Color("#FFF")
var node_color = Color("#FAE3E3", 0.7)
var node_color_selected = Color("#F9F9F9", 0.7)
var solid_color = Color("#6276A3")
var accent_color = Color("#F45B69")
var text_color = Color("#111")

func setup():
	set_save_path("res://themes/theme.tres")

func define_theme():
	define_default_font(load("res://themes/fonts/Cabin/Cabin-VariableFont_wdth,wght.ttf"))
	define_default_font_size(18)
	#
	#define_style("Label", {
		#font_color = text_color
	#})
	#define_style("GraphEdit", {
		#panel = stylebox_flat({
			#bg_color = background_color,
		#}),
		#grid_major = Color.WEB_GRAY,
		#grid_minor = Color.GRAY
	#})
	#define_style("GraphNode", {
		#panel = stylebox_flat({
			#bg_color = node_color,
			#corner_ = corner_radius(0,0,8,8),
			#content_ = content_margins(8)
		#}),
		#panel_selected = stylebox_flat({
			#bg_color = node_color + Color("#111"),
			#corner_ = corner_radius(0,0,8,8),
			#content_ = content_margins(8)
		#}),
		#titlebar = stylebox_flat({
			#bg_color = accent_color,
			#corner_ = corner_radius(8,8,0,0),
			#content_ = content_margins(8,8,8,0)
		#}),
		#titlebar_selected = stylebox_flat({
			#bg_color = accent_color + Color("#111"),
			#corner_ = corner_radius(8,8,0,0),
			#content_ = content_margins(8,8,8,0)
		#})
	#})
