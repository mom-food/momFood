import React, { useState, useEffect } from "react";
import "./Navbar.css";
import { Link, useNavigate } from "react-router-dom";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
  faBagShopping,
  faBuilding,
  faCartShopping,
  faCircleExclamation,
  faCircleUser,
  faEarthAmericas,
  faHouse,
  faPlane,
  faRightToBracket,
  faUser,
  faUserPlus,
} from "@fortawesome/free-solid-svg-icons";
import axios from "axios";
import Loader from "../../shared/Loader";
export default function Navbar({ users, setUser }) {
  const token = localStorage.getItem("userToken");
  const [loader, setLoader] = useState(false);
  const [data, setData] = useState("");
  const navigate = useNavigate();
  const [navbarBackground, setNavbarBackground] = useState("");
  const [hasScrolled, setHasScrolled] = useState(false);

  useEffect(() => {
    window.addEventListener("scroll", handleScroll);
    return () => {
      window.removeEventListener("scroll", handleScroll);
    };
  }, []);

  const handleScroll = () => {
    const scrollPosition = window.scrollY;
    if (scrollPosition > 100) {
      setNavbarBackground("#eceae9");
      setHasScrolled(true);
    } else {
      setNavbarBackground("");
      setHasScrolled(false);
    }
  };

  const logout = () => {
    if (!users) {
      return;
    }

    localStorage.removeItem("userToken");
    navigate("/"); // Use the navigate function for redirection
    setUser(null);
  };

  if (loader) {
    return <Loader />;
  }
  
  return (
    <div className="back w-100 mt-0  d-flex justify-content-center">
      <nav
        className={`navbar navbar-expand-lg mt-0 z-2 pt-0 position-fixed`}
        style={{ backgroundColor: navbarBackground }}
      >
        <div className="container">
          <Link to="/">
            <img
              src="/images/momfood_logo.png"
              alt="logo"
              className={`mt-1 img-fluid rounded-pill   logo ${
                hasScrolled ? "scrolled" : ""
              } ${hasScrolled ? "logo-small" : ""}`}
            />
          </Link>
          <button
            className="navbar-toggler bg-primary bg-gradient"
            type="button"
            data-bs-toggle="collapse"
            data-bs-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent"
            aria-expanded="false"
            aria-label="Toggle navigation"
          >
            <span className="navbar-toggler-icon" />
          </button>
          <div
            className="text-info-navbar collapse navbar-collapse"
            id="navbarSupportedContent"
          >
            <ul className="navbar-nav ms-auto mb-2 mb-lg-0 text-center">
              
              <li className="nav-item">
                <Link
                  className="nav-link fs-4 active text-black"
                  aria-current="page"
                >
                  <FontAwesomeIcon icon={faHouse} className="pe-1" />
                  Home
                </Link>
              </li>
              <li className="nav-item">
                <Link
                  className="nav-link fs-4 text-black"
                  aria-current="page"
                  to="/tourlistweb"
                >
                  <FontAwesomeIcon icon={faBagShopping} className="pe-1" />
                  Products
                </Link>
              </li>
              <li className="nav-item">
                <Link className="nav-link fs-4 text-black" aria-current="page" to="/category">
                <FontAwesomeIcon icon={faCartShopping}className="pe-1" />
                  Add Gatgory
                </Link>
              </li>  
              <li className="nav-item dropdown me-2">
                <a
                  className="nav-link fs-4 dropdown-toggle text-black text-decoration-none"
                  href="#"
                  role="button"
                  data-bs-toggle="dropdown"
                  aria-expanded="false"
                >
                  <FontAwesomeIcon icon={faCircleUser} className="me-1" />
                  {data && data
                    ? data.userName.charAt(0).toUpperCase() +
                      data.userName.slice(1)
                    : "Account"}
                </a>
                <ul className="dropdown-menu w-25 m-auto dropdown-menu-start">
                  {!users ? (
                    <>
                      <li>
                        <Link
                          className="dropdown-item text-center text-black"
                          to="/register"
                        >
                          <FontAwesomeIcon
                            icon={faUserPlus}
                            className="pe-1 text-success"
                          />
                          Sign up
                        </Link>
                      </li>
                      <li>
                        <Link
                          className="dropdown-item text-center text-black"
                          to="/login"
                        >
                          <FontAwesomeIcon
                            icon={faRightToBracket}
                            className="pe-2 text-success"
                          />
                          Sign in
                        </Link>
                      </li>
                    </>
                  ) : (
                    <>
                      <li>
                        <Link
                          className="dropdown-item text-black"
                          to={`/user/profile/${users.id}`}
                        >
                          <FontAwesomeIcon icon={faUser} className="pe-2" />
                          Profile
                        </Link>
                      </li>
                      <li>
                        <Link
                          className="dropdown-item text-black"
                          onClick={logout}
                        >
                          <FontAwesomeIcon
                            icon={faRightToBracket}
                            className="pe-2 text-danger"
                          />
                          Log Out
                        </Link>
                      </li>
                    </>
                  )}
                </ul>
              </li>
              <li className="nav-item text-center">
                <Link
                  to="/about"
                  className="about fs-4 text-center btn nav-link btn-link text-decoration-none text-start"
                >
                  <FontAwesomeIcon
                    icon={faCircleExclamation}
                    className="pe-1"
                  />
                  About
                </Link>
              </li>
            </ul>
          </div>
        </div>
      </nav>
    </div>
  );
}
