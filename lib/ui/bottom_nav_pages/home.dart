import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce/const/AppColors.dart';
import 'package:ecommerce/ui/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List <String> _carouselImages = [];
  var _dotPosition = 0;
  List _products = [];
  var _firestoreInstance = FirebaseFirestore.instance;


  fetchCarouselImages()async{

    QuerySnapshot qn =
    await _firestoreInstance.collection("carousel-slider").get();
    setState(() {
      for(int i = 0; i<qn.docs.length; i++){
        _carouselImages.add(
          qn.docs[i]['img-path'],
        );
        print(qn.docs[i]['img-path']);

      }
    });
  }

  fetchProducts()async{

    QuerySnapshot qn =
    await _firestoreInstance.collection("products").get();
    setState(() {
      for(int i = 0; i<qn.docs.length; i++){
        _products.add(
          {
            "product-name": qn.docs[i]['product-name'],
            "product-description": qn.docs[i]['product-description'],
            "product-price": qn.docs[i]['product-price'],
            "product-img": qn.docs[i]['product-img'],
          }
        );



      }
    });
  }


  @override
  void initState() {
    fetchCarouselImages();
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.w,right: 20.w),
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      fillColor: Colors.grey,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          borderSide: BorderSide(
                            color: Colors.cyan,
                          )
                      ),
                      hintText: 'Search your App Here',
                      hintStyle: TextStyle(fontSize: 15.sp),
                    ),
                    onTap: ()=>Navigator.push(context, CupertinoPageRoute(builder: (_)=>SearchScreen())),
                  ),
                ),
                SizedBox(height: 10.h,),
                AspectRatio(aspectRatio: 3.5,
                  child: CarouselSlider(items: _carouselImages.map((item) => Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(item),fit: BoxFit.fitWidth)
                      ),
                    ),
                  )).toList(), options: CarouselOptions(
                    enlargeCenterPage: true,
                    viewportFraction: 0.8,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    onPageChanged: (val, carouselPageChangedReason){
                      setState(() {
                        _dotPosition=val;
                      });

                    }
                  )),
                ),
                SizedBox(height: 10.h,),

                DotsIndicator(
                  dotsCount: _carouselImages.length==0?1:_carouselImages.length,
                  position: _dotPosition.toDouble(),
                  decorator: DotsDecorator(
                    activeColor: AppColors.deep_orange,
                    color: AppColors.deep_orange.withOpacity(0.5),
                    spacing: EdgeInsets.all(2),
                    activeSize: Size(8, 8),
                    size: Size(6, 6),
                  ),
                ),
                SizedBox(height: 15.h,),
                Expanded(
                  child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: _products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,childAspectRatio: 1),
                      itemBuilder: (_,index){
                    return Card(
                      elevation: 3,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            AspectRatio(aspectRatio: 2,child: Container(child: Image.network(_products[index]['product-img'][0]))),
                            SizedBox(height: 15.h,),
                            Text("${_products[index]["product-name"]}"),
                            SizedBox(height: 10.h,),
                            Text("${_products[index]["product-price"].toString()}"),
                          ],
                        ),
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      
    );
  }
}
