// src/routes/index.ts

import express from 'express';
import categoryRoutes from './category.routes';

const router = express.Router();

router.use('/categories', categoryRoutes);

export default router;