<?php
error_reporting (E_ALL ^ E_NOTICE);
session_start();

?>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
	<link   href="/IS/css/topnav.css" rel="stylesheet">
</head>
 
<body>
	<?php
	include("../../topnav.php");
	//connect to database
	include('../../connect.php');

	//form to be displayed
	$form ="
<center><h3>Create a record</h3>
                    
    <form action='create-importer.php' method='post'>
		<table>
        	<tr> 
	  			<td>Name</td>
                <td><input name='name' type='text'  required></td>
			</tr>
			<tr>
				<td><input  type='submit' name='create_importer' value='Create'/></td>
                <td><a class='btn' href='/IS/list/importer.php'>Back</a></td>
			</tr>
		</table>

    </form>
</center>";


		//when form is submitted, get all values of each fields
		if($_POST['create_importer']){
			$name = $_POST['name'];

			include('../../connect.php');

			$qry = "SELECT * from Importer where name = '{$name}'";
			$result = $conn->query($qry);
			$data = mysqli_fetch_array($result)['name'];

			if($data){
				echo "<center>Importer name already exists!</center>" . $form;
			}else{
				$qry = "SELECT count(*) as total_no from Importer";
				$result = $conn->query($qry);
				$id = mysqli_fetch_array($result)['total_no'];
				$id++;

			//insert values into the table
				if(!mysqli_query($conn, "INSERT INTO Importer VALUES ('{$id}','{$name}')")){
					echo "Error description: " . mysqli_error($conn) . "<br> $form";
				} else {
					echo "<center>Successfully created a record! </center><br> $form";
				}
			}



			mysqli_close($conn);

		}else{
			echo "$form";
		}

	?>


</body>
</html>
        
