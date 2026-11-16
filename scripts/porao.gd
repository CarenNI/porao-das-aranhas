# Baseado no roteiro da Aula 09 (vila.gd), adaptado para o porão
extends Node2D

@export var cena_inimigo: PackedScene

@onready var horda: Timer = $Horda


func _on_horda_timeout() -> void:
	var inimigo := cena_inimigo.instantiate()
	inimigo.global_position = $Nascedouros.get_children().pick_random().global_position
	add_child(inimigo)

	# A horda aperta: cada aranha chega um pouco mais cedo que a anterior.
	horda.wait_time = max(0.5, horda.wait_time * 0.95)
