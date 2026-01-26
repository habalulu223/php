<?php 
require 'db.php'; 

if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit;
}

$user_id = $_SESSION['user_id'];

// Fetch user's adoptions
$my_adoptions = $pdo->prepare("SELECT adoptions.id as adoption_id, animals.name, animals.image, animals.id as animal_id 
                               FROM adoptions 
                               JOIN animals ON adoptions.animal_id = animals.id 
                               WHERE adoptions.user_id = ?");
$my_adoptions->execute([$user_id]);
$pets = $my_adoptions->fetchAll();
?>

<!DOCTYPE html>
<html>
<head>
    <title>My Adoptions</title>
    <link rel="stylesheet" href="style.css">
    
    <style>
        /* The Background Cover (Black Overlay) */
        .modal {
            display: none; /* Hidden by default */
            position: fixed; 
            z-index: 9999; /* HUGE number to sit on top of everything */
            left: 0;
            top: 0;
            width: 100%; 
            height: 100%; 
            background-color: rgba(0,0,0,0.7); /* Darker background */
        }

        /* The White Box */
        .modal-content {
            background-color: #fff;
            margin: 10% auto; /* 10% from the top and centered */
            padding: 20px;
            border: 2px solid #333;
            width: 80%;
            max-width: 400px;
            text-align: center;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.5);
            animation: fadeIn 0.3s;
        }

        /* Animation to make it pop smoothly */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-50px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .sad-puppy-img {
            width: 100%;
            max-width: 250px;
            border-radius: 10px;
            margin-bottom: 15px;
        }

        .btn-group button {
            margin: 10px;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
            border: none;
            font-weight: bold;
        }
    </style>
</head>
<body>

    <div class="brand-title">🐱 MewMew Adoption Center 🐶</div>

    <div class="navbar">
        <a href="index.php">Home</a>
        <a href="my_adoptions.php" style="background-color: #555;">My Pets</a>
        <a href="logout.php" style="float:right">Logout</a>
    </div>

    <div class="container">
        <h1>My Adopted Pets</h1>

        <?php if (count($pets) > 0): ?>
            <?php foreach ($pets as $pet): ?>
            <div class="animal-card">
                <img src="uploads/<?= $pet['image'] ?>" style="width:100%; height:150px; object-fit:cover; border-radius:5px;">
                <h3><?= $pet['name'] ?></h3>
                
                <button onclick="showSadPopup(<?= $pet['adoption_id'] ?>, <?= $pet['animal_id'] ?>)" style="background-color: #f44336;">
                    Cancel Adoption
                </button>
            </div>
            <?php endforeach; ?>
        <?php else: ?>
            <p>You haven't adopted any pets yet.</p>
        <?php endif; ?>
    </div>

    <div id="sadModal" class="modal">
        <div class="modal-content">
            <h2 style="color: #d32f2f;">Wait! Are you sure?</h2>
            
            <img src="uploads/sad_dog.gif" alt="Sad Dog" class="sad-puppy-img">
            
            <p style="font-size: 18px;">Don't give up on me... I'll be sad! 😢</p>
            
            <div class="btn-group">
                <button onclick="closePopup()" style="background-color: #4CAF50; color: white;">
                    No! I love you!
                </button>

                <form action="cancel_adoption.php" method="POST" style="display:inline;">
                    <input type="hidden" id="adopt_id" name="adoption_id">
                    <input type="hidden" id="animal_id" name="animal_id">
                    <button type="submit" style="background-color: #f44336; color: white;">
                        Yes, I'm sorry...
                    </button>
                </form>
            </div>
        </div>
    </div>

    <script>
        function showSadPopup(adoptId, animalId) {
            // 1. Show the Modal
            var modal = document.getElementById("sadModal");
            modal.style.display = "block";

            // 2. Put the ID into the form so PHP knows what to delete
            document.getElementById("adopt_id").value = adoptId;
            document.getElementById("animal_id").value = animalId;
        }

        function closePopup() {
            document.getElementById("sadModal").style.display = "none";
        }
        
        // Close modal if user clicks outside the box
        window.onclick = function(event) {
            var modal = document.getElementById("sadModal");
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>

</body>
</html>