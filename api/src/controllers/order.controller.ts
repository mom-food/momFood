import { Request, Response } from 'express';
import { Order } from '../models/orders';


export const createOrder = async (req: Request, res: Response) => {
    try {
        
      const { userId, status, meals } = req.body;
      console.log(`userId:::::::::::::::::::::::::::::::::::: ${userId}`);
      const order = new Order({
        userId,
        status,
        meals,
      });
  
      await order.save();
      console.log("تمت إضافة إلى قاعدة البيانات");
      res.status(201).json({message:"success", order});
    } catch (error: any) {
      console.error(error);
      res.status(500).json({ message: error.message });
    }
};

export const getAllOrders = async (req: Request, res: Response) => {
    try {
      const orders = await Order.find().exec();
      res.status(200).json(orders);
    } catch (error: any) {
      res.status(500).json({ message: error.message });
    }
};

// export const getOrderByEmail = async (req: Request, res: Response) => {
//     try {
//       const order = await Order.findById(req.params.id).exec();
//       res.status(200).json(order);
//     } catch (err) {
//       console.error(err);
//       res.status(500).json({ message: "حدث خطأ!" });
//     }
// };
