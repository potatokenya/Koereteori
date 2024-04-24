    <?php
		function OpenCon()
		{
			$db_host = "mysql113.unoeuro.com";
			$db_name = "aceddu_dk_db";
			$db_username = "aceddu_dk";
			$db_password = "dp34rtace6bBfzRyHw2m";

			#$conn = new mysqli($dbhost, $dbuser, $dbpass,$dbname) or die("Connect failed: %s\n". $conn -> error);
			
			$conn = new mysqli($db_host, $db_username, $db_password,$db_name);
			
			return $conn;
		}
		
		function CloseCon($conn)
		{
			$conn -> close();
		}
    ?>
	