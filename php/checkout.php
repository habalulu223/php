<?php
require 'db.php';

if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit;
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $animal_id = $_POST['animal_id'];
    $user_id = $_SESSION['user_id'];
    $address = $_POST['address'];
    $contact = $_POST['contact'];

    // 1. Record the adoption with the extra info
    $stmt = $pdo->prepare("INSERT INTO adoptions (user_id, animal_id, address, contact) VALUES (?, ?, ?, ?)");
    $stmt->execute([$user_id, $animal_id, $address, $contact]);

    // 2. Update animal status to 'Adopted'
    $update = $pdo->prepare("UPDATE animals SET status = 'Adopted' WHERE id = ?");
    $update->execute([$animal_id]);

    // 3. Show Success Message
    echo "<!DOCTYPE html>
    <html>
    <head><link rel='stylesheet' href='style.css'></head>
    <body>
        <div class='login-box'>
            <h1 style='color:green'>Congratulations!</h1>
            <p>You have successfully adopted this pet.</p>
            <p>We will contact you at <b>$contact</b>.</p>
            <a href='index.php'><button>Back to Home</button></a>
        </div>
    </body>
    </html>";
}
?>