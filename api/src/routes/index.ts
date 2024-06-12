// src/routes/index.ts

import express from 'express';
import categoryRoutes from './category.routes';
import mealRoutes from './meals.routes';
import userRoutes from './users.routes';
import orderRoutes from './orders.routes';
import resetPasswordRoutes from './reset-password.routes';

const router = express.Router();

router.use('/categories', categoryRoutes);
router.use('/meals', mealRoutes);
router.use('/users', userRoutes);
router.use('/orders', orderRoutes);
router.use('/auth/resetPassword', resetPasswordRoutes);


export default router;