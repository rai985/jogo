extends Enemy

@export var speed: float = 100.0
var player: Node2D = null

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

#encontrar o jogador na cena!!
func _ready():
	super._ready()
	player = get_tree().get_first_node_in_group("Player")
	set_state(State.IDLE)

func _process(delta: float) -> void:
	
	pass

func _physics_process(delta: float) -> void:
	if current_state == State.DEAD:
		return

	if player and is_instance_valid(player):
		var direction = (player.global_position - global_position).normalized()
		if direction.length() > 0.1:
			set_state(State.CHASE)
			velocity = direction * speed
			move_and_slide()
			if anim_sprite.animation != "Chase":
				anim_sprite.play("Chase")
		else:
			set_state(State.IDLE)
			velocity = Vector2.ZERO
			if anim_sprite.animation != "Idle":
				anim_sprite.play("Idle")
	else:
		set_state(State.IDLE)
		velocity = Vector2.ZERO
		if anim_sprite.animation != "Idle":
			anim_sprite.play("Idle")
			
func die():
	set_state(State.DEAD)
	anim_sprite.play("Dead")
	# Aguarda a animação de morte terminar antes de liberar o nó
	await anim_sprite.animation_finished
	super.die()
