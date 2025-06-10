extends PanelContainer

@onready var fill_story : RichTextLabel = %FillStory

func _ready() -> void:
	fill_story.bbcode_enabled = true
	fill_story.meta_clicked.connect(_on_meta_clicked)
	fill_story.add_theme_color_override("default_color", Color.WHITE)
	
func _on_meta_clicked():
	print('on meta clicked')
