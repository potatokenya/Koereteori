extends Control


# Declare member variables here. Examples:
var http_request : HTTPRequest = HTTPRequest.new()
const SERVER_URL = "http://aceddu.dk/db_test.php"
const SERVER_HEADERS = ["Content-Type: application/x-www-form-urlencoded", "Cache-Control: max-age=0"]
var request_queue : Array = []
var is_requesting : bool = false
var lastCommand = ""
#var username_global = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	add_child(http_request)
	http_request.connect("request_completed",self,"_http_request_completed")
	


func _process(_delta):
	
	if is_requesting:
		return
		
	if request_queue.empty():
		return
		
	is_requesting = true
	_send_request(request_queue.pop_front())
	
	
			
	
func _http_request_completed(_result, _response_code, _headers, _body):
	is_requesting = false
	if _result != http_request.RESULT_SUCCESS:
		printerr("Error w/ connection: " + String(_result))
		return
	
	var response_body = _body.get_string_from_utf8()
	#$TextEdit.set_text(response_body)
	var response = parse_json(response_body)

	#if response['error'] != "none":
	#	printerr("We returned error: " + response['error'])
	#	return
	
	if(lastCommand == "signup"):
		if response['error'] == "none":
			$status.set_text("Ny bruger oprettet")
			$TextEdit.set_text("New user added")
			$pil.show()
			$status.set("custom_colors/font_color", Color( 0, 1, 0, 1 ))

		else:
			$status.set_text("Brugernavn taget")
			$TextEdit.set_text("Username taken")
			$status.set("custom_colors/font_color", Color( 1, 0, 0, 1 ))
			
	if(lastCommand == "login"):
		if response['error'] == "none":
			Global.username_global = $bnli.get_text()
			$TextEdit.set_text("Login succesfull")
			$status.set_text("Login fuldført")
			$status.set("custom_colors/font_color", Color( 0, 1, 0, 1 ))
			$Timer.start()
			
		else:
			Global.username_global = ""
			$TextEdit.set_text("Forkert brugernavn eller kode")
			$status.set_text("Wrong username or password")
			$status.set("custom_colors/font_color", Color( 1, 0, 0, 1 ))
			
	if(lastCommand == "getscore"):
		if response['error'] == "none":
			if response['datasize'] > 0:
				#skriv kode her der håndterer visning af brugerdata 
				#user_score.set_text
				#$UserScore.set_text(String(response['response']['score']))
				#print(String(response['response']['player_name'])  + "\t\t" + String(response['response']['score']))
				#String(parse_json(response['response'])[String(n)]['player_name']) + "\t\t" + String(parse_json(response['response'])[String(n)]['score']) + "\n")
				#_change_scene()
				#$UserScore.set_text(String(response['response']['player_name'])  + "\t\t" + String(response['response']['score']))
				$kort2/point.set_text(String(response['response']['score']))
				$kort2/un.set_text(String(response['response']['player_name']))
				Global.score_global = int($kort2/point.text)
				print(Global.score_global)
		else:
			
			pass



	#if response['datasize'] > 1:
#		$TextEdit.set_text("")
#		for n in response['datasize']:
#			$TextEdit.set_text($TextEdit.get_text() + String(parse_json(response['response'])[String(n)]['player_name']) + "\t\t" + String(parse_json(response['response'])[String(n)]['score']) + "\n")
#	elif response['datasize'] == 1:
#		var response_2 = String(response['response'])
#		response_2 = response_2.replace("{","{\"")
#		response_2 = response_2.replace(":","\":\"")
#		response_2 = response_2.replace(", ","\", \"")
#		response_2 = response_2.replace("}","\"}")
#		$TextEdit.set_text(String(parse_json(response_2)['player_name']) + "\t\t" + String(parse_json(response_2)['score']))
#	else:	
#		$TextEdit.set_text("No data")
	
	
func _send_request(request: Dictionary):
	var client = HTTPClient.new()
	var data = client.query_string_from_dict({"data" : JSON.print(request['data'])})
	var body = "command=" + request['command'] + "&" + data
	
	var err = http_request.request(SERVER_URL, SERVER_HEADERS, false, HTTPClient.METHOD_POST, body)
	
	if err != OK:
		printerr("HTTPRequest error: " + String(err))
		return
		
	#$TextEdit.set_text(body)
	print("Requesting...\n\tCommand: " + request['command'] + "\n\tBody: " + body)
	
	
#func _submit_score():
	#var user_name = $PlayerName.get_text()
	#var score = $Score.get_text()
	#var command = "add_score"
	#var data = {"username" : user_name, "score" : score}
	#request_queue.push_back({"command" : command, "data" : data})
onready var kort = get_node("kort2")
var th = 0
	
func _get_score():
	$click.play()
	lastCommand = "getscore"
	var command = "get_score"
	#var username_global = $PlayerName
	var username = Global.username_global
	#$kort2.show()
	
	var data = {"username" : username}
	request_queue.push_back({"command" : command, "data" : data})
	print("get scores")
	
	if th == 0:
		kort.show()
		th = 1
		print(th)
	
	elif th == 1:
		kort.hide()
		th = 0
		print(th)

#func _get_player():
	#$click.play()
	#var user_id = $ID.get_text()
	#var command = "get_player"
	#var data = {"user_id" : user_id}
	#request_queue.push_back({"command" : command, "data" : data})

func _signup():
	$click.play()
	lastCommand = "signup"
	var user_name = $bnsu.get_text()
	var password = $ksu.get_text()
	var command = "signup"
	var data = {"username" : user_name, "password" : password}
	request_queue.push_back({"command" : command, "data" : data})
	
func _login():
	$click.play()
	lastCommand = "login"
	var user_name = $bnli.get_text()
	var password = $kli.get_text()
	var command = "login"
	var data = {"username" : user_name, "password" : password}
	request_queue.push_back({"command" : command, "data" : data})
	
func _submit_score():
	var user_name =  Global.username_global# $PlayerName.get_text()
	var score = Global.score_global# $Score.get_text()
	var command = "add_score"
	var data = {"username" : user_name, "score" : score}
	request_queue.push_back({"command" : command, "data" : data})
	


#func _change_scene():
	#username_global = "1234"
	#get_tree().change_scene("res://Control.tscn")

func _on_Timer_timeout():
	get_tree().change_scene("res://levelmenu.tscn")


var star1 = Global.star_lvl_1
var star2 = Global.star_lvl_2

func _on_vigepligt_pressed():
	$click.play()
	$lillebil/AnimationPlayer.play("bane 1")
	$Timer1.start()
	#if $lillebil.position == Vector2(681, 562):
		#$lillebil/AnimationPlayer.play("bane 1")
		#$Timer1.start()
	
	#if $lillebil.position == Vector2(536, 296):
		#$lillebil/AnimationPlayer.play("bane 1.1")
		#$Timer1.start()
	
func _on_Timer1_timeout():
	$bane1.show()
	print(Global.star_lvl_1)
	if Global.star_lvl_1 == 1:
		$bane1/s3.show()
	
	if Global.star_lvl_1 == 2:
		$bane1/s3.show()
		$bane1/s2.show()
	
	if Global.star_lvl_1 == 3:
		$bane1/s3.show()
		$bane1/s2.show()
		$bane1/s1.show()
	
	#get_tree().change_scene("res://Bane 1.tscn")

func _on_mellemstop_pressed():
	get_tree().change_scene("res://tekspg.tscn")
	$click.play()


func _on_overhailing_pressed():
	$click.play()
	if $lillebil.position == Vector2(681, 562):
		$lillebil/AnimationPlayer.play("bane 2")
		$Timer2.start()
	if $lillebil.position == Vector2(894, 243):
		$lillebil/AnimationPlayer.play("bane 2.1")
		$Timer2.start()

func _on_Timer2_timeout():
	$bane2.show()
	print(Global.star_lvl_2)
	if Global.star_lvl_2 == 1:
		$bane2/s3.show()
	
	if Global.star_lvl_2 == 2:
		$bane2/s3.show()
		$bane2/s2.show()
	
	if Global.star_lvl_2 == 3:
		$bane2/s3.show()
		$bane2/s2.show()
		$bane2/s1.show()

func _on_close1_pressed():
	$click.play()
	$bane1.hide()

func _on_close2_pressed():
	$click.play()
	$bane2.hide()


func _on_b1_pressed():
	$click.play()
	get_tree().change_scene("res://Bane 1.tscn")
	

func _on_logud_pressed():
	$click.play()
	get_tree().change_scene("res://mainSide.tscn")


func _on_b11_pressed():
	$click.play()
	get_tree().change_scene("res://Bane 2.tscn")


func _on_i_pressed():
	$click.play()
	$help.show()


func _on_close3_pressed():
	$click.play()
	$help.hide()
