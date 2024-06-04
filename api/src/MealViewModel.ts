// // MealViewModel.ts
// import { MealModel } from '../models/MealModel';

// export class MealViewModel {
//   private meal: MealModel;

//   constructor(meal: MealModel) {
//     this.meal = meal;
//   }

//   get id(): string {
//     return this.meal._id;
//   }

//   get name(): string {
//     return this.meal.name;
//   }

//   get discountedPrice(): number {
//     // Apply 20% discount
//     return this.meal.price * 0.8;
//   }

//   get image(): string {
//     return this.meal.image;
//   }

//   get categoryID(): string {
//     return this.meal.categoryID;
//   }

//   get categoryName(): string {
//     return this.meal.category_name;
//   }

//   get description(): string {
//     return this.meal.description;
//   }

//   get category(): string {
//     return this.meal.category;
//   }
// }

// // Node.js code to fetch meals from MongoDB and convert them to MealViewModels

// import { MealModel } from './MealModel';
// import { MealViewModel } from './MealViewModel';

// const url = 'localhost:3000/api/meals/meals'; // MongoDB connection URL
// const dbName = 'momfood'; // Name of your MongoDB database
// const collectionName = 'meals'; // Name of the collection storing meals

// async function fetchMealsFromDB(): Promise<MealModel[]> {
//   let client: MongoClient;
//   try {
//     // Connect to MongoDB
//     client = await MongoClient.connect(url);
//     const db: Db = client.db(dbName);
//     const collection: Collection = db.collection(collectionName);

//     // Fetch meals
//     const mealsCursor = collection.find({});
//     const meals: MealModel[] = await mealsCursor.toArray();

//     return meals;
//   } catch (error) {
//     console.error('Error fetching meals from MongoDB:', error);
//     throw error;
//   } finally {
//     // Close the MongoDB connection
//     if (client) {
//       client.close();
//     }
//   }
// }

// async function getMealViewModels(): Promise<MealViewModel[]> {
//   const meals = await fetchMealsFromDB();
//   return meals.map(meal => new MealViewModel(meal));
// }
