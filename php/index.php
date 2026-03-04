<?php 
require 'db.php'; 

// Try to get cached available animals (cache for 5 minutes)
$cache_key = 'available_animals_list';
$animals = cache_get($cache_key);

if ($animals === false) {
    // Optimized query: only select needed columns
    $stmt = $pdo->query("SELECT id, name, species, age, image FROM animals WHERE status = 'Available' LIMIT 100");
    $animals = $stmt->fetchAll();
    cache_set($cache_key, $animals);
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>MewMew Adoption Center</title>
    <link rel="stylesheet" href="style.css">
    <style>
        img {
            loading: lazy; /* Native lazy loading */
        }
    </style>
</head>
<body>

    <div class="brand-title">🐱 MewMew Adoption Center 🐶</div>

    <div class="navbar">
    <a href="index.php">Home</a>
    
    <?php if (isset($_SESSION['user_id'])) { ?>
        
        <a href="my_adoptions.php">My Pets</a>

        <?php if (isset($_SESSION['role']) && $_SESSION['role'] == 'admin') { ?>
            <a href="admin.php" style="background-color: #e67e22;">⚙️ Admin Dashboard</a>
        <?php } ?>

        <a href="logout.php" style="float:right">Logout (<?= htmlspecialchars($_SESSION['username']) ?>)</a>
        
    <?php } else { ?>
        <a href="login.php" style="float:right">Login</a>
    <?php } ?>
</div>

    <div class="container">
        <h1>Find Your New Best Friend</h1>
        
        <?php if (count($animals) > 0) { ?>
            
            <?php foreach ($animals as $animal) { ?>
                <div class="animal-card">
                    <img src="uploads/<?= htmlspecialchars($animal['image']) ?>" alt="<?= htmlspecialchars($animal['name']) ?>" 
                         style="width:100%; height:150px; object-fit:cover; border-radius:5px;" loading="lazy">
                    
                    <h3><?= htmlspecialchars($animal['name']) ?></h3>
                    <p><strong><?= htmlspecialchars($animal['species']) ?></strong></p>
                    <p><?= intval($animal['age']) ?> years old</p>
                    
                    <?php if (isset($_SESSION['user_id'])) { ?>
                        <a href="adopt_form.php?id=<?= intval($animal['id']) ?>">
                            <button>Adopt Me!</button>
                        </a>
                    <?php } else { ?>
                        <p style="color: gray;"><i>Login to adopt</i></p>
                    <?php } ?>
                </div>
            <?php } ?>

        <?php } else { ?>
            <p>No animals available for adoption right now.</p>
        <?php } ?>
    </div>

</body>
</html>