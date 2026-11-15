# Adaptado do roteiro da Aula 08 (personagem de lado, com flip_h), com ajuda de IA (Claude)
extends CharacterBody2D

@export var velocidade: float = 70.0

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(_delta: float) -> void:
	var direcao := Input.get_vector("left", "right", "up", "down")
	velocity = direcao * velocidade
	move_and_slide()

	if direcao == Vector2.ZERO:
		anim.play("parado")
		return

	anim.play("andando")
	if direcao.x < 0:
		anim.flip_h = true
	elif direcao.x > 0:
		anim.flip_h = false
