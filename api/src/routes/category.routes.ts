import express, { Router } from "express";
import {
  createCategory,
  getAllCategories,
  getCategoryById,
  updateCategory,
  deleteCategory,
  getFilteredCategories,
} from "../controllers/category.controller";

const router: Router = express.Router();

router.post("/", createCategory);
router.get("/", getAllCategories);
router.get("/:id", getCategoryById);
router.get("/search", getFilteredCategories);
router.put("/:id", updateCategory);
router.delete("/:id", deleteCategory);


export default router;