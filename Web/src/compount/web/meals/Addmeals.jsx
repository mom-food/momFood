import React, { useState } from "react";
import { useFormik } from "formik";
import axios from "axios";
import { toast } from "react-toastify";
import { useNavigate, useParams } from "react-router-dom";
import Inpute from "../../shared/Inpute";

export default function CreateAdmin() {
    const navigite = useNavigate();
    let [errorBack, setErrorBack] = useState("");
    const {_id}=useParams();
    console.log(_id);
    const formik = useFormik({
        initialValues : {
            name: "",
            image: "",
            description: "",
            price: "",
            category: _id,
        },
        onSubmit: async (values) => {
            try {
                const token = localStorage.getItem("userToken");
                const { data } = await axios.post(
                    `http://localhost:3000/api/meals`,
                    values,
                );
                console.log(data);
                if (data.message == "success") {
                    formik.resetForm();
                    toast.success("create category success", {
                        position: "top-center",
                        autoClose: 5000,
                        hideProgressBar: false,
                        closeOnClick: true,
                        pauseOnHover: true,
                        draggable: true,
                        progress: undefined,
                        theme: "light",
                    });
                    navigite("/admin/getAdmin");
                }
            } catch (error) {
                setErrorBack(error.response.data.message);
            }
        },
    });
    const inputs = [
        {
            name: "name",
            type: "text",
            id: "name",
            title: "Name",
            value: formik.values.name,
        },
        {
            name: "image",
            type: "text",
            id: "image",
            title: "image",
            value: formik.values.image,
        },
        {
            name: "description",
            type: "text",
            id: "description",
            title: "description",
            value: formik.values.description,
        }, {
            name: "price",
            type: "Number",
            id: "price",
            title: "price",
            value: formik.values.price,
        }
    ];

    const renderInput = inputs.map((input, index) => {
        return (
            <Inpute
                key={index}
                name={input.name}
                type={input.type}
                title={input.title}
                id={input.id}
                value={input.value}
                onChange={formik.handleChange}
                onBlur={formik.handleBlur}
                touched={formik.touched}
                error={formik.errors}
            />
        );
    });
    return (
        <div className="bg-forms py-5">
            <div className="container py-4 d-flex justify-content-center align-items-center ">
                <div className="phone-width">
                    <h2></h2>
                    <form onSubmit={formik.handleSubmit} className="forms p-3">
                        {renderInput}
                        <button type="submit" className="btn btn-primary w-100">
                            Create Category
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
