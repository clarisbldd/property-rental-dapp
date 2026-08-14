<?php
include 'config.php'; // Koneksi database

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $user_id = $_POST['user_id'];
    $property_id = $_POST['property_id'];
    $start_date = $_POST['start_date'];
    $end_date = $_POST['end_date'];

    // Simpan riwayat penyewaan ke database lokal
    $sql = "INSERT INTO rental_history (user_id, property_id, start_date, end_date) 
            VALUES ('$user_id', '$property_id', '$start_date', '$end_date')";

    if ($conn->query($sql) === TRUE) {
        echo "Rental record created successfully";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }
}
?>

<form method="POST" action="rent_property.php">
    User ID: <input type="number" name="user_id" required><br>
    Property ID: <input type="number" name="property_id" required><br>
    Start Date: <input type="date" name="start_date" required><br>
    End Date: <input type="date" name="end_date" required><br>
    <input type="submit" value="Rent Property">
</form>