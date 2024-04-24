    <?php
		include 'db_connection_test.php';
		
		#Returns information and data to Godot
		function print_response($datasize, $dictionary = [], $error = "none"){
			$string = "{\"error\" : \"$error\",
						\"command\" : \"$_REQUEST[command]\",
						\"datasize\" : $datasize,
						\"response\" : ". json_encode($dictionary) ."}";
						
			#Print out json to Godot
			echo $string;
		}
		
		
		#Handle error: 
		#Missing command
		if (!isset($_REQUEST['command']) or $_REQUEST['command'] === null){
			//print_response([], "missing_command");
			echo "{\"error\":\"missing_command\",\"response\":{}}";
			die;
		}
		
		#Missing data
		if (!isset($_REQUEST['data']) or $_REQUEST['data'] === null){
			print_response([], "missing_data");
			die;
		}
		
		
		
		#Convert Godot json to dictionary
		$dict_from_json = json_decode($_REQUEST['data'], true);
		#var_dump($dict_from_json);
		#echo $dict_from_json["score"];
		#die;
		
		#Is dictionary valid
		if ($dict_from_json === null){
			print_response([], "invalid_json");
			die;
		}
		
		switch ($_REQUEST['command']){
			
            
            
            #Login user
            case "login":
            
            	#Handle error for signup
				if (!isset($dict_from_json['password'])){
					print_response([], "missing_password");
					die;
				}
								
				if (!isset($dict_from_json['username'])){
					print_response([], "missing_username");
					die;
				}
            
            	# Username max length 40, -> should be handled in Godot
				$username = $dict_from_json['username'];
				if (strlen($username) > 40)
					$username = substrt($username, 40);
				
				$password = $dict_from_json['password'];
            
            	#Make a connection to the DB
				$conn = OpenCon();
				
				// Check connection
				if ($conn->connect_error) {
					print_response("0", [], "db_login_error");
					die();
				}
            
            	$sql = "SELECT player_name FROM players where player_name = ? and password = ?;";
			
				// prepare and bind
				$stmt = $conn->prepare($sql);
				#s:string, i:integer, d:decimal(float), b:blob
				$stmt->bind_param("ss", $username, $password);
				
				#DB call 
				$stmt->execute();
				
				$result = $stmt->get_result();
				$player = $result->fetch_array(MYSQLI_ASSOC);
				
            	if($player == null){
					print_response("0", [], "username or password is wrong");
                	}
            	else{
					#Response to Godot, all is fine
					print_response("0", []);
				}
            
                $result->close();
            	$stmt->close();
            	CloseCon($conn);
            
            break;
            
            
            #Signup new user
            case "signup":
            
            	#Handle error for signup
				if (!isset($dict_from_json['password'])){
					print_response([], "missing_password");
					die;
				}
								
				if (!isset($dict_from_json['username'])){
					print_response([], "missing_username");
					die;
				}
            
            	# Username max length 40, -> should be handled in Godot
				$username = $dict_from_json['username'];
				if (strlen($username) > 40)
					$username = substrt($username, 40);
				
				$password = $dict_from_json['password'];
            
            	#Make a connection to the DB
				$conn = OpenCon();
				
				// Check connection
				if ($conn->connect_error) {
					print_response("0", [], "db_login_error");
					die();
				}
            
            	$sql = "SELECT player_name FROM players where player_name = ?;";
			
				// prepare and bind
				$stmt = $conn->prepare($sql);
				#s:string, i:integer, d:decimal(float), b:blob
				$stmt->bind_param("s", $username);
				
				#DB call 
				$stmt->execute();
				
				$result = $stmt->get_result();
				$player = $result->fetch_array(MYSQLI_ASSOC);
            	$result->close();
            	$stmt->close();	
				
            	if($player == null){
					$sql = "INSERT INTO players (player_name, password) VALUES (?, ?);";
                  	// prepare and bind
					$stmt = $conn->prepare($sql);
					#s:string, i:integer, d:decimal(float), b:blob
					$stmt->bind_param("ss", $username, $password);
                  
                  	#DB call 
					$stmt->execute();
				
					#Close statement and connection
					$stmt->close();				
					CloseCon($conn);
				
					#Response to Godot, all is fine
					print_response("0", []);
					}
            	else{
                  	CloseCon($conn);
					print_response("0", [], "username taken");
					die();
				}
            
            break;
            
            
			#Adding score
			case "add_score":
				
				#Handle error for add score
				if (!isset($dict_from_json['score'])){
					print_response([], "missing_score");
					die;
				}
								
				if (!isset($dict_from_json['username'])){
					print_response([], "missing_username");
					die;
				}
				
				# Username max length 40, -> should be handled in Godot
				$username = $dict_from_json['username'];
				if (strlen($username) > 40)
					$username = substrt($username, 40);
				
				$score = $dict_from_json['score'];
				
				#$template = "INSERT INTO `players` (player_name, score) VALUES (:username, :score) ON DUPLICATE
				#KEY UPDATE score = GREATEST(score, VALUES(score))";
		
				#$sql = "INSERT INTO `players` (player_name, score) VALUES (\"". $username ."\", ". $score .") ON DUPLICATE
				#KEY UPDATE score = GREATEST(score, VALUES(". $score . "))";

				#Make a connection to the DB
				$conn = OpenCon();
				
				// Check connection
				if ($conn->connect_error) {
					print_response("0", [], "db_login_error");
					die();
				}
				
				#Create sql to pass to DB
				$sql = "INSERT INTO players (player_name, score) VALUES (?, ?) ON DUPLICATE
				KEY UPDATE score = GREATEST(score, VALUES(score));";
				
				// prepare and bind
				$stmt = $conn->prepare($sql);
				#s:string, i:integer, d:decimal(float), b:blob
				$stmt->bind_param("si", $username, $score);
				
				
				#DB call 
				$stmt->execute();
				
				#Close statement and connection
				$stmt->close();				
				CloseCon($conn);
				
				#Response to Godot, all is fine
				print_response("0", []);
				die;
				
			break;
			
			case "get_score":
			
				if (!isset($dict_from_json['username'])){
					print_response([], "missing_username");
					die;
				}
            
				$username = $dict_from_json['username'];
				
				#Make a connection to the DB
				$conn = OpenCon();
				
				// Check connection
				if ($conn->connect_error) {
					print_response([], "db_login_error");
					die();
				}
			
				$sql = "SELECT player_name, score FROM players where player_name = ?;";
			
				// prepare and bind
				$stmt = $conn->prepare($sql);
				#s:string, i:integer, d:decimal(float), b:blob
				$stmt->bind_param("s", $username);
				
				#DB call 
				$stmt->execute();
				
				$result = $stmt->get_result();
				$player = $result->fetch_array(MYSQLI_ASSOC);
				
				#Close result, statement and connection
				$result->close();
				$stmt->close();				
				CloseCon($conn);
				
            	
				$datasize = 1;
            	if(empty($player)) $datasize = 0;
				
				print_response($datasize, $player);
				die;
			
			
			break;
			
			case "get_player":
			
				#Handle missing user id
				if (!isset($dict_from_json['user_id'])){
					print_response([], "missing_user_id");
					die;
				}
				
				# Username max length 40, -> should be handled in Godot
				$user_id = $dict_from_json['user_id'];
				#$user_id = 1;
				
				#Make a connection to the DB
				$conn = OpenCon();
				
				// Check connection
				if ($conn->connect_error) {
					print_response([], "db_login_error");
					die();
				}				
			
				$sql = "SELECT * FROM players WHERE id = ?;";
			
				// prepare and bind
				$stmt = $conn->prepare($sql);
				#s:string, i:integer, d:decimal(float), b:blob
				$stmt->bind_param("i", $user_id);
				
				#DB call 
				$stmt->execute();
				
				$result = $stmt->get_result();
				$player = $result->fetch_array(MYSQLI_ASSOC);
				
				#Close result, statement and connection
				$result->close();
				$stmt->close();				
				CloseCon($conn);
				
				$datasize = sizeof($player);
				if ($datasize > 0) $datasize = 1;
				
				#$player["size"] = sizeof($player);
				
				
				print_response($datasize, $player);
				die;
			
			
			break;
				
			
			
			#Handle none excisting request
			default:
				print_reaponse([], "invalide_command");
				die;
			break;
		}

    ?>