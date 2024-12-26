extends CharacterBody2D		# Script per controlar la pilota. Es un CharacterBody2D

var speed=400				# Velocitat inicial de la pilota

func _ready():
	# Aquest metode s'invoca nomes una vegada, quan la pilota s'insereix a l'escena
	set_ball_velocity()
	
func set_ball_velocity():
		# Calculem un enter aleatori. Si es parell el moviment
	# sera cap a un costat, i si es imparell a l'altre
	if randi() % 2 ==0:
		velocity.x=1
	else:
		velocity.x=-1
		
	if randi() % 2 ==0:
		velocity.y=1
	else:
		velocity.y=-1

	velocity *= speed

func _physics_process(delta):
	# Nomes movem la pilota si es visible (self es la propia pilota)
	if not self.visible:
		return
	# A cada actualitzacio de les fisiques, desplacem la pilota
	# fins que trobe una col·lissio.
	# Quan troba una col·lissio, la funcio move_and_collide ens
	# torna un objecte de tipus KinematicCollision2D amb la informacio d'aquesta
	var info_colissio=move_and_collide(velocity*delta)

	if info_colissio:
		# Fem us del metode bounce del vector velocitat, proporcionant-li
		# la component normal de la col·lissio.
		velocity=velocity.bounce(info_colissio.get_normal())
		
