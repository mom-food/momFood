// src/routes/index.ts

import express from 'express';
import categoryRoutes from './category.routes';
import mealRoutes from './meals.routes';

const router = express.Router();

router.use('/categories', categoryRoutes);
router.use('/meals', mealRoutes);

export default router;