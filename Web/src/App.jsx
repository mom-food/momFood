import React, { useEffect, useState } from "react";
import { RouterProvider } from "react-router-dom";
import { createBrowserRouter } from "react-router-dom";
import Layout from "./compount/layout/Layout.jsx";
import Home from "./compount/web/home/Home.jsx";
import Layoutadmin from "./compount/layout/Layoutadmin.jsx";
import AHome from "./compount/admin/home/Home.jsx";
import Page from "./compount/web/PageNotFound/Page.jsx";
import Apage from "./compount/admin/Pagenotfound/Page.jsx";
import Register from "./compount/web/register/Register.jsx";
import Login from "./compount/web/login/Login.jsx";
import { jwtDecode } from "jwt-decode";
import Admin from "./compount/admin/Admin/getadmin/Admin.jsx";
import Creatadmin from "./compount/admin/Admin/creatadmin/Creatadmin.jsx";
import SendCode from "./compount/web/sendcode/SendCode.jsx";
import Forget from "./compount/web/forgetpassword/Forget.jsx"
import Protected from "./compount/web/routeProteced/Protected.jsx";
import LoginProtected from "./compount/web/routeProteced/LoginProtected.jsx";
import ProtectedWeb from "./compount/web/routeProteced/ProtectedWeb.jsx";
import Users from "./compount/admin/Users/Users.jsx";
import About from "./compount/web/about/About.jsx";
import CreateCatgories from './compount/web/category/CreateCatgories.jsx'
import DeleteCategory from "./compount/web/category/DeleteCategory.jsx";
import Update from "./compount/web/category/Update.jsx";
import Meals from "./compount/web/meals/Meals.jsx";
import UpdateMeals from "./compount/web/meals/UpdateMeals.jsx";
import Deletemeals from "./compount/web/meals/Deletemeals.jsx";
import Addmeals from "./compount/web/meals/Addmeals.jsx";

export default function App() {
  const [users, setUser] = useState(null);
  const saveCurrentUser = () => {
    const token = localStorage.getItem("userToken");
    const decode = jwtDecode(token);
    setUser(decode);
  };
  useEffect(()=>{
    if(localStorage.getItem("userToken")){
      saveCurrentUser();
    }
  },[])
  const router = createBrowserRouter([
    {
      path: "/",
      element:
      <ProtectedWeb>
        <Layout users={users} setUser={setUser} />
      </ProtectedWeb>
        ,
      children: [
        {
          path: "/",
          element: <Home users={users} />,
        },
        {
          path: "about",
          element: <About />,
        },
        {
          path: "register",
          element: <Register />,
        },
        {
          path: "meals/:_id",
          element: <Meals />,
        },
        {
          path: "delete/meals/:_id",
          element: <Deletemeals/>,
        }, 
        {
          path: "update/meals/:_id",
          element: <UpdateMeals />,
        },
        {
          path: "add/meals/:_id",
          element: <Addmeals />,
        },
        {
          path: "category",
          element: <CreateCatgories />,
        },
        {
          path: "update/category/:_id",
          element: <Update />,
        },
        {
          path: "delete/category/:_id",
          element: <DeleteCategory />,
        },
        {
          path: "auth/sendCode",
          element: <SendCode />,
        },
        {
          path: "auth/forgetPassword",
          element: <Forget />,
        },
        {
          path: "login",
          element: (
            <LoginProtected users={users}>
              <Login saveCurrentUser={saveCurrentUser} users={users} />
            </LoginProtected>
          ),
        },
        {
          path: "*",
          element: <Page />,
        },
      ],
    },
    {
      //admin end point
    },
    {
      path: "/admin",
      element: (
        <Protected users={users} setUser={setUser}>
          <Layoutadmin users={users} setUser={setUser} />
        </Protected>
      ),
      children: [
        {
          path: "",
          element: <AHome />,
        },
        {
          path: "getAdmin",
          element: <Admin users={users}/>,
        },
        {
          path:"getUsers",
          element:<Users />
        },
        {
          path: "CreateAdmin",
          element: <Creatadmin />,
        },
        {
          path: "*",
          element: <Apage />,
        },
      ],
    },
  ]);
  return <RouterProvider router={router} />;
}
