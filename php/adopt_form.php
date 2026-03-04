<?php 
require 'db.php'; 

// Check if user is logged in
if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit;
}

// Check if an animal ID was sent
if (!isset($_GET['id'])) {
    header("Location: index.php");
    exit;
}

$animal_id = $_GET['id'];

// Fetch animal details to show the name
$stmt = $pdo->prepare("SELECT * FROM animals WHERE id = ?");
$stmt->execute([$animal_id]);
$animal = $stmt->fetch();
?>

<!DOCTYPE html>
<html>
<head>
    <title>Confirm Adoption</title>
    <link rel="stylesheet" href="style.css">
    <script src="https://js.stripe.com/v3/"></script>
    <style>
        .checkout-form-section {
            background: #f8f9fa;
            padding: 20px;
            margin: 15px 0;
            border-radius: 8px;
            border-left: 4px solid #4CAF50;
        }

        .section-title {
            font-size: 14px;
            font-weight: bold;
            color: #333;
            margin-bottom: 12px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .payment-options {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .payment-option {
            display: flex;
            align-items: center;
            padding: 12px;
            border: 2px solid #ddd;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.3s ease;
            background: white;
        }

        .payment-option:hover {
            border-color: #4CAF50;
            background: #f0f8f0;
        }

        .payment-option input[type="radio"] {
            margin-right: 12px;
            width: 18px;
            height: 18px;
            cursor: pointer;
        }

        .payment-option label {
            margin: 0;
            cursor: pointer;
            flex: 1;
            font-weight: 500;
        }

        .payment-details {
            display: none;
            margin-top: 12px;
            padding: 12px;
            background: white;
            border-radius: 6px;
            border: 1px solid #ddd;
        }

        .payment-details.active {
            display: block;
        }

        .form-row {
            display: flex;
            gap: 12px;
        }

        .form-row input {
            flex: 1;
        }

        input[type=text], input[type=password], input[type=number], input[type=email], select {
            width: 100%;
            padding: 12px;
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }

        select {
            cursor: pointer;
        }

        .form-label {
            float: left;
            font-weight: bold;
            color: #333;
            margin-top: 8px;
            font-size: 14px;
        }

        .checkout-box {
            width: 100%;
            max-width: 500px;
        }

        .button-group {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }

        .button-group button,
        .button-group a button {
            flex: 1;
        }

        .cancel-link {
            background-color: #999;
            color: white;
            padding: 14px 20px;
            text-align: center;
            border-radius: 4px;
            text-decoration: none;
            display: block;
            border: none;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        .cancel-link:hover {
            background-color: #777;
        }

        #card-element {
            border: 1px solid #ccc;
            padding: 12px;
            border-radius: 4px;
            margin: 8px 0;
            font-size: 14px;
        }

        #card-errors {
            color: #fa755a;
            margin-top: 8px;
            font-weight: bold;
        }

        .stripe-badge {
            font-size: 11px;
            color: #999;
            margin-top: 10px;
        }
    </style>
</head>
<body>

    <div class="login-box checkout-box">
        <h2>🐾 Adopt <?= $animal['name'] ?></h2>
        <p style="color: #666; margin-bottom: 25px;">Please provide your details to complete the adoption.</p>

        <form action="checkout.php" method="POST" id="adoptionForm">
            <input type="hidden" name="animal_id" value="<?= $animal['id'] ?>">
            <input type="hidden" name="stripeToken" id="stripeToken">

            <!-- Delivery Information Section -->
            <div class="checkout-form-section">
                <div class="section-title">📍 Delivery Information</div>
                
                <label class="form-label">Full Address:</label>
                <input type="text" name="address" placeholder="123 Main St, City, State, Zip..." required>

                <label class="form-label">Contact Number:</label>
                <input type="text" name="contact" placeholder="(+1) 234-567-8900" required>

                <label class="form-label">Email Address:</label>
                <input type="email" name="email" placeholder="your.email@example.com" required>
            </div>

            <!-- Payment Method Section -->
            <div class="checkout-form-section">
                <div class="section-title">💳 Payment Method</div>
                
                <div class="payment-options">
                    <div class="payment-option">
                        <input type="radio" id="stripe" name="payment_method" value="stripe" checked>
                        <label for="stripe">Credit/Debit Card (Stripe)</label>
                    </div>
                    <div id="stripe_details" class="payment-details active">
                        <div id="card-element"></div>
                        <div id="card-errors"></div>
                        <div class="stripe-badge">Secured by Stripe</div>
                    </div>

                    <div class="payment-option">
                        <input type="radio" id="paypal" name="payment_method" value="paypal">
                        <label for="paypal">PayPal</label>
                    </div>
                    <div id="paypal_details" class="payment-details">
                        <label class="form-label">PayPal Email:</label>
                        <input type="email" name="paypal_email" placeholder="your.email@paypal.com">
                    </div>

                    <div class="payment-option">
                        <input type="radio" id="bank" name="payment_method" value="bank_transfer">
                        <label for="bank">Bank Transfer</label>
                    </div>
                    <div id="bank_details" class="payment-details">
                        <label class="form-label">Account Holder Name:</label>
                        <input type="text" name="bank_account_holder" placeholder="John Doe">
                        
                        <label class="form-label">Bank Name:</label>
                        <input type="text" name="bank_name" placeholder="Your Bank">
                        
                        <label class="form-label">Account Number:</label>
                        <input type="text" name="bank_account_number" placeholder="123456789">
                    </div>
                </div>
            </div>

            <div class="button-group">
                <button type="submit" style="flex: 2;">✓ Complete Adoption</button>
                <a href="index.php" class="cancel-link">Cancel</a>
            </div>
        </form>
    </div>

    <script>
        // Initialize Stripe
        var stripe = Stripe('pk_test_hRN7jf1RAviu9fXsis5mLU8y');
        var elements = stripe.elements();
        var cardElement = elements.create('card');
        cardElement.mount('#card-element');

        // Handle card errors
        cardElement.on('change', function(event) {
            var displayError = document.getElementById('card-errors');
            if (event.error) {
                displayError.textContent = event.error.message;
            } else {
                displayError.textContent = '';
            }
        });

        // Payment method switching
        const paymentMethods = ['stripe', 'paypal', 'bank'];
        
        paymentMethods.forEach(method => {
            const radioBtn = document.getElementById(method);
            if (radioBtn) {
                radioBtn.addEventListener('change', function() {
                    paymentMethods.forEach(m => {
                        const details = document.getElementById(m + '_details');
                        if (details) {
                            details.classList.remove('active');
                        }
                    });
                    
                    const activeDetails = document.getElementById(method + '_details');
                    if (activeDetails) {
                        activeDetails.classList.add('active');
                    }
                });
            }
        });

        // Handle form submission
        var form = document.getElementById('adoptionForm');
        form.addEventListener('submit', async function(e) {
            e.preventDefault();

            const paymentMethod = document.querySelector('input[name="payment_method"]:checked').value;

            // If using Stripe, create token
            if (paymentMethod === 'stripe') {
                const {token} = await stripe.createToken(cardElement);

                if (token) {
                    document.getElementById('stripeToken').value = token.id;
                    form.submit();
                } else {
                    alert('Error processing card. Please check your details.');
                }
            } else {
                form.submit();
            }
        });
    </script>

</body>
</html>