@tool
class_name PortraitCard
extends Control

@onready var img = %Img
@onready var first_name = %FirstName
@onready var last_name = %LastName

#func _ready() -> void:
	#first_name.toggle_label_visibility(false) # 留给外部mid_container控制
	#last_name.toggle_label_visibility(false)
