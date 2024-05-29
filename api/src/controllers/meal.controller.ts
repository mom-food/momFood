import { Request, Response } from "express";
import { Meal } from "../models";

// Create a meal
export const createMeal = async (req: Request, res: Response) => {
try {
const { name, description, price, image, category } = req.body;

const meal = new Meal({
name,
description,
price,
image,
category,
});

await meal.save();
console.log("تمت إضافة وجبة إلى قاعدة البيانات");
res.status(201).json(meal);
} catch (error: any) {
console.error(error);
res.status(500).json({ message: error.message });
}
};

// Get all meals
export const getAllMeals = async (req: Request, res: Response) => {
try {
const query = req.query.query as string | undefined;

const meals = await Meal.find({
name: { $regex: new RegExp(query ?? "", "i") },
}).exec();

console.log(meals);
res.status(200).json(meals);
} catch (error: any) {
res.status(500).json({ message: error.message });
}
};

// Get a specific meal by ID
export const getMeal = async (req: Request, res: Response) => {
try {
const meal = await Meal.findById(req.params.id).exec();
res.status(200).json(meal);
} catch (error: any) {
console.error(error);
res.status(500).json({ message: "حدث خطأ!" });
}
};

// Update a meal by ID
export const updateMeal = async (req: Request, res: Response) => {
try {
const { name, description, price, image, category } = req.body;
const mealId = req.params.id;

const meal = await Meal.findByIdAndUpdate(mealId, {
name,
description,
price,
image,
category,
}, { new: true });

res.status(200).json(meal);
} catch (error: any) {
console.error(error);
res.status(500).json({
message: "An error occurred while updating the meal",
});
}
};

// Delete a meal by ID
export const deleteMeal = async (req: Request, res: Response) => {
try {
const meal = await Meal.findByIdAndDelete(req.params.id).exec();
res.status(200).json(meal);
} catch (error: any) {
console.error(error);
res.status(500).json({ message: "حدث خطأ!" });
}
};

// Get filtered meals based on search query
export const getFilteredMeals = async (req: Request, res: Response) => {
console.log("User is trying to get some meals");
try {
const search = req.query?.search as string | undefined;
console.log("What the user is trying to search for: ", search);
const meals = await Meal.find({
name: { $regex: new RegExp(search ?? "", "i") },
}).exec();
res.status(200).json(meals);
} catch (error: any) {
res.status(500).json({ message: "Error searching" });
}
};
