import 'package:admob_flutter/admob_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/viewmodel/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'details_view3.dart';



class AllTrips extends StatefulWidget {
  String cat;

  AllTrips({this.cat});

  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<AllTrips> {
  String allposts;
  String v;
  TextEditingController _searchController = TextEditingController();
  Future resultsLoaded;
  List _allResults = [];
  List _resultsList = [];

  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  final _nativeAd = NativeAdmobController();
  AdmobBannerSize bannerSize;
  AdmobInterstitial intersitialAd;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.yellow,
          elevation: 0,
        ),
        body: Container(
          color: Colors.white38,
          child: Column(children: [

            SizedBox(
              height: 7,
            ),

            Flexible(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(
                          'services') //.where('cat',isEqualTo:widget.cat)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData)
                      return Center(child: Text('Loading'));
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return new Text('Loading...');
                      default:
                        return ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (BuildContext context, int index) {
                              DocumentSnapshot posts =
                                  snapshot.data.documents[index];

                              return GetBuilder<HomeViewModel>(
                                  init: Get.find(),
                                  builder: (controller) =>
                                      Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        height: 220,
                                        child: InkWell(
                                          child: Card(
                                            color: Colors.white,
                                            child: Container(
                                            decoration: BoxDecoration(
                                            color: Colors.white,
                              borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)
                              ),
                              boxShadow: [
                              BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                              ),
                              ]),
                                              child: Column(
                                                children: [

                                                  Container(
                                                    width: 400,
                                                    height: 144,
                                                    child: Image.network(
                                                        posts.data()['image'],
                                                        fit: BoxFit.cover),
                                                  ),
                                                  SizedBox(height: 11),
                                                  Column(
                                                    children: [
                                                      Directionality(
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        child: Container(
                                                          //width:100,
                                                          child: Text(
                                                            (posts
                                                                .data()['name']),
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.black,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),

                                                      SizedBox(
                                                        height: 7,
                                                      ),
                                                      RatingBar(
                                                        ignoreGestures: true,
                                                        initialRating:posts
                                                            .data()['star'],
                                                        direction: Axis.horizontal,
                                                        allowHalfRating: true,
                                                        itemCount: 5,
                                                        itemSize:18,
                                                        maxRating:5,
                                                        ratingWidget: RatingWidget(
                                                          full:Icon(Icons.star,color:Colors.yellow,),
                                                          half: Icon(Icons.star_half_outlined,color:Colors.yellow,),
                                                          empty:Icon(Icons.star_border,color:Colors.yellow,),
                                                        ),
                                                        //   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                                        onRatingUpdate: (rating) {
                                                          print(rating);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          onTap: () {

                                            Get.to(DetailsView3(
                                              name: posts.data()['name'],
                                               price: posts.data()['price'],
                                              //      x:posts.data()['x'],
                                              details: posts.data()['des'],
                                              image: posts.data()['image'],
                                              city: posts.data()['city'],
                                              //link:posts.data()['link'],
                                              //    brand:posts.data()['brand'],
                                              //  brandemail:posts.data()['brandemail']
                                            ));

                                          },
                                        )),
                                  ));
                            });
                    }
                  }),
            ),
            //),
            //  ]),
          ]),
        ));
  }
}

