extends KinematicBody2D

export (int) var speed = 200;
export (int) var start_hp : int = 3;
onready var hp := start_hp;
var can_take_damage = true;
onready var animation_player := $AnimationPlayer

export (bool) var clamp_to_window_borders = true;
onready var screen_borders = Vector2(
	ProjectSettings.get_setting("display/window/size/width"),
	ProjectSettings.get_setting("display/window/size/height")
);

func _physics_process(delta):
	# Input
	var velocity := Vector2()
	velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up");
	velocity = velocity.normalized();
	velocity = move_and_slide(velocity * speed);
	
	# Clamp
	if clamp_to_window_borders:
		global_position = Vector2(clamp(global_position.x, 0, screen_borders.x), clamp(global_position.y, 0, screen_borders.y));

func take_damage():
	if (can_take_damage):
		can_take_damage = false;
		hp -= 1;
		animation_player.play("Hit");
	else:
		return;


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Hit":
		can_take_damage = true
		if hp == 0:
			get_tree().change_scene("res://GameOver.tscn"); # Game over
