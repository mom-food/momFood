// src/routes/index.ts

import express from 'express';
import categoryRoutes from './category.routes';
import mealRoutes from './meals.routes';
import userRoutes from './users.routes';
import orderRoutes from './orders.routes';

const router = express.Router();

router.use('/categories', categoryRoutes);
router.use('/meals', mealRoutes);
router.use('/users', userRoutes);
router.use('/orders', orderRoutes);

export default router;