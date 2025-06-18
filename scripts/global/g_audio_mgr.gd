extends Node

var sfx_player: AudioStreamPlayer
var bgm_player: AudioStreamPlayer

func _ready():
	sfx_player = AudioStreamPlayer.new()
	bgm_player = AudioStreamPlayer.new()
	add_child(sfx_player)
	add_child(bgm_player)

func play_click():
	sfx_player.stream = preload("res://asset/music/button_click.wav")
	sfx_player.play()

func play_bgm(path):
	bgm_player.stream = preload("res://asset/music/intermission_machine_audio.ogg")
	bgm_player.loop = true
	bgm_player.play()
