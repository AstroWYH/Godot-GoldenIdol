extends Node

var bgm_player: AudioStreamPlayer
var se_player: AudioStreamPlayer

func _ready():
	se_player = AudioStreamPlayer.new()
	bgm_player = AudioStreamPlayer.new()
	add_child(se_player)
	add_child(bgm_player)

# 背景音乐
func play_bgm(chapter: int):
	bgm_player.stream = GPreload.get_bgm_res(chapter)
	bgm_player.loop = true
	bgm_player.play()

# 音效
func play_se(type: String):
	se_player.stream = GPreload.get_se_res(type)
	se_player.play()
