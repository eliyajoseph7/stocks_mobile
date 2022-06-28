<?php
	$db = mysqli_connect("localhost","root","","stocks_db");
	if (!$db) {
		echo "Database Connect Error ";
		// .mysqli_error($db)
	}
?>