# Baseado no roteiro da Aula 09; flip_h adicionado com ajuda de IA (Claude)
extends CharacterBody2D

@export var velocidade: float = 40.0

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(_delta: float) -> void:
	var jogador := get_tree().get_first_node_in_group("player") as Node2D
	if jogador == null:
		return

	velocity = global_position.direction_to(jogador.global_position) * velocidade
	move_and_slide()

	# A aranha olha para o lado em que anda.
	anim.flip_h = velocity.x < 0
