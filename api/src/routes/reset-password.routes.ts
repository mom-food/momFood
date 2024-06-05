// src/routes/reset-password.routes.ts

import express from 'express';
import { resetPasswordRedirect } from '../controllers/resetPasswordController'; // Correct import

const router = express.Router();

// Route for password reset
router.get('/resetPassword', resetPasswordRedirect);

export default router;
