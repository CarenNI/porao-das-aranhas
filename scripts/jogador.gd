# Adaptado dos roteiros das Aulas 08 e 09 (personagem de lado, com flip_h), com ajuda de IA (Claude)
extends CharacterBody2D

@export var velocidade: float = 70.0
@export var vida: int = 3

var invencivel := false

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var hurtbox: Area2D = $Hurtbox


func _process(_delta: float) -> void:
	# Tem aranha encostando em mim?
	if not invencivel and hurtbox.has_overlapping_bodies():
		levar_dano()


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


func levar_dano() -> void:
	vida -= 1
	if vida <= 0:
		get_tree().current_scene.perder()
		return

	# Um segundo de invencibilidade, meio transparente.
	invencivel = true
	modulate.a = 0.4
	await get_tree().create_timer(1.0).timeout
	modulate.a = 1.0
	invencivel = false
