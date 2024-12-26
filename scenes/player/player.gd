class_name Jugador

extends CharacterBody2D

# Definim variables
var speed=500

# Metode propi del bucle del joc
# Es dispara quan l'escena estiga llesta (apareixera nomes una vegada)
# Inicialment, no cal fer res, aixi que la deixem comentada.
# func _ready():
# 	print("Estic en _ready")
	
#func _process(delta):
	# Aquest metode s'executa una vegada
	# per frame.
	# Tampoc l'utilitzem ara
	
func _physics_process(delta):
	
	# Si la pilota no es visible, no ens podem moure
	if not get_parent().get_node("Ball").visible:
		return
	
	# Si no toquem res, la velocitat es 0
	velocity.y=0
	# Es llança cada vegada que s'actualitzen
	# les fisiques (de normal 60 vegades per segon)
	if Input.is_key_pressed(KEY_Q):
		velocity.y = -1
	elif Input.is_key_pressed(KEY_A):
		velocity.y = 1
	
	# Podriem treballar amb un gamepad:	
	#elif Input.get_joy_axis(0, 1) != 0:  # Asumim que el gamepad està en el port 0 i volem l'eix vertical (1)
	#	velocity.y = Input.get_joy_axis(0, 1)
		
	# Multipliquem la velocitat per speed
	velocity.y *= speed
	
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
	
		
	
