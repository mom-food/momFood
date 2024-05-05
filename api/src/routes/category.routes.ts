import express, { Router } from "express";
import {
  createCategory,
  getAllCategories,
} from "../controllers";

const router: Router = express.Router();

router.post("/", createCategory);
router.get("/", getAllCategories);
// Implement other routes: get, put, delete

export default router;