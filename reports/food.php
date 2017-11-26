<?php
error_reporting (E_ALL ^ E_NOTICE);
session_start();
$_SESSION['table'] = 'Food';
$_SESSION['graph_type'] = null;
?>



<!DOCTYPE html>

<html>
<head>
  <meta charset="utf-8">
  <link href="/IS/css/topnav.css" rel="stylesheet">
  <link href="/IS/css/styles.css" rel="stylesheet">
  <script type="text/javascript" src="/IS/js/jquery.min.js"></script>
  <script type="text/javascript" src="/IS/js/Chart.min.js"></script>
  <?php
  //function setBarScript(){
    //switch($_SESSION['selected'])
  //}
  ?>
  <title>Food Products Report</title>
</head>
<body>
  <?php
    include("../topnav.php");
    if($_SESSION['isLoggedIn'] == true){
      echo "<p> <a href='../create/create-food.php'>Create</a></p>";
    }
    $arrColValues = array('cpr_no','dr_no','country','rsn','validity_date','food_name','manufacturer','trader','distributor');
    $arrColLabels = array('CPR No.','DR No.','Country','RSN','Validity Date','Name','Manufacturer','Trader','Distributor');

    function generateForm($arrColValues, $arrColLabels){
			$form="<center><div> <form action='food.php' method='post'>";

			for($i = 0; $i < count($arrColValues); $i++){
				for($j = 0; $j < count($_SESSION['arrCheckedVals']); $j++){
					if($_SESSION['arrCheckedVals'][$j] == $arrColValues[$i]){
						$isChecked = 'checked';
						break;
					}else{
						$isChecked = null;
					}
				}
				$form .= "<input type='checkbox' name='check_list[]' value='{$arrColValues[$i]}' id='cbox_columns' $isChecked>{$arrColLabels[$i]}</input>";
			}
			$form .= " <input type='submit' name='generate' value='Generate'/></form></div></center>";
			return $form;
		}
    function generateTable($arrCheckBox, $offset){

				include('../connect.php');

				//get total number of record
				$totalSql = "SELECT count(*) as total_no from Food WHERE cpr_no NOT IN ('0')";
				$totalResult = $conn->query($totalSql);
				$totalRow = mysqli_fetch_array($totalResult);
				$total_no = ($arrCheckBox)? $totalRow['total_no']: 0;

				//get number of pages
				$noOfPages = ceil($total_no/10);
				if($noOfPages < $_SESSION['page']){
					$_SESSION['page'] = 1;
				}

				//display prev and next button based on the current page
				$prev = ($_SESSION['page'] > 1)?
					"<td> <form action='food.php' method='post'><input type='submit' name='prev_table' value='prev'/></form></td>": null;
				$next = ($_SESSION['page'] < $noOfPages)? "<td> <form action='food.php' method='post'><input type='submit' name='next_table' value='next'/></form></td>" : null;

				//table to be generated
				$table = "<br/><center><table><tr> {$prev} <td>	Total no. of records: {$total_no}</td>  {$next} </tr></table></center>";
				$table .= "<center><table border='1'><tr><th>no.</th><th>action</th>";
				foreach($arrCheckBox as $check) {
					$table .= "<th>$check</th>";
				}
				$table .= "</tr>";

				//get number of first record to be displayed
				$counter = $offset - 10;
				//$sql = "SELECT * from Drug WHERE cpr_no NOT IN ('0') ORDER BY cpr_no ASC LIMIT 10 OFFSET {$counter} ";
				$sql = "SELECT cpr_no,dr_no,country,rsn,validity_date,food_name
				,(select name from Manufacturer where manu_no = (select manu_no from manufactures where food_cpr_no = f.cpr_no)) as manufacturer
				,(select name from Trader where trader_no = (select trader_no from trades where food_cpr_no = f.cpr_no)) as trader
				,(select name from Distributor where dist_no = (select dist_no from distributes where food_cpr_no = f.cpr_no)) as distributor
				From food f where cpr_no <> '0' ORDER BY cpr_no ASC LIMIT 10 OFFSET {$counter}";
				$result = $conn->query($sql);

				//add action column to the table, i.e., view, edit, and delete actions
				while($row = mysqli_fetch_array($result)){
					$counter++;
					$table .= "<tr><td>{$counter}</td><td>";
					$table .= '<a href="../view/view-food.php?cpr_no='.$row['cpr_no'].'">view</a>';
					if($_SESSION['isLoggedIn'] == true){
						$table .=' | <a href="../edit/edit-food.php?cpr_no='.$row['cpr_no'].'">edit</a>
						| <a href="../delete/delete-food.php?cpr_no='.$row['cpr_no'].'">delete</a></td>';
					}
					foreach($arrCheckBox as $rowVal){
						$table .= "<td>" . $row[$rowVal] . "</td>";
					}
					$table .= "</tr>";
				}
				$table .= "</table>";

				mysqli_close($conn);
				return $table;
		}
  //when form is submitted/or generate table
  if($_POST['generate']){

    //set list of selected columns to the session variable so that checkboxes will remain checked after submitting the form
    $_SESSION['arrCheckedVals'] = $_POST['check_list'];
    $_SESSION['selected_report'] = 'default';
    echo generateForm($arrColValues, $arrColLabels);


    $arrCheckBox = $_POST['check_list'];

    if($arrCheckBox){
      //number of records will be displayed at most 10 each page
      $offset = $_SESSION['page'] * 10;
      $_SESSION['selected_report'] = 'default';
      //echo setBarScript();
      echo generateTable($arrCheckBox,$offset);
      //echo generateGraph('bar_graph');
      //echo generateAdHocReports();

    }


  } else {
    echo generateForm($arrColValues, $arrColLabels);
  }

  //if next page is selected
  if($_POST['next_table']){
    $arrCheckBox = $_SESSION['arrCheckedVals'];
    $_SESSION['page'] ++;
    $offset = $_SESSION['page'] * 10;
    echo generateTable($arrCheckBox,$offset);
    //echo generateGraph('bar_graph');
    //echo generateAdHocReports();
  }
  //if previous page is selected
  if($_POST['prev_table']){
    $arrCheckBox = $_SESSION['arrCheckedVals'];
    $_SESSION['page']--;
    $offset = $_SESSION['page'] * 10;
    echo generateTable($arrCheckBox,$offset);
    //echo generateGraph('bar_graph');
    //echo generateAdHocReports();
  }

  //if a graph is selected
  if($_POST['bar'] || $_POST['line'] || $_POST['doughnut'] || $_POST['radar'] || $_POST['polarArea']){
    $graphType = 'bar_graph';
    $arrCheckBox = $_SESSION['arrCheckedVals'];
    $offset = $_SESSION['page'] * 10;
    if($_POST['bar']){
      $_SESSION['graph_type'] = 'bar_graph';
      $graphType = 'bar_graph';
    }
    if($_POST['line']){
      $_SESSION['graph_type'] = 'line_graph';
      $graphType = 'line_graph';
    }
    if($_POST['doughnut']){
      $_SESSION['graph_type'] = 'doughnut_graph';
      $graphType = 'doughnut_graph';
    }
    if($_POST['radar']){
      $_SESSION['graph_type'] = 'radar_graph';
      $graphType = 'radar_graph';
    }
    if($_POST['polarArea']){
      $_SESSION['graph_type'] = 'polarArea_graph';
      $graphType = 'polarArea_graph';
    }
    echo generateTable($arrCheckBox,$offset);
    //echo generateGraph($graphType);
    //echo generateAdHocReports();
  }

  //if a preconfigured report is selected
  if($_POST['no_of_drug_country'] || $_POST['no_of_generic_name'] || $_POST['no_of_branded_prod']
      || $_POST['no_of_manufacturer'] || $_POST['no_of_importer'] || $_POST['no_of_trader'] || $_POST['no_of_distributor'] ){
    $graphType = 'bar_graph';
    $arrCheckBox = $_SESSION['arrCheckedVals'];
    $offset = $_SESSION['page'] * 10;

    if($_POST['no_of_drug_country']){
      $_SESSION['selected_report'] = 'no_of_drug_country';
      $graphType = 'bar_graph';
    }
    if($_POST['no_of_generic_name']){
      $_SESSION['selected_report'] = 'no_of_generic_name';
      $graphType = 'radar_graph';
    }
    if($_POST['no_of_branded_prod']){
      $_SESSION['selected_report'] = 'no_of_branded_prod';
      $graphType = 'radar_graph';
    }
    if($_POST['no_of_manufacturer']){
      $_SESSION['selected_report'] = 'no_of_manufacturer';
      $graphType = 'bar_graph';
    }
    if($_POST['no_of_importer']){
      $_SESSION['selected_report'] = 'no_of_importer';
      $graphType = 'radar_graph';
    }
    if($_POST['no_of_trader']){
      $_SESSION['selected_report'] = 'no_of_trader';
      $graphType = 'polarArea_graph';
    }
    if($_POST['no_of_distributor']){
      $_SESSION['selected_report'] = 'no_of_distributor';
      $graphType = 'radar_graph';
    }



    //echo setBarScript();
    echo generateTable($arrCheckBox,$offset);
    //echo generateGraph($graphType);
    //echo generateAdHocReports();

  }


?>



</body>

</html>