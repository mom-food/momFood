// src/routes/index.ts

import express from 'express';
import categoryRoutes from './category.routes';
import mealRoutes from './meals.routes';
import resetPasswordRoutes from './reset-password.routes';

const router = express.Router();

router.use('/categories', categoryRoutes);
router.use('/meals', mealRoutes);
router.use('/auth/resetPassword', resetPasswordRoutes);

export default router;
