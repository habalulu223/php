<?php 
require 'db.php'; 

// Check Admin
if (!isset($_SESSION['user_id']) || $_SESSION['role'] != 'admin') {
    header("Location: login.php");
    exit;
}

// Handle Adding New Animal
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['add_animal'])) {
    $name = $_POST['name'];
    $species = $_POST['species'];
    $age = $_POST['age'];
    $image = 'default.jpg'; 

    if (isset($_FILES['animal_photo']) && $_FILES['animal_photo']['error'] == 0) {
        $target_dir = "uploads/";
        $filename = basename($_FILES["animal_photo"]["name"]);
        if (move_uploaded_file($_FILES["animal_photo"]["tmp_name"], $target_dir . $filename)) {
            $image = $filename;
        }
    }
    
    $stmt = $pdo->prepare("INSERT INTO animals (name, species, age, image) VALUES (?, ?, ?, ?)");
    $stmt->execute([$name, $species, $age, $image]);
}

$all_animals = $pdo->query("SELECT * FROM animals ORDER BY id DESC")->fetchAll();
?>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

    <div class="brand-title">🐱 MewMew Admin Panel 🐶</div>

    <div class="navbar">
        <a href="admin.php" style="background-color: #555;">🐾 Animals</a> <a href="adoptions.php">📜 Adoptions</a>
        <a href="users.php">👥 Users & Admins</a>
        <a href="index.php" style="float:right; background-color: #4CAF50;">View Website</a>
        <a href="logout.php" style="float:right">Logout</a>
    </div>

    <div class="container">
        <h1>Manage Animals</h1>

        <div style="background: #eee; border: 2px solid #333; padding: 20px; border-radius: 10px; text-align: left;">
            <h3>➕ Post New Animal</h3>
            <form method="POST" enctype="multipart/form-data" style="display: grid; gap: 10px; grid-template-columns: 1fr 1fr;">
                <div><label>Name:</label><br><input type="text" name="name" required></div>
                <div><label>Species:</label><br><input type="text" name="species" required></div>
                <div><label>Age:</label><br><input type="number" name="age" required></div>
                <div><label>Photo:</label><br><input type="file" name="animal_photo"></div>
                <button type="submit" name="add_animal" style="grid-column: span 2;">Post Animal</button>
            </form>
        </div>

        <br><hr><br>

        <h3>Current Animals</h3>
        <table>
            <tr><th>Image</th><th>Name</th><th>Status</th><th>Action</th></tr>
            <?php foreach ($all_animals as $animal): ?>
            <tr>
                <td><img src="uploads/<?= $animal['image'] ?>" width="50" height="50" style="object-fit:cover; border-radius:50%;"></td>
                <td><?= $animal['name'] ?> (<?= $animal['species'] ?>)</td>
                <td><span style="color: <?= $animal['status'] == 'Available' ? 'green' : 'red' ?>; font-weight:bold;"><?= $animal['status'] ?></span></td>
                <td><a href="edit_animal.php?id=<?= $animal['id'] ?>"><button style="padding: 5px;">Edit</button></a></td>
            </tr>
            <?php endforeach; ?>
        </table>
    </div>
</body>
</html>