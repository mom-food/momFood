import express from 'express';
import {
  createMeal,
  getAllMeals,
  getMeal,
  updateMeal,
  deleteMeal,
  getFilteredMeals,
  getMealsByCategory,
} from '../controllers';

const router = express.Router();

// Routes for meals
router.post('/', createMeal); // CREATE a meal
router.get('/', getAllMeals); // READ all meals
router.get('/:id', getMeal); // READ a meal by ID
router.get('/search', getFilteredMeals); // SEARCH for meals
router.put('/:id', updateMeal); // UPDATE a meal (using PUT method)
router.delete('/:id', deleteMeal); // DELETE a meal
router.get('/meals/:id', getMealsByCategory);

export default router;