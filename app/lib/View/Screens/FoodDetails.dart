import 'package:flutter/material.dart';

import '../../colors.dart';

class FoodDetailsPage extends StatelessWidget {


  FoodDetailsPage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Order / Food Details', style: Theme.of(context).textTheme.headline6?.copyWith(
          fontSize: 22,
          color: Colors.white, // Ensuring good contrast against the AppBar background
          fontWeight: FontWeight.bold,
        )),
        actions: [
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image.asset('assets/images/mansaf.jpg', fit: BoxFit.cover), // Image section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('₪29', style: Theme.of(context).textTheme.headline6?.copyWith(
                      fontSize: 24, // Slightly larger font size for visibility
                      color: Colors.black87, // Enhanced text color for better readability
                      fontWeight: FontWeight.bold,
                    )),
                    Text('منسف أردني', style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontSize: 24,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    )),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    color: Colors.white.withOpacity(0.5), // Set opacity to 50%
                    padding: const EdgeInsets.all(16.0), // Add padding to the container
                    child: Text(
                      'هو ثريد لحم الضان ولبن وخبز القمح البلدي...',
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        shadows: [
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 3.0,
                            color: Color.fromARGB(150, 0, 0, 0),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl, // Set text direction to right-to-left
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
              },
              child: Text('أضف إلى السلة', style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Text color on button for contrast
              )),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50), backgroundColor: AppColors.primary1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}