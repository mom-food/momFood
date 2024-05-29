// src/routes/reset-password.routes.ts

import express from 'express';
import { Request, Response } from 'express';
import { resetPassword } from '../controllers/reset-password.controller';;

const router = express.Router();

// Routes for password reset
router.get('/', resetPassword);

export default router;
