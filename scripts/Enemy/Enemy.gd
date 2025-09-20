extends CharacterBody2D
class_name Enemy

enum State { IDLE, CHASE, ATTACK, DEAD }

@export var max_health: int = 100
var current_health: int
var current_state: State = State.IDLE

func _ready():
	current_health = max_health

func take_damage(amount: int):
	current_health -= amount
	if current_health <= 0:
		die()

func die():
	queue_free() # Remove o inimigo da cena

func set_state(new_state: State):
	current_state = new_state
