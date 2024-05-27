import mongoose, { Schema, Document } from 'mongoose';

// Define an interface representing a document in MongoDB for User
interface IUser extends Document {
  name: string;
  email: string;
  phone: string;
  orderHistory: [mongoose.Types.ObjectId]; 
}

// Deine the User schema
const userSchema: Schema = new Schema({
  name: { type: String, required: true },
  phone: { type: String, required: true },
  email: { type: String, required: true },
  orderHistory: { type: [Schema.Types.ObjectId], ref: 'Order' },
});

// Create a model based on the User schema
const User = mongoose.model<IUser>('User', userSchema);

export { User };
