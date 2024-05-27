import express from 'express';
import { createUser, getAllUsers, getUserByEmail, updateUserByEmail } from '../controllers/user.controller';

const router = express.Router();

// Routes for users
router.post('/', createUser);
router.get('/', getAllUsers);
router.patch('/', updateUserByEmail);
router.get('/:email', getUserByEmail);

export default router;