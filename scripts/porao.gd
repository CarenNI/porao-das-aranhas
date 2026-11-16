# Baseado no roteiro da Aula 09 (vila.gd), adaptado para o porão
extends Node2D

@export var cena_inimigo: PackedScene
var abates := 0
var chefe: Node2D = null

@onready var horda: Timer = $Horda
@onready var relogio: Timer = $Relogio
@onready var jogador := $Jogador
@onready var texto_vida: Label = $HUD/Vida
@onready var texto_tempo: Label = $HUD/Tempo


func _process(_delta: float) -> void:
	texto_vida.text = "Vida: %d      Abates: %d" % [jogador.vida, abates]
	if chefe == null:
		texto_tempo.text = "A rainha chega em: %d" % ceil(relogio.time_left)
	elif is_instance_valid(chefe):
		texto_tempo.text = "Rainha: %d de vida" % chefe.vida

func _on_horda_timeout() -> void:
	var inimigo := cena_inimigo.instantiate()
	inimigo.global_position = $Nascedouros.get_children().pick_random().global_position
	add_child(inimigo)

	# A horda aperta: cada aranha chega um pouco mais cedo que a anterior.
	horda.wait_time = max(0.5, horda.wait_time * 0.95)


func _on_relogio_timeout() -> void:
	horda.stop()
	# O tempo acabou: nasce a rainha, a mesma aranha com mais vida e o desenho maior.
	chefe = cena_inimigo.instantiate()
	chefe.vida = 6
	chefe.velocidade = 30.0
	chefe.modulate = Color(1.0, 0.5, 0.5)
	chefe.get_node("AnimatedSprite2D").scale = Vector2(0.08, 0.08)
	chefe.global_position = $Nascedouros/Cima.global_position
	add_child(chefe)


# call_deferred: troca de cena só no fim do quadro, quando a física terminou.
func vencer() -> void:
	get_tree().change_scene_to_file.call_deferred("res://scenes/vitoria.tscn")


func perder() -> void:
	get_tree().change_scene_to_file.call_deferred("res://scenes/derrota.tscn")

func inimigo_morreu(inimigo: Node2D) -> void:
	abates += 1
	if inimigo == chefe:
		vencer()
