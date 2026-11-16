# Baseado no roteiro da Aula 10 (com a "rota mais barata"); flip_h e piscar
# ao apanhar adicionados com ajuda de IA (Claude)
extends CharacterBody2D

@export var velocidade: float = 40.0
@export var vida: int = 1

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var agente: NavigationAgent2D = $NavigationAgent2D


func _ready() -> void:
	# Já nasce sabendo para onde ir, sem esperar o primeiro apito do Timer.
	_on_rota_timeout()


# Recalcula o caminho 5 vezes por segundo, e não a cada quadro.
func _on_rota_timeout() -> void:
	var jogador := get_tree().get_first_node_in_group("player") as Node2D
	if jogador == null:
		return
	agente.target_position = jogador.global_position


func _physics_process(_delta: float) -> void:
	# A cada quadro, só anda até o próximo ponto da rota já calculada.
	var proximo := agente.get_next_path_position()
	velocity = global_position.direction_to(proximo) * velocidade
	move_and_slide()

	# A aranha olha para o lado em que anda.
	anim.flip_h = velocity.x < 0


func levar_golpe() -> void:
	vida -= 1
	if vida <= 0:
		get_tree().current_scene.inimigo_morreu(self)
		queue_free()
		return

	# Apanhou e não morreu: fica meio transparente por 0,1 s.
	modulate.a = 0.4
	await get_tree().create_timer(0.1).timeout
	modulate.a = 1.0
