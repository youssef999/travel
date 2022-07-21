
import 'package:ecommerce/view/booking/booking_form.dart';
import 'package:ecommerce/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DetailsView2 extends StatefulWidget {
  String name;
  String city;
  String details;
  String image;
  int price;

  DetailsView2({
    this.name,
    this.image,
    this.price,
    this.details,
    this.city,
  });

  @override
  State<DetailsView2> createState() => _DetailsView2State();
}

class _DetailsView2State extends State<DetailsView2> {
  int index = 0;

  String lg = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.yellow,
        elevation: 0,
      ),

      body: Container(
        child: Column(
          children: [
            SizedBox(height: 6),
            Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .width - 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ]),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image.network(widget.image, fit: BoxFit.cover))),


            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(17),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Custom_Text(
                              text: widget.name.toString(),
                              fontSize: 26,
                              color: Colors.black),
                          SizedBox(height: 10,),
                          Custom_Text(
                              text: '76'.tr + " " + widget.city + " ",
                              fontSize: 18,
                              color: Colors.black
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Custom_Text(
                            text: '40'.tr,
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 90,
                          ),

                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(widget.details,
                            style: TextStyle(
                                color: Colors.black, fontSize: 16)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(widget.price.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                height: 56,
                width: double.infinity,
                child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.yellow,
                    onPressed: () {
                      Get.to(BookingForm(
                        city: widget.city,
                        trip: widget.name,
                        price: widget.price,
                      ));
                    },
                    child: Text(
                      "42".tr,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w700
                      ),
                    )),
              ),
            ),
            Container(height: 30),


          ],
        ),
      ),
    );
  }

}
