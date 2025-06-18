extends Node

var word_entry_res = preload("res://scene/word_entry.tscn")
var clue_text_res = preload("res://scene/clue_text_ui.tscn")
var clue_image_res = preload("res://scene/clue_image_ui.tscn")
var clue_image_and_text_res = preload("res://scene/clue_image_and_text_ui.tscn")
var red_point_res = load("res://scene/red_point.tscn") # 避免编译时和clue_ui循环引用，需要用load
var portrait_card_res = preload("res://scene/portait_card.tscn")
var wave_effect = preload("res://scripts/wave_line_effect.gd") # 富文本波动效果
