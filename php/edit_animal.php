<?php 
require 'db.php'; 

// Check Admin
if (!isset($_SESSION['user_id']) || $_SESSION['role'] != 'admin') {
    header("Location: login.php");
    exit;
}

if (!isset($_GET['id'])) {
    header("Location: admin.php");
    exit;
}

$id = $_GET['id'];

// HANDLE UPDATE
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $name = $_POST['name'];
    $species = $_POST['species'];
    $age = $_POST['age'];
    $status = $_POST['status'];
    
    // Image Logic
    if (isset($_FILES['animal_photo']) && $_FILES['animal_photo']['error'] == 0) {
        $target_dir = "uploads/";
        $filename = basename($_FILES["animal_photo"]["name"]);
        move_uploaded_file($_FILES["animal_photo"]["tmp_name"], $target_dir . $filename);
        $image_query = ", image = '$filename'"; 
    } else {
        $image_query = ""; 
    }

    // 1. Update the Animal
    $sql = "UPDATE animals SET name=?, species=?, age=?, status=? $image_query WHERE id=?";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$name, $species, $age, $status, $id]);

    // ---------------------------------------------------------
    // 2. NEW LOGGING CODE (Save the action)
    // ---------------------------------------------------------
    $admin_id = $_SESSION['user_id'];
    $action_text = "Edited Animal: $name (ID: $id)";
    
    // We insert 'NULL' for target_user_id because this action is on an animal, not a human
    $logStmt = $pdo->prepare("INSERT INTO admin_logs (admin_id, target_user_id, action) VALUES (?, 0, ?)");
	$logStmt->execute([$admin_id, $action_text]);
    // ---------------------------------------------------------

    header("Location: admin.php"); 
    exit;
}

// FETCH DATA
$stmt = $pdo->prepare("SELECT * FROM animals WHERE id = ?");
$stmt->execute([$id]);
$animal = $stmt->fetch();
?>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Animal</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="navbar">
        <a href="admin.php">← Back to Dashboard</a>
    </div>

    <div class="container">
        <h2>Edit Animal Details</h2>
        
        <div class="login-box" style="margin: 0 auto; width: 400px; text-align: left;">
            <form method="POST" enctype="multipart/form-data">
                
                <label>Name:</label>
                <input type="text" name="name" value="<?= $animal['name'] ?>" required>

                <label>Species:</label>
                <input type="text" name="species" value="<?= $animal['species'] ?>" required>

                <label>Age:</label>
                <input type="number" name="age" value="<?= $animal['age'] ?>" required>

                <label>Status:</label>
                <select name="status" style="width: 100%; padding: 10px; margin: 8px 0;">
                    <option value="Available" <?= $animal['status'] == 'Available' ? 'selected' : '' ?>>Available</option>
                    <option value="Adopted" <?= $animal['status'] == 'Adopted' ? 'selected' : '' ?>>Adopted</option>
                </select>

                <br><br>
                <label>Current Photo:</label><br>
                <img src="uploads/<?= $animal['image'] ?>" width="100"><br>
                
                <label>Change Photo (Optional):</label>
                <input type="file" name="animal_photo">

                <button type="submit" style="background-color: #008CBA;">Update Animal</button>
            </form>
        </div>
    </div>
</body>
</html>