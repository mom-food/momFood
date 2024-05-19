import React, { useState, useEffect } from "react";
import axios from "axios";
import { toast } from "react-toastify";
import { Link, useNavigate } from "react-router-dom";
import Loader from "../../shared/Loader";
import { Navigation, Pagination, Autoplay } from "swiper/modules";
import { Swiper, SwiperSlide } from "swiper/react";
import "swiper/css";
import "swiper/css/navigation";
import "swiper/css/pagination";
import "swiper/css/scrollbar";
import './Home.css'
export default function Home() {
  const navigate = useNavigate();
  const [loading, setLoading] = useState(true);
  const [categories, setCategories] = useState([]);
  const [data, setData] = useState([]);

  const getCategories = async () => {
    try {
      const response = await axios.get(`http://localhost:3000/api/categories`);
      setData(response.data); // Assuming your API returns { categories: [] }
      console.log(response.data);
    } catch (error) {
      console.error('Error fetching categories:', error);
      toast.error("Failed to fetch categories");
    }
  };

  useEffect(() => {
    getCategories();
    setLoading(false);
  }, []);

  if (loading) {
    return <Loader />;
  }

  return (
    <section id="about">
       {/*start header*/}
     {/*start header*/}
     <div className="header-img">
        <div className="m-0 p-0">
          <header className="header d-flex justify-content-center align-items-end ">
            <div className="w-100 ">
              <h3 className="fs-1 mb-5 d-flex justify-content-start">
                A Deep Dive Into Our HOME Food
              </h3>
            </div>
          </header>
        </div>
      </div>
      {/*start header*/}

      {/*start header*/}
      <div className="category py-5 mt-5">
        <div className="categories container d-flex ">
          <Swiper 
            navigation
            pagination={{ clickable: true }}
            autoplay={{ delay: 3000, disableOnInteraction: false }}
            loop={true}
            spaceBetween={50}
            breakpoints={{
              600: { slidesPerView: 3},
              768: { slidesPerView: 3 },
              1024: { slidesPerView: 3 },
            }}
          >
            {data.length ? (
              data.map((category) => (
                <SwiperSlide key={category._id}>

                  <Link to={`/meals/${category._id}`} className="text-decoration-none">
                    <div className="d-flex justify-content-center categories-admin-imgae">
                      <img src={category.image} className="w-100" alt={`${category.name} Image`} />
                    </div>
                    <div className="text-center pt-3">
                      <h2 className="fs-5 ps-4">{category.name}</h2>
                      <Link to={`update/category/${category._id}`} className="btn btn-primary">Update</Link>
                      <Link to={`delete/category/${category._id}`} className="btn btn-primary ms-2">Delete</Link>
                      <Link to={`/add/meals/${category._id}`} className="btn btn-primary ms-2">Add Meals</Link>
                    </div>
                  </Link>
                </SwiperSlide>
              ))
            ) : (
              <p>No data available</p>
            )}
          </Swiper>
        </div>
      </div>
    </section>
  );
}
