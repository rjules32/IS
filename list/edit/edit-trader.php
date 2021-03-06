<?php
error_reporting (E_ALL ^ E_NOTICE);
session_start();

?>


<!DOCTYPE html>
<html lang="en">
<head>
	<link   href="/IS/css/topnav.css" rel="stylesheet">
    <meta charset="utf-8">
</head>

<body>

   <?php
		include("../../topnav.php");

		/*
		*generate forms
		*@params - too many parameters, planning to insert them into an array instead
		*parameters are columns of the table
		*/
		function generateForm($id, $name){

			include('../../connect.php');



			return "<center><h3>Edit a record</h3>
		<form action = 'edit-trader.php?id=$id' method='post'>
		<table>
        	<tr> 
	  			<td>Name</td>
                <td><input name='new_name' type='text'  value='".$name."' required></td>
			</tr>
			<tr>
				<td><input  type='submit' name='edit_trader' value='Save'/></td>
                <td><a class='btn' href='/IS/list/trader.php'>Back</a></td>
			</tr>
		</table> </form></center>";
		}

		//get cpr_no of selected record from the generated table
		$id = null;
		if ( !empty($_GET['id'])) {
			$id = $_REQUEST['id'];
		}
		if($id == null){
			header("Location: /IS/list/trader.php");
		}else{
			include('../../connect.php');

			//get current values
			$sql = "SELECT * from Trader WHERE trader_no = '{$id}'";
			$result = $conn->query($sql);
			$row = mysqli_fetch_array($result);
			$curr_name = $row['name'];

			mysqli_close($conn);
		}

		//when form is submitted or saved, record will be updated with new values
		if($_POST['edit_trader']){
			//get new values
			$new_name = $_POST['new_name'];

			include('../../connect.php');

			//update record

			$qry = "SELECT * from Trader where name = '{$new_name}'";
			$result = $conn->query($qry);
			$data = mysqli_fetch_array($result)['name'];

			if($data){
				echo "<center>Trader name already exists!</center>" . generateForm($id, $curr_name);
			}else{
				if(!mysqli_query($conn, "UPDATE Trader SET name = '{$new_name}'
					WHERE trader_no = '{$id}'")){
				echo "Error description: " . mysqli_error($conn) . "<br>". generateForm($id, $new_name);

				} else {
				//echo updated form
					echo "Successfully edited a record! <br/>" . generateForm($id, $new_name);
				}
				mysqli_close($conn);
			}
		} else{
			echo  generateForm($id, $curr_name);
		}
	?>

  </body>
</html>
