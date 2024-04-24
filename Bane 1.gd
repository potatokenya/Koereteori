extends Control

var score1 = 0

func _ready():
	$Timer.start()
	$resultat.hide()
	$spg.show()


#De rigtige svar
	#Global.score_global =+ 0.5
	#Network._submit_score()
func _on_ov_pressed():
	$click.play()
	print(score1)
	score1 += 0.5
	print(score1)
	$ov.disabled = true
	$resultat/rigtig/r1.set("custom_colors/font_color", Color( 0, 1, 0, 1 ))

func _on_pilh_pressed():
	$click.play()
	print(score1)
	$pilh/lysv2.show()
	score1 += 0.5
	print(score1)
	$pilh.disabled = true
	$resultat/rigtig/r2.set("custom_colors/font_color", Color( 0, 1, 0, 1 ))
	
func _on_ssh_pressed():
	$click.play()
	print(score1)
	score1 += 0.5
	print(score1)
	$ssh.disabled = true	
	$resultat/rigtig/r3.set("custom_colors/font_color", Color( 0, 1, 0, 1 ))

func _on_bremse_pressed():
	$click.play()
	print(score1)
	score1 += 0.5
	print(score1)
	$bremse.disabled = true
	$resultat/rigtig/r4.set("custom_colors/font_color", Color( 0, 1, 0, 1 ))
	
func _on_bakspejl_pressed():
	$click.play()
	print(score1)
	score1 += 0.5
	print(score1)
	$bakspejl.disabled = true
	$resultat/rigtig/r5.set("custom_colors/font_color", Color( 0, 1, 0, 1 ))

func _on_skilt_pressed():
	$click.play()
	print(score1)
	score1 += 0.5
	print(score1)
	$skilt.disabled = true
	$resultat/rigtig/r6.set("custom_colors/font_color", Color( 0, 1, 0, 1 ))


#De forkerte svar
	#Global.score_global =- 0.5
	#Network._submit_score()
func _on_oh_pressed():
	$click.play()
	print(score1)
	score1 -= 0.25
	print(score1)
	$oh.disabled = true
	$resultat/forkert/f1.set("custom_colors/font_color", Color( 1, 0, 0, 1 ))
	

func _on_pilv_pressed():
	$click.play()
	print(score1)
	$pilv/lysv.show()
	score1 -= 0.5
	print(score1)
	$pilv.disabled = true
	$resultat/forkert/f2.set("custom_colors/font_color", Color( 1, 0, 0, 1 ))

func _on_ssv_pressed():
	$click.play()
	print(score1)
	score1 -= 0.25
	print(score1)
	$ssv.disabled = true
	$resultat/forkert/f3.set("custom_colors/font_color", Color( 1, 0, 0, 1 ))

func _on_speed_pressed():
	$click.play()
	print(score1)
	score1 -= 0.5
	print(score1)
	$speed.disabled = true
	$resultat/forkert/f4.set("custom_colors/font_color", Color( 1, 0, 0, 1 ))

func _on_stop_pressed():
	$click.play()
	print(score1)
	score1 -= 0.5
	print(score1)
	$stop.disabled = true
	$resultat/forkert/f5.set("custom_colors/font_color", Color( 1, 0, 0, 1 ))

func _on_gbil_pressed():
	$click.play()
	print(score1)
	score1 -= 0.5
	print(score1)
	$gbil.disabled = true
	$resultat/forkert/f6.set("custom_colors/font_color", Color( 1, 0, 0, 1 ))


func _on_bbil_pressed():
	$click.play()
	print(score1)
	score1 -= 0.5
	print(score1)
	$bbil.disabled = true
	$resultat/forkert/f7.set("custom_colors/font_color", Color( 1, 0, 0, 1 ))


onready var spg = get_node("spg")
var s = 0

func _on__pressed():
	$click.play()
	if s == 0:
		spg.show()
		s = 1
		print(s)
	
	elif s == 1:
		spg.hide()
		s = 0
		print(s)

func _on_Timer_timeout():
	spg.hide()

func customRound(number):
	var integerPart = floor(number)
	var decimalPart = number - integerPart
	if decimalPart < 0.5:
		return integerPart
	else:
		return integerPart + 1

var scoreone = customRound(score1)


func _on_done_pressed():
	$click.play()
	print(score1)
	print(scoreone)
	if score1 < 0:
		Global.score_global = Global.score_global
		Network._submit_score()
	
	if score1 > 0:
		Global.score_global =  Global.score_global + score1
		Network._submit_score() 
	
	#str(int($AddUpLabel.text) + 1)
	
	if score1 == 0:
		Global.score_global = Global.score_global
		Network._submit_score()
	
	Global.score_lvl_1 = scoreone
	#print("score for lvl 1 =" + scoreone + "or" + score1)
	
	$resultat.show()
	
	if score1 >= 0.5 and score1 < 1.5:
		$resultat/stj1.show()
		Global.star_lvl_1 = 1
	
	if score1 >= 1.5 and score1 < 2.5:
		$resultat/stj1.show()
		$resultat/stj2.show()
		Global.star_lvl_1 = 2
	
	if score1 == 2:
		$resultat/stj1.show()
		$resultat/stj2.show()
		Global.star_lvl_1 = 2
	
	if score1 >= 2.5 and score1 == 3:
		$resultat/stj1.show()
		$resultat/stj2.show()
		$resultat/stj3.show()
		Global.star_lvl_1 = 3
		
	print(Global.star_lvl_1)


func _on_afslut_pressed():
	$click.play()
	get_tree().change_scene("res://levelmenu.tscn")
