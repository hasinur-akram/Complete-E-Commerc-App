import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  var _product;
  ProductDetails(this._product);
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(aspectRatio: 3.5,
                child: CarouselSlider(
                    items: widget._product['product-img']
                        .map<Widget>((item) => Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(item),
                            fit: BoxFit.fitWidth)
                    ),
                  ),
                )).toList(),
                    options: CarouselOptions(
                      autoPlay: false,
                    enlargeCenterPage: true,
                    viewportFraction: 0.8,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    onPageChanged: (val, carouselPageChangedReason){
                      setState(() {

                      });

                    }
                )),
              ),
              SizedBox(height: 10,),
              Text(widget._product['product-name']),
              SizedBox(height: 10,),
              Text(widget._product['product-price'].toString()),
              SizedBox(height: 10,),
              Text(widget._product['product-description'], textAlign: TextAlign.left),
            ],
          ),
        ),
      ),
    );
  }
}
