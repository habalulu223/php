<?php 
require 'db.php'; 

// Fetch available animals
$stmt = $pdo->query("SELECT * FROM animals WHERE status = 'Available'");
$animals = $stmt->fetchAll();
?>

<!DOCTYPE html>
<html>
<head>
    <title>MewMew Adoption Center</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

    <div class="brand-title">🐱 MewMew Adoption Center 🐶</div>

    <div class="navbar">
        <a href="index.php">Home</a>
        
        <?php if (isset($_SESSION['user_id'])) { ?>
            
            <?php if (isset($_SESSION['role']) && $_SESSION['role'] == 'admin') { ?>
                <a href="admin.php" style="background-color: #e67e22;"><b>⚙️ Admin Dashboard</b></a>
            <?php } ?>

            <a href="logout.php" style="float:right">Logout (<?= $_SESSION['username'] ?>)</a>
            
        <?php } else { ?>
            <a href="login.php" style="float:right">Login</a>
        <?php } ?>
    </div>

    <div class="container">
        <h1>Find Your New Best Friend</h1>
        
        <?php if (count($animals) > 0) { ?>
            
            <?php foreach ($animals as $animal) { ?>
                <div class="animal-card">
                    <img src="uploads/<?= $animal['image'] ?>" alt="Pet Photo" style="width:100%; height:150px; object-fit:cover; border-radius:5px;">
                    
                    <h3><?= $animal['name'] ?></h3>
                    <p><strong><?= $animal['species'] ?></strong></p>
                    <p><?= $animal['age'] ?> years old</p>
                    
                    <?php if (isset($_SESSION['user_id'])) { ?>
                        <a href="adopt_form.php?id=<?= $animal['id'] ?>">
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