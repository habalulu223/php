<?php
session_start();

// Get user ID before destroying session (for logging)
$user_id = isset($_SESSION['user_id']) ? $_SESSION['user_id'] : null;

// Clear all session data
$_SESSION = array();

// Destroy the session cookie
if (ini_get("session.use_cookies")) {
    $params = session_get_cookie_params();
    setcookie(session_name(), '', time() - 42000,
        $params["path"], $params["domain"],
        $params["secure"], $params["httponly"]
    );
}

// Destroy session
session_destroy();

// Set cache control headers to prevent browsing back
header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma: no-cache");
header("Expires: 0");

// Prevent MIME type sniffing
header("X-Content-Type-Options: nosniff");

// Redirect to login
header("Location: login.php");
exit;
?>