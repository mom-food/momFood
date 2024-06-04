import express from "express";
import connectDB from "./database";
import dotenv from "dotenv";
import router from "./routes";
// import { initializeApp } from "firebase-admin/app";
// import { getAuth } from "firebase-admin/auth";
// import { credential } from "firebase-admin";
import fs from "node:fs";
dotenv.config();

connectDB();
// static const FirebaseOptions android = FirebaseOptions(
//   apiKey: 'AIzaSyAh1_uBnxz3toNPno1uvm0knZwtOwSKrek',
//   appId: '1:175323531680:android:5cb7cd5c3878a57d47fcc5',
//   messagingSenderId: '175323531680',
//   projectId: 'momfood-6ae63',
//   storageBucket: 'momfood-6ae63.appspot.com',
// );
//

// export const firebaseApp = initializeApp({
//   credential: credential.cert("serviceAccountKey.json"),
// });
// const auth = getAuth(firebaseApp);
// void (async () => {
//   console.log(await auth.listUsers());
// })();

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());
app.use("/api", router);
app.use(express.static("src/public"));

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
