// src/controllers/resetPasswordController.ts

import { Request, Response } from "express";

export const resetPasswordRedirect = async (req: Request, res: Response) => {
  try {
    console.log("User is trying to reset their password, req query is: ", req.query);

    // Construct the query string from the request query parameters
    const queryString = Object.entries(req.query)
      .map(([key, value]) => `${key}=${value}`)
      .join("&");

    // Construct the custom URL
    const customUrl = `momFood://resetPassword/?${queryString}`;

    // Respond with an HTML link
    res.setHeader("Content-Type", "text/html");
    res.end(
      `<a href="${customUrl}">
        Click here to reset your password
      </a>`
    );
  } catch (error) {
    console.error("Error in resetPasswordRedirect:", error);
    res.status(500).send("Internal Server Error");
  }
};
