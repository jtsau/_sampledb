<?php
//  class Animal
// {
//     public $ranch_name = '';
//     public $count = 0;
// }
// Create connection
$con=mysqli_connect("localhost","jtsau","summer4me","_sampledb");
 
// Check connection
if (mysqli_connect_errno())
{
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

$ranch_name = htmlspecialchars($_GET["ranch"]);
$animalType = htmlspecialchars($_GET["animal"]);

// // This SQL statement selects ALL from the table 'Locations'
$sql = "SELECT * FROM Cattle WHERE Animal LIKE '$animalType' AND Ranch LIKE '$ranch_name'";
 
// Check if there are results
if ($result = mysqli_query($con, $sql))
{
    // If so, then create a results array and a temporary one
    // to hold the data
    $resultArray = array();
    $tempArray = array();
 
    // Loop through each row in the result set
    while($row = $result->fetch_object())
    {
        // Add each row into our results array
        $tempArray = $row;
        array_push($resultArray, $tempArray);
    }
 
    // Finally, encode the array to JSON and output the results
    echo json_encode($resultArray);
}

 
// Close connections
mysqli_close($result);
mysqli_close($con);
?>