import { Request, Response } from "express";
import { Category } from "../models/category";

export const getFilteredCategories = async (req: Request, res: Response) => {
  console.log("User is trying to get some categories");
  try {
    const search = req.query?.search as string | undefined;
    console.log("What the user is trying to search for: ", search);
    const categories = await Category.find({
      name: { $regex: new RegExp(search ?? "", "i") },
    }).exec();
    res.status(200).json(categories);
  } catch (error: any) {
    res.status(500).json({ message: error.message });
  }
};

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
export const getCategoryById = async (req: Request, res: Response) => {
  try {
    const { id } = req.params;
    const category = await Category.findById(id).exec();
    if (!category) {
      res.status(404).json({ message: "Category not found" });
    } else {
      res.status(200).json(category);
    }
  } catch (error: any) {
    console.error(error);
    res.status(500).json({ message: "Unknown error" });
  }
};

export const updateCategory = async (req: Request, res: Response) => {
  try {
    const { id } = req.params;
    const { name, image } = req.body;
    const category = await Category.findByIdAndUpdate(id, { name, image })
      .exec();
    if (!category) {
      res.status(404).json({ message: "Category not found" });
    } else {
      res.status(200).json(category);
    }
  } catch (error: any) {
    console.error(error);
    res.status(500).json({ message: "Unknown error" });
  }
};

export const deleteCategory = async (req: Request, res: Response) => {
  try {
    const { id } = req.params;
    const category = await Category.findByIdAndDelete(id).exec();
    if (!category) {
      res.status(404).json({ message: "Category not found" });
    } else {
      res.status(200).json(category);
    }
  } catch (error: any) {
    console.error(error);
    res.status(500).json({ message: "Unknown error" });
  }
};
