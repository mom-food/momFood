import { Request, Response } from "express";
import { Meal } from "../models";

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

export const getAllMeals = async (req: Request, res: Response) => {
  // Query GET param
  console.log(req.query);
  const query = req.query.query as (string | undefined);

  try {
    // const categories = await Category.find({
    //   name: { $regex: new RegExp(search, "i") },
    // }).exec();
    const meals = await Meal.find({
      name: { $regex: new RegExp(query ?? "", "i") },
    })
      .exec();
    console.log(meals);
    res.status(200).json(meals);
  } catch (error: any) {
    res.status(500).json({ message: error.message });
  }
};

export const getMeal = async (req: Request, res: Response) => {
  try {
    const meal = await Meal.findById(req.params.id).exec();
    res.status(200).json(meal);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "حدث خطأ!" });
  }
};

// Update a meal by ID
export const updateMeal = async (req: Request, res: Response) => {
  try {
    const { name, description, price, image, category } = req.body;
    const mealId = req.params.id;

    // Find the meal by ID
    const meal = await Meal.findById(mealId);

    if (!meal) {
      return res.status(404).json({ message: "Meal not found" });
    }
    meal.name = name;
    meal.description = description;
    meal.price = price;
    meal.image = image;
    meal.category = category;

    // Save the updated meal
    await meal.save();

    res.status(200).json(meal);
  } catch (err) {
    console.error(err);
    res.status(500).json({
      message: "An error occurred while updating the meal",
    });
  }
};

export const deleteMeal = async (req: Request, res: Response) => {
  try {
    const meal = await Meal.findOneAndDelete({
      _id: req.params.id,
    }).exec();
    res.status(200).json(meal);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "حدث خطأ!" });
  }
};
