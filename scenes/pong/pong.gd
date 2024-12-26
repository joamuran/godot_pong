extends Node2D		# L'escena principal del joc te com a arrel un node 2D

const MAX_SCORE = 5 # Punts necessaris per guanyar

var center 			# Centre de la pantalla. L'assignem en el ready

# Puntuacions
var player_score = 0
var computer_score = 0

func _ready():
	# Calculem el centre de la pantalla
	var viewport_size=get_viewport().size
	center = Vector2(viewport_size.x/2, viewport_size.y/2) # Centre de la pantalla
	
	# Connecta el senyal 'pressed' del botó al mètode _on_BotoReinici_pressed
	# Per a aixo fem us de Callable(objecte, funcio)
	$BotoReinici.connect("pressed", Callable(self, "_on_BotoReinici_pressed"))
	
		
func _on_paret_esquerra_body_entered(body):
	# Funció que s'executa quan la pilota col·lisiona amb la paret esquerra
	
	# Quan es detecta una col·lissio de qualsevol objecte amb la paret esquerra, 
	# es dispara l'event body_entered. Aquest event l'hem connectat a traves
	# d'una senyal a aquesta funcio. 
	
	# body es l'objecte que ha col·lissionat amb la paret
	if body.name != "Ball": return # Ignora altres col·lisions
	print("Col·lisió detectada a la paret esquerra amb:", body.name)
	computer_score += 1
	$PuntsOrdinador.text = str(computer_score)
	check_winner()
	reset()

func _on_paret_dreta_body_entered(body):
	# Funció que s'executa quan la pilota col·lisiona amb la paret dreta
	if body.name != "Ball": return # Ignora altres col·lisions
	print("Col·lisió detectada a la paret dreta amb:", body.name)
	player_score += 1
	$PuntsJugador.text = str(player_score)
	check_winner()
	reset()

func _pausa(ms):
	# Funcio auxiliar que crea una pausa 
	# fent us d'un temporitzador
	var timer = Timer.new() # Creem un temporitzador (timer)
	timer.wait_time = ms	# Establim el temps d'espera (wait_time)
	timer.one_shot = true	# Assegurem que siga d'us unic
	add_child(timer)		# Afegim el temporitzador a l'escena
	timer.start()			# Iniciem el temporitzador
	await timer.timeout		# Esperem que el temporitzador acabe
	

func reset():
# Reinicia la posició de la pilota i els jugadors
	if $Ball.visible:
		$Ball.position = center
		$Player.position.y = center.y
		$Computer.position.y = center.y
		$Ball.visible = false
		# Esperem mig segon
		await _pausa(0.5)
		$Ball.visible = true
		$Ball.call("set_ball_velocity")
	
func check_winner():
	# Comprova si algun jugador ha arribat al màxim de punts
	if player_score >= MAX_SCORE:
		show_game_over_message("[center]GUANYA EL JUDADOR 1![/center]")
	elif computer_score >= MAX_SCORE:
		show_game_over_message("[center]GUANYA EL JUGADOR 2![/center]")


func show_game_over_message(message):
	# Mostra el missatge de final de partida i el botó de reinici
	$EtiquetaGameOver.text = message
	$EtiquetaGameOver.visible = true
	$BotoReinici.visible = true
	$Ball.visible=false
	

func _on_BotoReinici_pressed():
	# Reinicia la partida completament
	print("Restart pressed")
	player_score = 0
	computer_score = 0
	$PuntsJugador.text = "0"
	$PuntsOrdinador.text = "0"
	$EtiquetaGameOver.visible = false
	$BotoReinici.visible = false
	$Ball.visible=true
	reset()
