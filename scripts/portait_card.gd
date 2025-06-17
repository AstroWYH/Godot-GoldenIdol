@tool
class_name PortraitCard
extends Control

@onready var img = %Img
@onready var first_name = %FirstName
@onready var last_name = %LastName

func _ready() -> void:
	first_name.toggle_label_visibility(false)
	last_name.toggle_label_visibility(false)
