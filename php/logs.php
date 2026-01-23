<?php 
require 'db.php'; 

if (!isset($_SESSION['user_id']) || $_SESSION['role'] != 'admin') {
    header("Location: login.php");
    exit;
}

// FETCH LOGS
// We use LEFT JOIN for target_user because sometimes there is NO target user (like when editing an animal)
$logs = $pdo->query("SELECT admin_logs.*, 
                            admin_user.username AS admin_name, 
                            target_user.username AS target_name 
                     FROM admin_logs 
                     JOIN users AS admin_user ON admin_logs.admin_id = admin_user.id 
                     LEFT JOIN users AS target_user ON admin_logs.target_user_id = target_user.id 
                     ORDER BY log_date DESC")->fetchAll();
?>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Logs</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

    <div class="brand-title">🐱 MewMew Admin Panel 🐶</div>

    <div class="navbar">
        <a href="admin.php">🐾 Animals</a>
        <a href="adoptions.php">📜 Adoptions</a>
        <a href="users.php">👥 Users</a>
        <a href="logs.php" style="background-color: #555;">⚠️ Logs</a> 
        <a href="index.php" style="float:right; background-color: #4CAF50;">View Website</a>
        <a href="logout.php" style="float:right">Logout</a>
    </div>

    <div class="container">
        <h1>Admin Activity Logs</h1>
        <p>History of all actions.</p>

        <table>
            <tr>
                <th>Time</th>
                <th>Admin (Who did it)</th>
                <th>Action</th>
                <th>Target (User affected)</th>
            </tr>
            <?php foreach ($logs as $log): ?>
            <tr>
                <td><?= date("M d, Y h:i A", strtotime($log['log_date'])) ?></td>
                
                <td>
                    <strong style="color: #2E7D32;">
                        <?= htmlspecialchars($log['admin_name']) ?>
                    </strong>
                </td>
                
                <td>
                    <?php if (strpos($log['action'], 'Edited Animal') !== false): ?>
                        <span style="color: #008CBA; font-weight: bold;">✏️ <?= $log['action'] ?></span>
                    <?php elseif (strpos($log['action'], 'Promoted') !== false): ?>
                        <span style="color: green; font-weight: bold;">⬆️ <?= $log['action'] ?></span>
                    <?php else: ?>
                        <span style="color: red; font-weight: bold;">⬇️ <?= $log['action'] ?></span>
                    <?php endif; ?>
                </td>

                <td>
                    <?= $log['target_name'] ? htmlspecialchars($log['target_name']) : "—" ?>
                </td>
            </tr>
            <?php endforeach; ?>
        </table>
    </div>
</body>
</html>