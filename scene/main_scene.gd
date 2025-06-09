extends Control

@onready var bottom_panel = $BottomPanel
@onready var pop_ui = $PopUI
@onready var portrait_ui = $PortraiUI

func _ready():
	bottom_panel.sig_toggle_popui.connect(_on_toggle_pop_ui)
	bottom_panel.sig_toggle_portrait_ui.connect(_on_toggle_portarit_ui)

func _on_toggle_pop_ui():
	pop_ui.visible = !pop_ui.visible
	
func _on_toggle_portarit_ui():
	portrait_ui.visible = !portrait_ui.visible
