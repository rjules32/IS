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
		<form action = 'edit-course.php?id=$id' method='post'>
		<table>
        	<tr> 
	  			<td>Course ID</td>
                <td><input name='id' type='text'  value='".$id."' disabled></td>
			</tr>
        	<tr> 
	  			<td>Name</td>
                <td><input name='new_name' type='text'  value='".$name."' required></td>
			</tr>
			<tr>
				<td><input  type='submit' name='edit_course' value='Save'/></td>
                <td><a class='btn' href='/IS/list/course.php'>Back</a></td>
			</tr>
		</table> </form></center>";
		}

		//get cpr_no of selected record from the generated table
		$id = null;
		if ( !empty($_GET['id'])) {
			$id = $_REQUEST['id'];
		}
		if($id == null){
			header("Location: /IS/list/course.php");
		}else{
			include('../../connect.php');

			//get current values
			$sql = "SELECT * from Course WHERE course_id = '{$id}'";
			$result = $conn->query($sql);
			$row = mysqli_fetch_array($result);
			$curr_name = $row['course_name'];

			mysqli_close($conn);
		}

		//when form is submitted or saved, record will be updated with new values
		if($_POST['edit_course']){
			//get new values
			$new_name = $_POST['new_name'];

			include('../../connect.php');

			//update record

			$qry = "SELECT * from Course where course_name = '{$new_name}'";
			$result = $conn->query($qry);
			$data = mysqli_fetch_array($result)['course_name'];

			if($data){
				echo "<center>Course name already exists!</center>" .generateForm($id, $curr_name);
			}else{
				if(!mysqli_query($conn, "UPDATE Course SET course_name = '{$new_name}'
					WHERE course_id = '{$id}'")){
				echo "Error description: " . mysqli_error($conn) . "<br>". generateForm($id, $new_name);

				} else {
				//echo updated form
					echo "<center>Successfully edited a record!</center> <br/>" . generateForm($id, $new_name);
				}
				mysqli_close($conn);
			}
		} else{
			echo  generateForm($id, $curr_name);
		}
	?>

  </body>
</html>
