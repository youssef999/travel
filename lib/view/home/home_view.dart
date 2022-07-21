import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/services/data_controller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ecommerce/view/hotel&trips/all_trips.dart';
import 'package:ecommerce/view/hotel&trips/details_view2.dart';
import 'package:ecommerce/view/hotel&trips/details_view3.dart';
import 'package:ecommerce/view/hotel&trips/hotelsview.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:ecommerce/view/search/search_view.dart';
import 'package:ecommerce/viewmodel/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../widgets/custom_text.dart';





class HomeView extends StatefulWidget {
  String email;
  HomeView({this.email});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isExecuted = false;



  double position=260.0;



  @override
  Widget build(BuildContext context) {

    TextEditingController search_txt = new TextEditingController();
    QuerySnapshot querySnapshot;
    final box = GetStorage();
    String box_token = box.read('token') ?? "x";
    String lang=box.read("lang") ?? 'x';
    if(lang=="en"){
      position=260.0;
    }
    if(lang=="ar"){
      position=20.0;
    }

    Widget searchedData() {
      return ListView.builder(
          itemCount: querySnapshot.docs.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage:
                    NetworkImage(querySnapshot.docs[index].data()['image']),
              ),
              title: Text(querySnapshot.docs[index].data()['name']),
            );
          });
    }


    return GetBuilder<HomeViewModel>(
      init: Get.find(),
      builder: (controller) => controller.loading.value
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
              appBar:
              AppBar(
                toolbarHeight: 0,
                elevation: 0,
                backgroundColor: Colors.yellow,
                iconTheme: IconThemeData(
                  color: Colors.yellow,
                ),
                title: Container(
                  height: 10,
                ),
              ),

              body: isExecuted
                  ? searchedData
                  : Container(

                      margin: EdgeInsets.only(right: 15, left: 15),
                      child: ListView(
                          children: [

                        SizedBox(height: 25),
                        GetBuilder<DataController>(
                            init: DataController(),
                            builder: (controller) => _searchTextFormField()),
                        SizedBox(height: 25),

                        Container(
                          margin: EdgeInsets.only(left: 15, right: 15),
                        ),

                        _listViewCarsoul(),
                        SizedBox(height: 30),
                        Row(children: [

                          Custom_Text(
                            text: "25".tr,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Spacer(),
                          InkWell(
                            child: Custom_Text(
                              text: "26".tr,
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                            onTap: () {
                              Get.put(HomeViewModel());
                              Get.to(HotelsView());
                            },
                          ),
                        ]),
                        SizedBox(height: 15),
                        _listViewHotels(),
                        SizedBox(height: 50),
                        Row(
                          children: [
                            Custom_Text(
                              text: "27".tr,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 160,
                            ),
                            InkWell(
                              child: Custom_Text(
                                text: "63".tr,
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                              onTap: () {
                                Get.put(HomeViewModel());
                                Get.to(AllTrips());
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        _listViewTrips(),
                        SizedBox(height: 10),
                      ]),
                    )),
    );
  }

  Widget _searchTextFormField() {
    TextEditingController search_txt = new TextEditingController();
    QuerySnapshot querySnapshot;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade200,
      ),
      child: GetBuilder<DataController>(
          init: DataController(),
          builder: (controller) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children:[
              TextFormField(
                controller: search_txt,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "   "+"64".tr,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ))),
                Positioned(
                  top:10,
                  left: position,
                  child: InkWell(
                      child: Icon(Icons.search, color: Colors.black),
                      onTap: () {
                        controller.queryData(search_txt.text).then((value) {
                          querySnapshot = value;
                          isExecuted = true;
                          print("issss" + isExecuted.toString());
                          print("qqq=" + querySnapshot.docs.toString());
                          print("sss=" + search_txt.text.toString());
                          Get.to(SearchView(
                            search_txt: search_txt.text.toString()
                          ));
                        });
                      }),
                ),




              ]

            ),
          )
          //}
          ),
    );
  }

  Widget _listViewTrips() {
    return GetBuilder<HomeViewModel>(
      init: Get.find(),
      builder: (controller) => SingleChildScrollView(
        child: Container(
          height: 242,
          child: ListView.separated(
            itemCount: controller.categoryModel.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                child: InkWell(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                            child: Container(
                              width: MediaQuery.of(context).size.width * .5,
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
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ]),
                              height: 180,
                              child: Container(
                                height: 244,
                                child: Image.network(
                                  controller.categoryModel[index].image,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            onTap: () {

                              Get.put(HomeViewModel());
                              Get.to(DetailsView3(
                                name: controller.categoryModel[index].name,
                                details: controller.categoryModel[index].des,
                                price: controller.categoryModel[index].price,
                                image: controller.categoryModel[index].image,
                                city: controller.categoryModel[index].city,
                              ));
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        Custom_Text(
                          text: controller.categoryModel[index].name.toString(),
                          alignment: Alignment.bottomCenter,
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        RatingBar(
                          ignoreGestures: true,
                          initialRating: controller.categoryModel[index].star,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 18,
                          maxRating: 5,
                          ratingWidget: RatingWidget(
                            full: Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            half: Icon(
                              Icons.star_half_outlined,
                              color: Colors.yellow,
                            ),
                            empty: Icon(
                              Icons.star_border,
                              color: Colors.yellow,
                            ),
                          ),
                          //   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                        SizedBox(
                          height: 2,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Get.put(HomeViewModel());
                    Get.to(DetailsView3(
                      name: controller.categoryModel[index].name,
                      price: controller.categoryModel[index].price,
                      details: controller.categoryModel[index].des,
                      image: controller.categoryModel[index].image,
                    ));
                  },
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
              width: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _listViewCarsoul() {
    return GetBuilder<HomeViewModel>(
      init: Get.find(),
      builder: (controller) => SingleChildScrollView(
        child: Container(
          height: 240,
          //width:500,
          child: ListView.separated(
            itemCount: controller.carsoulModel.length,
            //scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                child: Container(
                  height: 202,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  //  height: 150,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    )),
                    child: Carousel(
                      borderRadius: true,
                      radius: Radius.circular(30),
                      autoplay: true,
                      animationCurve: Curves.fastOutSlowIn,
                      animationDuration: Duration(milliseconds: 1250),
                      dotSize: 4.0,
                      dotIncreasedColor: Colors.yellow,
                      dotBgColor: Colors.transparent,
                      noRadiusForIndicator: true,
                      dotPosition: DotPosition.bottomCenter,
                      showIndicator: true,
                      boxFit: BoxFit.fill,
                      images: [
                        NetworkImage(
                          controller.carsoulModel[index].img1,
                          scale: 1.0,
                        ),
                        NetworkImage(controller.carsoulModel[index].img2),
                        NetworkImage(controller.carsoulModel[index].img3),
                        NetworkImage(controller.carsoulModel[index].img4),
                        NetworkImage(controller.carsoulModel[index].img5),
                        NetworkImage(controller.carsoulModel[index].img6),
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
              width: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _listViewHotels() {
    return GetBuilder<HomeViewModel>(
      init: Get.find(),
      builder: (controller) => SingleChildScrollView(
        child: Container(
          height: 235,
          child: ListView.separated(
            itemCount: controller.productModel.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    // color: Colors.orange,
                    shape: BoxShape.circle),
                child: InkWell(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                            child: Container(
                              width: MediaQuery.of(context).size.width * .5,
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
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ]),
                              height: 170,
                              child: Container(
                                height: 244,
                                child: Image.network(
                                    controller.productModel[index].image,
                                    fit: BoxFit.fill),
                              ),
                            ),
                            onTap: () {
                              //   intersitialAd.show();
                              Get.to(DetailsView2(
                                name: controller.productModel[index].name,
                                price: controller.productModel[index].price,
                                details: controller.productModel[index].des,
                                image: controller.productModel[index].image,
                                city: controller.productModel[index].city,

                              ));
                            }),
                        SizedBox(height: 10),
                        Custom_Text(
                          text: controller.productModel[index].name.toString(),
                          alignment: Alignment.bottomLeft,
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        RatingBar(
                          ignoreGestures: true,
                          initialRating: controller.productModel[index].star,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 18,
                          maxRating: 5,
                          ratingWidget: RatingWidget(
                            full: Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            half: Icon(
                              Icons.star_half_outlined,
                              color: Colors.yellow,
                            ),
                            empty: Icon(
                              Icons.star_border,
                              color: Colors.yellow,
                            ),
                          ),
                          //   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                        SizedBox(
                          height: 2,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {

                    Get.to(DetailsView2(
                      name: controller.productModel[index].name,
                      price: controller.productModel[index].price,
                      details: controller.productModel[index].des,
                      image: controller.productModel[index].image,
                      city: controller.productModel[index].city,
                    ));
                  },
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
              width: 20,
            ),
          ),
        ),
      ),
    );
  }
}
