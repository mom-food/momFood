import express from "express";
import connectDB  from './database';
import dotenv from "dotenv";
import router from './routes';
// Load environment variables from .env file
dotenv.config()

connectDB();
const app = express();
const PORT = process.env.PORT || 3000;

app.use('/', router);

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});