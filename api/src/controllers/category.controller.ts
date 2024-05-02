import { Request, Response } from "express";
import { Category} from "../models";

export const createCategory = async (req: Request, res: Response) => {
  try {
    const { name, image } = req.body; 

    const category = new Category({
      name,
      image,
    });

    await category.save();
    console.log("A category has been added to database");
    res.status(201).json(category);
  } catch (error: any) {
    res.status(500).json({ message: error.message });
  }
};

export const getAllCategories = async (req: Request, res: Response) => {
  try {
    const categories = await Category.find().exec();
    res.status(200).json(categories);
  } catch (error: any) {
    res.status(500).json({ message: error.message });
  }
};
// ... Implement other routes: get by id, put (update), delete