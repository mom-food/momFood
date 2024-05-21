import React from 'react';
import './footer.css';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import {
  faUtensils,
  faWineGlass,
  faConciergeBell,
  faPhone,
} from '@fortawesome/free-solid-svg-icons';
import {
  faFacebook,
  faInstagram,
  faTwitter,
  faYelp,
} from '@fortawesome/free-brands-svg-icons';

function Footer() {
  return (
    <div className="footer">
      <div className='container'>
        <div className="footer-logo"></div>
        <table>
          <thead>
            <tr>
              <th>About Our Restaurant</th>
              <th>Services</th>
              <th>Menus</th>
              <th>Contact Us</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>Our Story</td>
              <td>Book a Table</td>
              <td>Specials</td>
              <td><a href="https://www.facebook.com/YourRestaurant"><FontAwesomeIcon icon={faFacebook} className="brand fs-2" /></a></td>
            </tr>
            <tr>
              <td>Blog</td>
              <td>Catering Services</td>
              <td>Full Menu</td>
              <td><a href="https://www.instagram.com/YourRestaurant"><FontAwesomeIcon icon={faInstagram} className="brand fs-2" /></a></td>
            </tr>
            <tr>
              <td>Customer Reviews</td>
              <td>Private Events</td>
              <td>Beverages</td>
              <td><a href="https://www.twitter.com/YourRestaurant"><FontAwesomeIcon icon={faTwitter} className="brand fs-2" /></a></td>
            </tr>
            <tr>
              <td>Careers</td>
              <td>Online Order</td>
              <td>Desserts</td>
              <td><a href="https://www.yelp.com/YourRestaurant"><FontAwesomeIcon icon={faYelp} className="brand fs-2" /></a></td>
            </tr>
            <tr>
              <td>Privacy Policy</td>
              <td>FAQs</td>
              <td>Seasonal Menus</td>
              <td></td>
            </tr>
            <tr>
              <td>Terms of Service</td>
              <td>Gift Cards</td>
              <td>Kids' Menu</td>
              <td></td>
            </tr>
          </tbody>
        </table>
        <hr />
        <div className="word-spacing">
          <a href="support">Support</a>
          <a href="docs">Docs</a>
          <a href="terms">Terms of Use</a>
          <a href="privacy">Privacy Policy</a>
        </div>
        <div className="copyright">
          ©2023 RestaurantName All rights reserved.
        </div>
      </div>
    </div>
  );
}
export default Footer;
