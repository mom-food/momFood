
# MomFood Web App

The MomFood web application facilitates meal creation for users (moms) and enables clients to place orders via the mobile application. Upon receiving an order, moms will receive notifications to confirm the order. The system supports real-time communication between moms and clients through notifications.
## Customer Segments (Audience):
People who work far from home wanting homemade meals and students in dorms seeking a taste of home. Palestinian chefs known for authentic dishes and sweets.

## Key Features:

##### Meal Creation:Moms can easily create and manage meal dishes.
##### Order Placement: Clients can conveniently place orders using the mobile application.
##### Real-time Notifications: Moms receive notifications upon receiving new orders, allowing them to confirm orders promptly.
##### User Profiles: Moms and clients can create profiles with work and personal  information and preferences.
##### Order History: Users can view previous orders and track their order history.


## Purpose:
The MomFood web app aims to streamline meal creation, order placement, and confirmation processes, providing an efficient and user-friendly experience for moms and clients.

## How

We implemented the following technologies and frameworks to develop the system:

- **Web Development**: Laravel was utilized to manage CRUD operations for meals and categories. The system allows chefs to prepare meals and receive orders through notifications for preparation.

- **Mobile App Development**: The app was developed using the Flutter framework with Dart language. Users can view meals and categories through the app.

- **Data Storage**:
  - Meal and categories data are stored in MongoDB.
  - Authentication, notification, and order operations data are stored in Firebase.

- **API Management**:
  - Network layers (API) are managed using Node.js and TypeScript.
  - Express framework is employed for building the APIs.

