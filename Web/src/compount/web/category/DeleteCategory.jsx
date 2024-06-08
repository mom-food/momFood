import axios from 'axios';
import React, { useEffect, useState } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import Loader from '../../shared/Loader';
import { toast } from 'react-toastify';

export default function DeleteCategory() {
    const { _id } = useParams();
    const [loading, setLoading] = useState(false);
    const navigate = useNavigate();

    const handleDeleteConfirmation = () => {
        const isConfirmed = window.confirm('Are you sure you want to delete this tour?');

        if (isConfirmed) {
            removeTour();
        } else {
            navigate('/admin'); // Navigate away or handle otherwise as per design requirements
        }
    };

    const removeTour = async () => {
        try {
            setLoading(true);
            const token = localStorage.getItem('userToken');
            const { data } = await axios.delete(
                `http://https://momfood.onrender.com
/api/meals/${_id}`, {
                    headers: { Authorization: `Bearer ${token}` }
                }
            );
            console.log(data);
            if (data.message === 'success') {
                toast.success('Tour successfully deleted.', {
                    position: 'top-center',
                    autoClose: 5000,
                    hideProgressBar: false,
                    closeOnClick: true,
                    pauseOnHover: true,
                    draggable: true,
                    progress: undefined,
                    theme: 'light',
                });
                navigate('/');
            } else {
                toast.error('Delete failed. Please try again.', {
                    position: 'top-center',
                    autoClose: 5000,
                    hideProgressBar: false,
                    closeOnClick: true,
                    pauseOnHover: true,
                    draggable: true,
                    progress: undefined,
                    theme: 'light',
                });
            }
        } catch (error) {
            console.error('Error deleting tour:', error);
            toast.error('An unexpected error occurred. Please try again later.', {
                position: 'top-center',
                autoClose: 5000,
                hideProgressBar: false,
                closeOnClick: true,
                pauseOnHover: true,
                draggable: true,
                progress: undefined,
                theme: 'light',
            });
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        handleDeleteConfirmation(); // Show the confirmation dialog on component mount
    }, []);

    if (loading) {
        return <Loader />;
    }

    return <div>Delete Tour</div>; // This can be styled or modified as needed.
}
