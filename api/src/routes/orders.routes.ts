import express from 'express';
import { createOrder, getAllOrders } from '../controllers/order.controller';

const router = express.Router();

// Routes for users
router.post('/', createOrder);
router.get('/', getAllOrders);
// router.get('/:email', getOrderByEmail);

export default router;
