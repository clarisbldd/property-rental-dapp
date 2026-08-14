<?php
include 'config.php'; // Koneksi database

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $owner_id = $_POST['owner_id'];
    $description = $_POST['description'];
    $price = $_POST['price'];
    
    // Simpan data properti ke database lokal
    $sql = "INSERT INTO properties (owner_id, description, price) 
            VALUES ('$owner_id', '$description', '$price')";

    if ($conn->query($sql) === TRUE) {
        echo "New property created successfully";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }
}
?>

<form method="POST" action="add_property.php">
    Owner ID: <input type="number" name="owner_id" required><br>
    Description: <textarea name="description" required></textarea><br>
    Price: <input type="text" name="price" required><br>
    <input type="submit" value="Add Property">
</form>