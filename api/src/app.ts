import express from "express";
import connectDB  from './database';
import dotenv from "dotenv";
import router from './routes';
dotenv.config()

connectDB();
const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());
app.use('/api', router);
app.use(express.static('src/public'))

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});