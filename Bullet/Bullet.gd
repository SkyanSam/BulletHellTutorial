extends Area2D

export (float) var speed = 200;
export (float) var lifetime = 10.00;
export (Vector2) var velocity = Vector2();
export (bool) var use_velocity; # If true use velocity, if false use rotation
export (float) var rotation_change;

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start(lifetime);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if use_velocity:
		position += velocity.normalized() * speed * delta;
	else:
		position += Vector2(cos(rotation), -sin(rotation)) * speed * delta;
	
	rotation_degrees += rotation_change * delta;


func _on_Timer_timeout():
	queue_free();


func _on_Bullet_body_entered(body):
	if body.name == "Player":
		body.take_damage();
