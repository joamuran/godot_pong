class_name Computer			# Aixi podem donar un nom a la classe (opcional)

extends CharacterBody2D		# El node principal es un CharacterBody2D

# Definim variables globals (propietats de la classe)
var speed=250				# Velocitat inicial (anira creixent per incrementar la dificultat)
var max_speed=500			# Velocitat maxima
var ball 					# Referencia a la pilota

# Metode propi del bucle del joc
# Es dispara quan l'escena estiga llesta (apareixera nomes una vegada)
func _ready():
	# Obtenim una referencia a la pilota a traves del node pare
	ball=get_parent().get_node("Ball")
	
#func _process(delta):
	# Aquest metode s'executa una vegada
	# per frame. No l'utilitzarem
	
func _physics_process(delta):
	# Si la pilota no es visible, no fem res
	if not ball.visible:
		return
		
	# Ara movem la pala segons la posicio de la pilota
	if ball.position.y < position.y:
		velocity.y=-1
	else:
		velocity.y=1
		
	velocity *=speed
	
	# Incrementem la velocitat de la paleta, per anar incrementatn la dificultat
	if (speed<max_speed):
		speed=speed+0.01

	# Opcio 1: move_and_slide
	# Invoquem a move_and_slide
	# Aquest metode el que fa es moure el node, 
	# en funcio de la seua velocitat
	# A mes, si detecta una col·lissio, calcula un 
	# vector per seguir movent-se pe la superficie 
	# de contacte
	# move_and_slide()
	
	# Opcio 2. move_and_collide
	# Quan detecta la col·lissio, atura l'objecte
	# i ens dona informacio sobre la col·lissio
	# Aquest depen de delta, per ser independent del framerate
	
	move_and_collide(velocity * delta)
