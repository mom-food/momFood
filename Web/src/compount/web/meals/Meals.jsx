import axios from 'axios';
import React, { useEffect, useState } from 'react';
import { Link, useParams } from 'react-router-dom';
import Loader from '../../shared/Loader';
import { Swiper, SwiperSlide } from 'swiper/react';
import 'swiper/css';
import './meals.css';

export default function Meals() {
    const [meal, setMeal] = useState([]);
    const [isLoading, setIsLoading] = useState(true);
    const [error, setError] = useState(null);
    const { _id } = useParams();

    useEffect(() => {
        const getMeal = async () => {
            try {
                setIsLoading(true);
                const response = await axios.get(`http://https://momfood.onrender.com
/api/meals/meals/${_id}`);
                setMeal(response.data);
            } catch (error) {
                console.error('Error fetching meal:', error);
                setError('Failed to fetch meal.');
            } finally {
                setIsLoading(false);
            }
        };

        if (_id) getMeal();
    }, [_id]);

    if (isLoading) {
        return <Loader />;
    }

    if (error) {
        return <div>Error: {error}</div>;
    }

    return (
        <div className="category py-5 mt-5">
            <div className="categories container d-flex flex-wrap">
                {meal.length ? (
                    meal.map((category) => (
                        <div key={category._id} className="meal-card">
                            <Link to={`/meals/${category._id}`} className="text-decoration-none">
                                <img src={category.image} alt={`${category.name} Image`} />
                                <h2 className="fs-5">{category.name}</h2>
                            </Link>
                            <div className="action-buttons">
                                <Link to={`/update/meals/${category._id}`} className="btn btn-primary">
                                    Update
                                </Link>
                                <Link to={`/delete/meals/${category._id}`} className="btn btn-primary ms-2">
                                    Delete
                                </Link>
                            </div>
                        </div>
                    ))
                ) : (
                    <p>No data available</p>
                )}
            </div>
        </div>
    );
}
