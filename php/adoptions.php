<?php 
require 'db.php'; 

if (!isset($_SESSION['user_id']) || $_SESSION['role'] != 'admin') {
    header("Location: login.php");
    exit;
}

// Optimized query with proper indexing - only select needed columns
$adoptions = $pdo->query("SELECT adoptions.id, adoptions.adoption_date, adoptions.contact, adoptions.address,
                          users.username, animals.name as animal_name 
                          FROM adoptions 
                          JOIN users ON adoptions.user_id = users.id 
                          JOIN animals ON adoptions.animal_id = animals.id 
                          ORDER BY adoptions.adoption_date DESC
                          LIMIT 5000")->fetchAll();
?>

<!DOCTYPE html>
<html>
<head>
    <title>Adoption History</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

    <div class="brand-title">🐱 MewMew Admin Panel 🐶</div>

    <div class="navbar">
        <a href="admin.php">🐾 Animals</a>
        <a href="adoptions.php" style="background-color: #555;">📜 Adoptions</a> <a href="users.php">👥 Users & Admins</a>
        <a href="index.php" style="float:right; background-color: #4CAF50;">View Website</a>
        <a href="logout.php" style="float:right">Logout</a>
    </div>

    <div class="container">
        <h1>Adoption History</h1>
        <p>List of all successful adoptions (Total: <?= count($adoptions) ?>)</p>

        <table>
            <tr>
                <th>ID</th>
                <th>Client Name</th>
                <th>Animal Adopted</th>
                <th>Contact #</th>
                <th>Address</th>
                <th>Date</th>
            </tr>
            <?php foreach ($adoptions as $adopt): ?>
            <tr>
                <td><?= intval($adopt['id']) ?></td>
                <td><?= htmlspecialchars($adopt['username']) ?></td>
                <td><?= htmlspecialchars($adopt['animal_name']) ?></td>
                <td><?= htmlspecialchars($adopt['contact']) ?></td>
                <td><?= htmlspecialchars($adopt['address']) ?></td>
                <td><?= date("M d, Y", strtotime($adopt['adoption_date'])) ?></td>
            </tr>
            <?php endforeach; ?>
        </table>
    </div>
</body>
</html>