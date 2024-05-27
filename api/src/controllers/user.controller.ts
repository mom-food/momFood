import { Request, Response } from 'express';
import { User } from '../models/users';


export const createUser = async (req: Request, res: Response) => {
    try {
      const { name, email, phone } = req.body;
  
      const user = new User({
        name,
        email,
        phone,
        orderHistory: [],
      });
  
      await user.save();
      console.log("تمت إضافة إلى قاعدة البيانات");
      res.status(201).json({message:"success", user});
    } catch (error: any) {
      console.error(error);
      res.status(500).json({ message: error.message });
    }
};

export const getAllUsers = async (req: Request, res: Response) => {
    try {
      const users = await User.find().exec();
      res.status(200).json(users);
    } catch (error: any) {
      res.status(500).json({ message: error.message });
    }
};

export const getUserByEmail = async (req: Request, res: Response) => {
    try {
      const user = await User.findOne({"email": req.params.email}).exec();
      res.status(200).json(user);
    } catch (err) {
      console.error(err);
      res.status(500).json({ message: "حدث خطأ!" });
    }
};


export const updateUserByEmail = async (req: Request, res: Response) => {
    try {
      const { email, name, phone } = req.body;
  
      const user = await User.findOneAndUpdate({email}, {name, phone}, {
        new: true, // Return the updated document
        runValidators: true // Run schema validations on update
      });
  
      if (!user) {
        return res.status(404).json({ message: "User not found" });
      }
      res.status(200).json({message:"success",user});
    } catch (err) {
      console.error(err);
      res.status(500).json({ message: "An error occurred while updating the user" });
    }
  };