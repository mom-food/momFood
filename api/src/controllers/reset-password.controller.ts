import { Request, Response } from "express";
import { Meal } from "../models";
import { auth } from "firebase-admin";
import { getAuth } from "firebase-admin/auth";
 import { firebaseApp } from "../app";

export const resetPasswordRedirect = async (req: Request, res: Response) => {
   //Just redirect to momFood://resetPassword/?[KEEP QUERY STRING]
   momFood://resetPassword/action?mode=resetPassword&oobCode=YabS1kplkhO7VQwlnV5Rbgr6c3BBxV9F3x0zKUmIRH8AAAGPtJLUBQ&apiKey=AIzaSyAh1_uBnxz3toNPno1uvm0knZwtOwSKrek&lang=en
   
   http://localhost:3000/resetPassword?mode=resetPassword&oobCode=YabS1kplkhO7VQwlnV5Rbgr6c3BBxV9F3x0zKUmIRH8AAAGPtJLUBQ&apiKey=AIzaSyAh1_uBnxz3toNPno1uvm0knZwtOwSKrek&lang=en

  console.log(
    "User is trying to reset their password, req query is: ",
    req.query,
  );
  res.setHeader("Content-Type", "text/html");
  res.end(
    `
<a href="momFood://resetPassword/?${
      (Object.entries(req.query)).map(
        ([key, value]) => `${key}=${value}`,
      ).join("&")
    }">
  Click here to reset your password
</a>
`,
  );
};
 export const resetPassword = async (req: Request, res: Response) => {
  //Get parameters oobCode, apiKey, mode, password
   const oobCode = req.query.oobCode;
   const apiKey = req.query.apiKey;
   const mode = req.query.mode;
  const password = req.query.password;

   console.log(
    "User is trying to reset their password, req query is: ",
    req.query,
  );
};
