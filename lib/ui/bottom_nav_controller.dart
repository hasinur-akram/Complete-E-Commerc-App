import 'package:ecommerce/ui/bottom_nav_pages/cart.dart';
import 'package:ecommerce/ui/bottom_nav_pages/favourite.dart';
import 'package:ecommerce/ui/bottom_nav_pages/home.dart';
import 'package:ecommerce/ui/bottom_nav_pages/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../const/AppColors.dart';

class BottomNavController extends StatefulWidget {
  @override
  _BottomNavControllerState createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  final _pages = [
    Home(),
    Cart(),
    Favourite(),
    Profile(),
  ];
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'E-Commerce',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        selectedItemColor: AppColors.deep_orange,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        selectedLabelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
        items: [

        BottomNavigationBarItem(

            icon: Icon(Icons.home),
            label: 'Home',
        ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            label: 'Cart',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Favorite',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Person',
          ),

      ],),
      body: _pages[_currentIndex],
    );
  }
}

//Navigator.push(context, CupertinoPageRoute(builder: (_)=>Profile())));
//child: IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.arrow_back,color: Colors.white,),),

