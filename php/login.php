<?php require 'db.php'; ?>

<?php
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = $_POST['username'];
    $password = $_POST['password'];

    $stmt = $pdo->prepare("SELECT * FROM users WHERE username = ?");
    $stmt->execute([$username]);
    $user = $stmt->fetch();

    if ($user && password_verify($password, $user['password'])) {
        $_SESSION['user_id'] = $user['id'];
        $_SESSION['role'] = $user['role'];
        $_SESSION['username'] = $user['username'];

        if ($user['role'] == 'admin') {
            header("Location: admin.php");
        } else {
            header("Location: index.php");
        }
        exit;
    } else {
        $error = "Invalid credentials.";
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="login-box">
        <h2>Login</h2>
        <?php if(isset($error)) echo "<p style='color:red;'>" . htmlspecialchars($error) . "</p>"; ?>
        <form method="POST">
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Login</button>
        </form>
        <br>
        <a href="register.php">Create an account</a>
    </div>

    <script>
        // Prevent going back to cached pages after logout
        window.history.forward();
        function noBack() {
            window.history.forward();
        }
        
        // Disable browser back button
        window.onload = noBack;
        window.onpageshow = function(evt) {
            if (evt.persisted) {
                noBack();
            }
        }
        
        // Prevent cache
        if (window.history.replaceState) {
            window.history.replaceState(null, null, window.location.href);
        }

        // Clear browser cache on page load
        if ('caches' in window) {
            caches.keys().then(function(cacheNames) {
                return Promise.all(
                    cacheNames.map(function(cacheName) {
                        return caches.delete(cacheName);
                    })
                );
            });
        }
    </script>
</body>
</html>