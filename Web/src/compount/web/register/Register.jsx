import React, { useState } from "react";
import { useFormik } from "formik";
import axios from "axios";
import { toast } from "react-toastify";
import "./register.css";
import { registerValidation } from "../../shared/Validation";
import Inpute from "../../shared/Inpute";
import { useNavigate } from "react-router-dom";
const initialValues = {
  userName: "",
  email: "",
  password: "",
  dateOfBirth: "",
  country:"",
  phoneNumber:""
};

export default function Register() {
  const navigite = useNavigate();
  let [errorBack, setErrorBack] = useState("");
  const formik = useFormik({
    initialValues,
    onSubmit: async (values) => {
      try {
        const { data } = await axios.post(
          `https://dr-cecil-lab.onrender.com/auth/signup`,
          values
        );
        console.log(data);
        if (data.message == "success") {
          formik.resetForm();
          toast.success(
            "please verify your email to login",
            {
              position: "top-center",
              autoClose: 5000,
              hideProgressBar: false,
              closeOnClick: true,
              pauseOnHover: true,
              draggable: true,
              progress: undefined,
              theme: "light",
            }
          );
          navigite(`/`);
        }
      } catch (error) {
        if (error.response) {
          // The request was made and the server responded with a status code
          // that falls out of the range of 2xx
          setErrorBack(error.response.data.message); // Set error message from server response
        } else if (error.request) {
          // The request was made but no response was received
          setErrorBack("Network error. Please try again."); // Set network error message
        } else {
          // Something happened in setting up the request that triggered an Error
          setErrorBack("An unexpected error occurred. Please try again later."); // Set generic error message
        }
      }
    },
    validationSchema: registerValidation,
  });
  const inputs = [
    {
      type: "text",
      name: "userName",
      id: "userName",
      title: "Name",
      value: formik.values.userName,
    },
    {
      type: "email",
      name: "email",
      id: "email",
      title: "Email",
      value: formik.values.email,
    },
    {
      type: "password",
      name: "password",
      id: "password",
      title: "New password",
      value: formik.values.password,
    },
    {
      type: "password",
      name: "confirmPassword",
      id: "confirmPassword",
      title: "Re-enter password",
    },
    {
      type: "text",
      name: "country",
      id: "country",
      title: "country",
    },
    {
      type: "number",
      name: "phoneNumber",
      id: "phoneNumber",
      title: "phoneNumber",
    },
    {
      type: "date",
      name: "dateOfBirth",
      id: "dateOfBirth",
    },
  ];
  const renderInput = inputs.map((value, index) => (
    <Inpute
      type={value.type}
      id={value.id}
      title={value.title}
      key={index}
      name={value.name}
      value={value.value}
      onChange={formik.handleChange}
      onBlur={formik.handleBlur}
      touched={formik.touched}
      error={formik.errors}
    />
  ));
  return (
    <div className="bg-forms">
      <div className="container d-flex justify-content-center align-items-center vh-100">
        <div className="phone-width mt-5">
          <form onSubmit={formik.handleSubmit} className="forms p-1">
            {renderInput}
            <button
              type="submit"
              className="btn btn-primary"
              disabled={!formik.isValid}
            >
              Create new account
            </button>
            <div className="text-center w-100">
              {errorBack && <p className="text text-danger">{errorBack}</p>}
            </div>
          </form>
        </div>
      </div>
    </div>
  );
}
