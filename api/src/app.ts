import express from "express";
import connectDB from './database';
import dotenv from "dotenv";
import router from './routes';
import cors from 'cors';  // Import CORS module
import fs from "node:fs";

dotenv.config()

connectDB();
const app = express();
const PORT = process.env.PORT || 3000;
const corsOptions = {
  origin: ['http://localhost:3000', 'https://momfood.onrender.com'],
  optionsSuccessStatus: 200
};
// Use CORS
//app.use(cors());
app.use(express.json());
app.use('/api', router);
app.use(express.static('src/public'))

app.listen(PORT, () => {
  console.log(`Server is running on https://momfood.onrender.com:${PORT}`);
});
