import mongoose, { Schema, Document } from 'mongoose';

// Define an interface representing a document in MongoDB for Meal
interface IMeal extends Document {
  name: string;
  description: string;
  price: number;
  image: string;
  category: mongoose.Types.ObjectId; // Reference to the Category
}

// Define the Meal schema
const mealSchema: Schema = new Schema({
  name: { type: String, required: true },
  description: { type: String, required: true },
  price: { type: Number, required: true },
  image: { type: String, required: true },
  category: { type: Schema.Types.ObjectId, ref: 'Category' }, // Reference to the Category model
});

// Create a model based on the Meal schema
const Meal = mongoose.model<IMeal>('Meal', mealSchema);

export { Meal };
