<?php
$host = 'localhost';
$db   = 'adoption_db';
$user = 'root';
$pass = '';

try {
    // Optimized PDO connection with persistent connection and UTF-8
    $pdo = new PDO(
        "mysql:host=$host;dbname=$db;charset=utf8mb4",
        $user,
        $pass,
        [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_PERSISTENT => true,
            PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8mb4",
            PDO::MYSQL_ATTR_USE_BUFFERED_QUERY => true
        ]
    );
} catch (PDOException $e) {
    die("Connection failed: " . $e->getMessage());
}

session_start();

// Simple query caching function (5 minute cache)
function cache_get($key) {
    $cache_file = sys_get_temp_dir() . '/mewmew_cache_' . md5($key) . '.tmp';
    if (file_exists($cache_file) && (time() - filemtime($cache_file)) < 300) {
        return unserialize(file_get_contents($cache_file));
    }
    return false;
}

function cache_set($key, $data) {
    $cache_file = sys_get_temp_dir() . '/mewmew_cache_' . md5($key) . '.tmp';
    file_put_contents($cache_file, serialize($data));
}

function cache_clear($key) {
    $cache_file = sys_get_temp_dir() . '/mewmew_cache_' . md5($key) . '.tmp';
    if (file_exists($cache_file)) {
        unlink($cache_file);
    }
}
?>