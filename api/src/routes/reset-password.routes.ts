// src/routes/meal.routes.ts

import express from 'express';
import {
resetPasswordRedirect
} from '../controllers'; // Import the meal controller functions

const router = express.Router();


// Routes for password reset
router.get('/', resetPasswordRedirect);

export default router;