<?php
require 'db.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_SESSION['user_id'])) {
    
    $adoption_id = $_POST['adoption_id'];
    $animal_id = $_POST['animal_id'];

    // 1. Delete from Adoptions Table
    $stmt = $pdo->prepare("DELETE FROM adoptions WHERE id = ?");
    $stmt->execute([$adoption_id]);

    // 2. Set Animal Status back to 'Available'
    $update = $pdo->prepare("UPDATE animals SET status = 'Available' WHERE id = ?");
    $update->execute([$animal_id]);

    // Redirect back to the list
    header("Location: my_adoptions.php");
    exit;
}
?>