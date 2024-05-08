import mongoose, { Schema, Document } from 'mongoose';

// Define an interface representing a document in MongoDB for Category
interface ICategory extends Document {
  name: string;
  image: string;
}

// Define the Category schema
const categorySchema: Schema = new Schema({
  name: { type: String, required: true },
  image: { type: String, required: true },
});

// Create a model based on the Category schema
const Category = mongoose.model<ICategory>('Category', categorySchema);

export { Category};