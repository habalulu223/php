<?php
require 'db.php';

if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit;
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $animal_id = $_POST['animal_id'];
    $user_id = $_SESSION['user_id'];
    $address = $_POST['address'];
    $contact = $_POST['contact'];
    $email = isset($_POST['email']) ? $_POST['email'] : '';
    $payment_method = isset($_POST['payment_method']) ? $_POST['payment_method'] : 'not_specified';
    $stripe_token = isset($_POST['stripeToken']) ? $_POST['stripeToken'] : null;

    // 1. Record the adoption with the extra info (using existing columns only)
    $stmt = $pdo->prepare("INSERT INTO adoptions (user_id, animal_id, address, contact) VALUES (?, ?, ?, ?)");
    $stmt->execute([$user_id, $animal_id, $address, $contact]);

    // Get the adoption ID for payment record
    $adoption_id = $pdo->lastInsertId();

    // 2. Record payment information if available
    if (!empty($payment_method)) {
        try {
            $payment_stmt = $pdo->prepare("INSERT INTO payments (adoption_id, user_id, animal_id, payment_method, payment_status) VALUES (?, ?, ?, ?, ?)");
            $payment_status = ($payment_method === 'stripe' && $stripe_token) ? 'Pending' : 'Pending';
            $payment_stmt->execute([$adoption_id, $user_id, $animal_id, $payment_method, $payment_status]);
        } catch (PDOException $e) {
            // Payments table might not exist, continue anyway
        }
    }

    // 3. Update animal status to 'Adopted'
    $update = $pdo->prepare("UPDATE animals SET status = 'Adopted' WHERE id = ?");
    $update->execute([$animal_id]);

    // 4. Show Success Message
    $payment_text = ucfirst(str_replace('_', ' ', $payment_method));
    $icon = '✓';
    
    echo "<!DOCTYPE html>
    <html>
    <head>
        <link rel='stylesheet' href='style.css'>
        <style>
            .success-container {
                background: linear-gradient(135deg, #4CAF50 0%, #79df6c 100%);
                padding: 40px;
                border-radius: 12px;
                color: white;
                text-align: center;
                box-shadow: 0 8px 20px rgba(0,0,0,0.2);
                max-width: 500px;
            }
            .success-container h1 {
                font-size: 32px;
                margin: 20px 0;
                color: white;
            }
            .success-container .check-icon {
                font-size: 60px;
                margin: 20px 0;
            }
            .success-details {
                background: rgba(255,255,255,0.15);
                padding: 20px;
                border-radius: 8px;
                margin: 20px 0;
                text-align: left;
            }
            .success-details p {
                margin: 10px 0;
                font-size: 14px;
                  color: #000000;
            }
            .success-details strong {
                color: #000000;
            }
            .payment-status {
                background: rgba(255,255,255,0.2);
                padding: 8px 12px;
                border-radius: 4px;
                display: inline-block;
                margin-top: 10px;
            }
        </style>
    </head>
    <body>
        <div class='success-container'>
            <div class='check-icon'>$icon</div>
            <h1>Congratulations!</h1>
            <p style='font-size: 16px; margin-bottom: 20px;'>You have successfully adopted this pet.</p>
            
            <div class='success-details'>
                <p><strong style='color: #000000;'>📧 Email:</strong> " . htmlspecialchars($email) . "</p>
                <p><strong style='color: #000000;'>📞 Contact:</strong> " . htmlspecialchars($contact) . "</p>
                <p><strong style='color: #000000;'>💳 Payment Method:</strong> " . htmlspecialchars($payment_text) . "</p>
                <p><strong style='color: #000000;'>📍 Address:</strong> " . htmlspecialchars($address) . "</p>
            </div>
            
            " . ($payment_method === 'stripe' ? "<div class='payment-status'>Payment Processing via Stripe</div>" : "") . "
            
            <p>We will contact you shortly with adoption details.</p>
            <a href='index.php'><button style='margin-top: 20px; background-color: white; color: #4CAF50; font-weight: bold;'>Back to Home</button></a>
        </div>
    </body>
    </html>";
}
?>