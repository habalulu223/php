<?php 
require 'db.php'; 

// Check if user is logged in
if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit;
}

// Check if an animal ID was sent
if (!isset($_GET['id'])) {
    header("Location: index.php");
    exit;
}

$animal_id = $_GET['id'];

// Fetch animal details to show the name
$stmt = $pdo->prepare("SELECT * FROM animals WHERE id = ?");
$stmt->execute([$animal_id]);
$animal = $stmt->fetch();
?>

<!DOCTYPE html>
<html>
<head>
    <title>Confirm Adoption</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

    <div class="login-box" style="width: 400px;">
        <h2>Adopt <?= $animal['name'] ?></h2>
        <p>Please provide your contact details to complete the adoption.</p>

        <form action="checkout.php" method="POST">
            <input type="hidden" name="animal_id" value="<?= $animal['id'] ?>">

            <label style="float:left; font-weight:bold;">Full Address:</label>
            <input type="text" name="address" placeholder="123 Main St, City..." required>

            <label style="float:left; font-weight:bold;">Contact Number:</label>
            <input type="number" name="contact" placeholder="09123456789" required>

            <button type="submit">Confirm Adoption</button>
        </form>
        
        <br>
        <a href="index.php">Cancel</a>
    </div>

</body>
</html>