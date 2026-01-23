<?php 
require 'db.php'; 

if (!isset($_SESSION['user_id']) || $_SESSION['role'] != 'admin') {
    header("Location: login.php");
    exit;
}

// Handle Role Updates
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $target_user_id = $_POST['user_id'];
    $new_role = $_POST['new_role'];
    $admin_id = $_SESSION['user_id']; // The ID of YOU (the admin currently logged in)
    
    // 1. Update the User's Role
    $stmt = $pdo->prepare("UPDATE users SET role = ? WHERE id = ?");
    $stmt->execute([$new_role, $target_user_id]);

    // 2. Create the Log Entry
    $action = ($new_role == 'admin') ? "Promoted to Admin" : "Demoted to Client";
    
    $logStmt = $pdo->prepare("INSERT INTO admin_logs (admin_id, target_user_id, action) VALUES (?, ?, ?)");
    $logStmt->execute([$admin_id, $target_user_id, $action]);
}

// Fetch all users
$users = $pdo->query("SELECT * FROM users ORDER BY id ASC")->fetchAll();
?>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Users</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

    <div class="brand-title">🐱 MewMew Admin Panel 🐶</div>

    <div class="navbar">
        <a href="admin.php">🐾 Animals</a>
        <a href="adoptions.php">📜 Adoptions</a>
        <a href="users.php" style="background-color: #555;">👥 Users</a> <a href="logs.php">⚠️ Logs</a>
        <a href="index.php" style="float:right; background-color: #4CAF50;">View Website</a>
        <a href="logout.php" style="float:right">Logout</a>
    </div>

    <div class="container">
        <h1>Manage Users</h1>
        <p>Control who has Admin access.</p>

        <table>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Current Role</th>
                <th>Action</th>
            </tr>
            <?php foreach ($users as $u): ?>
            <tr>
                <td><?= $u['id'] ?></td>
                <td><?= $u['username'] ?></td>
                <td>
                    <strong style="color: <?= $u['role'] == 'admin' ? 'green' : 'grey' ?>;">
                        <?= strtoupper($u['role']) ?>
                    </strong>
                </td>
                <td>
                    <form method="POST">
                        <input type="hidden" name="user_id" value="<?= $u['id'] ?>">
                        
                        <?php if ($u['role'] == 'client'): ?>
                            <input type="hidden" name="new_role" value="admin">
                            <button type="submit" style="background-color: #4CAF50; width:auto; padding: 5px 10px;">
                                ⬆️ Make Admin
                            </button>
                        <?php else: ?>
                            <input type="hidden" name="new_role" value="client">
                            <button type="submit" style="background-color: #f44336; width:auto; padding: 5px 10px;">
                                ⬇️ Remove Admin
                            </button>
                        <?php endif; ?>
                    </form>
                </td>
            </tr>
            <?php endforeach; ?>
        </table>
    </div>
</body>
</html>