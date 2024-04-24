extends Control

var score2 = 0

func _ready():
	$Timer.start()
	$resultat.hide()
	$spg.show()


#De rigtige svar
	#Global.score_global =+ 0.5
	#Network._submit_score()


func _on_pilv_pressed():
	$click.play()
	print(score2)
	$pilv/lysv.show()
	score2 += 1.5
	print(score2)
	$pilv.disabled = true
	$resultat/rigtig/r2.set("custom_colors/font_color", Color( 0, 1, 0, 1 ))
	
func _on_pbil_pressed():
	$click.play()
	print(score2)
	score2 += 1.5
	print(score2)
	$pbil.disabled = true
	$resultat/rigtig/r3.set("custom_colors/font_color", Color( 0, 1, 0, 1 ))

#De forkerte svar
	#Global.score_global =- 0.5
	#Network._submit_score()
func _on_bremse_pressed():
	$click.play()
	print(score2)
	score2 -= 0.5
	print(score2)
	$bremse.disabled = true
	$resultat/forkert/f1.set("custom_colors/font_color", Color( 1, 0, 0, 1 ))
	
func _on_pilh_pressed():
	$click.play()
	print(score2)
	$pilh/lysv2.show()
	score2 -= 0.5
	print(score2)
	$pilh.disabled = true
	$resultat/forkert/f2.set("custom_colors/font_color", Color( 1, 0, 0, 1 ))

func _on_stop_pressed():
	$click.play()
	print(score2)
	score2 -= 0.5
	print(score2)
	$stop.disabled = true
	$resultat/forkert/f3.set("custom_colors/font_color", Color( 1, 0, 0, 1 ))

func _on_ssh_pressed():
	$click.play()
	print(score2)
	score2 -= 0.25
	print(score2)
	$ssh.disabled = true
	$resultat/forkert/f4.set("custom_colors/font_color", Color( 1, 0, 0, 1 ))

func _on_ssv_pressed():
	$click.play()
	print(score2)
	score2 -= 0.25
	print(score2)
	$ssv.disabled = true
	$resultat/forkert/f5.set("custom_colors/font_color", Color( 1, 0, 0, 1 ))

func _on_bakspejl_pressed():
	$click.play()
	print(score2)
	score2 -= 0.5
	print(score2)
	$bakspejl.disabled = true
	$resultat/forkert/f6.set("custom_colors/font_color", Color( 1, 0, 0, 1 ))


func _on_speed_pressed():
	$click.play()
	print(score2)
	score2 -= 0.5
	print(score2)
	$speed.disabled = true
	$resultat/forkert/r1.set("custom_colors/font_color", Color( 1, 0, 0, 1 ))

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
	$spg.hide()

#func customRound(number):
	#var integerPart = floor(number)
	#var decimalPart = number - integerPart
	#if decimalPart < 0.5:
	#	return integerPart
	#else:
	#	return integerPart + 1

#var scoret = customRound(score2)



func _on_done_pressed():
	$click.play()
	print(score2)
	#print(scoret)
	if score2 < 0:
		Global.score_global = Global.score_global
		Network._submit_score()
	
	if score2 > 0:
		Global.score_global = Global.score_global + score2
		Network._submit_score()
	
	if score2 == 0:
		Global.score_global = Global.score_global
		Network._submit_score()
	
	#print("score for lvl 2 =" + scoret + "or" + score2)
	
	Global.score_lvl_2 = score2
	
	$resultat.show()
	
	if score2 >= 0.5 and score2 < 1.5:
		$resultat/stj1.show()
		Global.star_lvl_2 = 1
		print(Global.star_lvl_2)
	
	if score2 >= 1.5 and score2 < 2.5:
		$resultat/stj1.show()
		$resultat/stj2.show()
		Global.star_lvl_2 = 2
		print(Global.star_lvl_2)
	
	if score2 >= 2.5 and score2 == 3:
		$resultat/stj1.show()
		$resultat/stj2.show()
		$resultat/stj3.show()
		Global.star_lvl_2 = 3
		print(Global.star_lvl_2)


func _on_afslut_pressed():
	$click.play()
	get_tree().change_scene("res://levelmenu.tscn")

