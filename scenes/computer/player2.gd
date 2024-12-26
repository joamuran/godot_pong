class_name Jugador2		# Nom opcional

# Aquest es un script alternatiu per al node Computer. 
# Si en lloc de computer.gd associem aquest, podem jugar a dobles.

extends CharacterBody2D

# Definim variables
var speed=500

# Metode propi del bucle del joc
# Es dispara quan l'escena estiga llesta (apareixera nomes una vegada)
func _ready():
	print("Estic en _ready")
	
#func _process(delta):
	# Aquest metode s'executa una vegada
	# per frame.
	
func _physics_process(delta):
	if not get_parent().get_node("Ball").visible:
		return
		
	# Si no toquem res, la velocitat es 0
	velocity.y=0
	# Es llança cada vegada que s'actualitzen
	# les fisiques (de normal 60 vegades per segon)
	if Input.is_key_pressed(KEY_P):
		velocity.y = -1
	elif Input.is_key_pressed(KEY_L):
		velocity.y = 1
		
	# move and slide -> S'explica al min. 26 del video.
		
	# Multipliquem la velocitat per speed, per ajustar aquesta
	velocity.y *= speed
	
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
	
		
	
