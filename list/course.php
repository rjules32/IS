<?php
   error_reporting (E_ALL ^ E_NOTICE);
   session_start();
   if($_SESSION['table'] != 'Course'){
   	$_SESSION['page'] = 1;
   }
   $_SESSION['table'] = 'Course';
   ?>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="utf-8">
      <link href="/IS/css/topnav.css" rel="stylesheet">
      <link href="/IS/css/styles.css" rel="stylesheet">
      <script type="text/javascript" src="/IS/js/jquery.min.js"></script>
      <title>Course</title>
   </head>
   <body>
      <div class="pusher">
         <br><br><br><br>
         <div class="ui centered text container">
            <h1 class="ui center aligned header"><i class="list layout icon"></i>COURSE LIST</h1>
            <?php
               include("../topnav.php");
               
               //check if logged in
               // if($_SESSION['isLoggedIn'] == true){
               // 	echo "<a href='create/create-course.php' class='ui primary button'>Create Entry</a>";
               // }	
               
               /*
               *generate table based from selected columns
               *offset - number of last record displayed
               */
               function generateTable($offset){
               
               		include('../connect.php');
               		//get total number of record
               		$totalSql = "SELECT count(*) as total_no from Course";
               		$totalResult = $conn->query($totalSql);
               		$totalRow = mysqli_fetch_array($totalResult);
               		$total_no = $totalRow['total_no'];
               		$noOfPages = ceil($total_no/20);
               
               		//display prev and next button based on the current page
               		$prev = ($_SESSION['page'] > 1)?
               			"<td> <form action='course.php' method='post'><input type='submit' name='prev_table' value='prev'/></form></td>": null;
               		$next = ($_SESSION['page'] < $noOfPages)? "<td> <form action='course.php' method='post'><input type='submit' name='next_table' value='next'/></form></td>" : null;
               
               		// $table = "<center><table>
               		// 			<tr> {$prev} 
               		// 				<td>	Total no. of records: {$total_no}</td>  {$next} 
               		// 			</tr>
               		// 			</table></center>
               		// 		<center><table border='1'>
               		// 			<tr>
               		// 				<th>no.</th>
               		// 				<th>action</th>
               		// 				<th>course_id</th>
               		// 				<th>course_name</th>
               		// 			</tr>";
               		$table = "<div class='ui center aligned container'>{$prev} Total no. of records: {$total_no}  {$next}</div>
               					<table class='ui celled table'>
               						<thead>
               							<tr><th>No.</th>
               							    <th>Action</th>
               							    <th>Course ID</th>
               							    <th>Course Name</th>
               					  		</tr></thead>
               					";
               
               		//get number of first record to be displayed
               		$counter = $offset - 20;
               		$sql = "SELECT * from Course ORDER BY course_id ASC LIMIT 20 OFFSET {$counter}";
               		$result = $conn->query($sql);
               
               		//add action column to the table, i.e., view, edit, and delete actions
               		while($row = mysqli_fetch_array($result)){
               			$counter++;
               			$table .= "<tr><td>{$counter}</td><td>";
               			$table .= '<a href="view/view-course.php?id='.$row['course_id'].'">view</a>';
               			if($_SESSION['isLoggedIn'] == true){
               				$table .=' | <a href="edit/edit-course.php?id='.$row['course_id'].'">edit</a>
               				| <a href="delete/delete-course.php?id='.$row['course_id'].'">delete</a></td>';
               			}
               			$table .= "<td>" . $row['course_id'] . "</td><td>" . $row['course_name'] . "</td></tr>";
               		}
               		$table .= "</table>";
               
               		mysqli_close($conn);
               		return $table;
               }
               
               
                 if($_POST['next_table'] || $_POST['prev_table']){
               if($_POST['next_table']){
               	$_SESSION['page'] ++;
               }
               if($_POST['prev_table']){
               	$_SESSION['page'] --;
               }
               $offset = $_SESSION['page'] * 20;
               
               echo generateTable($offset);
                 }else{
               $offset = $_SESSION['page'] * 20;
               echo generateTable($offset);
               }
               
               //check if logged in
               if($_SESSION['isLoggedIn'] == true){
               echo "<a href='create/create-course.php' class='fluid ui primary button'>Create New Entry</a>";
               }
               ?>
            <br><br>
         </div>
      </div>
   </body>
</html>s