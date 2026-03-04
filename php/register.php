<?php require 'db.php'; ?>

<?php
$message = ""; // Variable to store success or error messages

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = $_POST['username'];
    $password = password_hash($_POST['password'], PASSWORD_DEFAULT);
    
    // Check if username already exists
    $check = $pdo->prepare("SELECT id FROM users WHERE username = ?");
    $check->execute([$username]);
    
    if ($check->rowCount() > 0) {
        $message = "<p style='color:red'>Username already taken!</p>";
    } else {
        // Default role is 'client'
        $stmt = $pdo->prepare("INSERT INTO users (username, password, role) VALUES (?, ?, 'client')");
        if ($stmt->execute([$username, $password])) {
            $message = "<p style='color:green'>Success! <a href='login.php'>Login here</a></p>";
        } else {
            $message = "<p style='color:red'>Error registering.</p>";
        }
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Create Account</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

    <div class="login-box">
        <h2>Create Account</h2>
        <p>Join our adoption center today!</p>
        
        <?= $message; ?>

        <form method="POST">
            <input type="text" name="username" placeholder="Choose a Username" required>
            <input type="password" name="password" placeholder="Choose a Password" required>
            <button type="submit">Sign Up</button>
        </form>

        <br>
        <a href="login.php">Already have an account? Login</a>
    </div>

    <script>
        // Prevent going back using browser back button
        window.history.forward();
        function noBack() {
            window.history.forward();
        }
        
        window.onload = noBack;
        window.onpageshow = function(evt) {
            if (evt.persisted) {
                noBack();
            }
        }
        
        // Clear browser cache
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