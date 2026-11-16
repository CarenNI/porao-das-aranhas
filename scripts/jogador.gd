# Adaptado dos roteiros das Aulas 08 e 09 (personagem de lado, com flip_h), com ajuda de IA (Claude)
extends CharacterBody2D

@export var velocidade: float = 70.0
@export var vida: int = 3

var invencivel := false
var pode_atacar := true
var atacando := false

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var hurtbox: Area2D = $Hurtbox
@onready var ataque: Area2D = $Ataque
@onready var golpe: ColorRect = $Ataque/Golpe


func _process(_delta: float) -> void:
	# Tem aranha encostando em mim?
	if not invencivel and hurtbox.has_overlapping_bodies():
		levar_dano()

	if pode_atacar and Input.is_action_just_pressed("atacar"):
		atacar()


func _physics_process(_delta: float) -> void:
	var direcao := Input.get_vector("left", "right", "up", "down")
	velocity = direcao * velocidade
	move_and_slide()
# Enquanto ataca, a animação de ataque não é trocada pela de andar.
	if atacando:
		return

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
	
func atacar() -> void:
	# Acerta toda aranha que estiver dentro do círculo neste quadro.
	for inimigo in ataque.get_overlapping_bodies():
		inimigo.levar_golpe()

	# Toca a animação de ataque; o clarão dura 0,1 s e o próximo golpe sai 0,4 s depois.
	pode_atacar = false
	atacando = true
	anim.play("atacar")
	golpe.visible = true
	await get_tree().create_timer(0.1).timeout
	golpe.visible = false
	await get_tree().create_timer(0.3).timeout
	atacando = false
	pode_atacar = true
