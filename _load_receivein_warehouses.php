<?php
include 'config.php';


$created_at = $_POST['created_at'];
$id = $_POST['id'];
$date = $_POST['date'];
$trader_id = $_POST['trader_id'];
$quality = $_POST['quality'];
$buying_price = $_POST['buying_price'];
$quantity = $_POST['quantity'];
$source = $_POST['source'];
$crop_id = $_POST['crop_id'];
$warehouse_id = $_POST['warehouse_id'];
$village_id = $_POST['village_id'];
$ward_id = $_POST['ward_id'];
$district_id = $_POST['district_id'];
$region_id = $_POST['region_id'];
$origin_warehouse = $_POST['origin_warehouse'];
$origin_market = $_POST['origin_market'];
$cess_payment = $_POST['cess_payment'];
$updated_at = $_POST['updated_at'];

//receivein_warehouses table


$selectExits = $db->query("SELECT * FROM receivein_warehouses WHERE id = '".$id."' AND trader_id = '".$trader_id."' ");

$count = mysqli_num_rows($selectExits);
if($count > 0){
	$result = $db->query("UPDATE receivein_warehouses SET name = '".$name."', email = '".$email."', gender = '".$gender."', created_at = '".$created_at."' WHERE contact_id = '".$contact_id."' AND user_id = '".$user_id."' ");
	if ($result) {
		echo json_encode(array("message"=>"UPDATE Success"));
	}else{
		echo json_encode(array("message"=>"UPDATE failed ".mysqli_errno($db)));
	}
}else{
	$result = $db->query(" INSERT INTO receivein_warehouses(contact_id,user_id,name,email,gender,created_at)VALUES('".$contact_id."','".$user_id."','".$name."','".$email."','".$gender."','".$created_at."') ");
	if ($result) {
		echo json_encode(array("message"=>"INSERT Success"));
	}else{
		echo json_encode(array("message"=>"INSERT failed ".mysqli_errno($db)));
	}
}

?>