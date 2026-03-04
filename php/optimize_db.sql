-- Performance Optimization Indexes for adoption_db
-- Add these indexes to significantly improve query performance

-- Optimize animals table queries
ALTER TABLE `animals` ADD INDEX `idx_status` (`status`);
ALTER TABLE `animals` ADD INDEX `idx_species` (`species`);

-- Optimize adoptions table queries
ALTER TABLE `adoptions` ADD INDEX `idx_user_id` (`user_id`);
ALTER TABLE `adoptions` ADD INDEX `idx_animal_id` (`animal_id`);
ALTER TABLE `adoptions` ADD INDEX `idx_adoption_date` (`adoption_date`);
ALTER TABLE `adoptions` ADD INDEX `idx_user_animal` (`user_id`, `animal_id`);

-- Optimize users table queries
ALTER TABLE `users` ADD INDEX `idx_username` (`username`);
ALTER TABLE `users` ADD INDEX `idx_role` (`role`);

-- Optimize payments table queries
ALTER TABLE `payments` ADD INDEX `idx_adoption_id` (`adoption_id`);
ALTER TABLE `payments` ADD INDEX `idx_user_id_payment` (`user_id`);
ALTER TABLE `payments` ADD INDEX `idx_payment_status` (`payment_status`);

-- Optimize admin_logs table queries
ALTER TABLE `admin_logs` ADD INDEX `idx_admin_id` (`admin_id`);
ALTER TABLE `admin_logs` ADD INDEX `idx_target_user` (`target_user_id`);
ALTER TABLE `admin_logs` ADD INDEX `idx_log_date` (`log_date`);
