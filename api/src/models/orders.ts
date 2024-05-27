import mongoose, { Schema, Document } from 'mongoose';

// Define an interface representing a document in MongoDB for User
interface IOrder extends Document {
    userId: mongoose.Types.ObjectId,
    status: boolean;
    meals: [{quantity: number, id: mongoose.Types.ObjectId}];
}

// Deine the Order schema
const orderSchema: Schema = new Schema({
    userId: mongoose.Types.ObjectId,
    status: { type: Boolean, required: true },
    meals: { type: [{quantity: Number, id: mongoose.Types.ObjectId}], required: true },
});

// Create a model based on the Order schema
const Order = mongoose.model<IOrder>('Order', orderSchema);

export { Order };

