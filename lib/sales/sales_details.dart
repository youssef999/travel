import 'package:admob_flutter/admob_flutter.dart';
import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/view/home/main_home.dart';
import 'package:ecommerce/view/widgets/custom_text.dart';
import 'package:ecommerce/viewmodel/home_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:get/get.dart';

class SalesDetails extends StatefulWidget {
  String name, email;
  SalesDetails({this.name, this.email});

  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<SalesDetails> {
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
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Container(
              height: 30,
              child: Center(
                  child: Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.62),
                  SizedBox(width: 5),
                ],
              ))),
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
                      .collection('emp')
                      .where('email', isEqualTo: widget.email)
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
                                  builder: (controller) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Center(
                                              child: Directionality(
                                                textDirection:
                                                    TextDirection.ltr,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Custom_Text(
                                                      text: "Travira ",
                                                      fontSize: 30,
                                                      color: Colors.black,
                                                    ),
                                                    Custom_Text(
                                                      text: "مندوب ",
                                                      fontSize: 30,
                                                      color: Colors.black,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 11),
                                            Container(
                                                height: 310,
                                                child: InkWell(
                                                  child: Card(
                                                    color: Colors.white,
                                                    child: Container(
                                                      child: Column(
                                                        children: [
                                                          SizedBox(height: 11),
                                                          Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    Directionality(
                                                                  textDirection:
                                                                      TextDirection
                                                                          .ltr,
                                                                  child: Row(
                                                                    children: [
                                                                      Container(
                                                                        //width:100,
                                                                        child:
                                                                            Text(
                                                                          ("name : "),
                                                                          style: TextStyle(
                                                                              color: Colors.blue,
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                          width:
                                                                              10),
                                                                      Container(
                                                                        //width:100,
                                                                        child:
                                                                            Text(
                                                                          (posts
                                                                              .data()['name']??""),
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: 5),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    Directionality(
                                                                  textDirection:
                                                                      TextDirection
                                                                          .ltr,
                                                                  child: Row(
                                                                    children: [
                                                                      Container(
                                                                        //width:100,
                                                                        child:
                                                                            Text(
                                                                          ("code : "),
                                                                          style: TextStyle(
                                                                              color: Colors.blue,
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                          width:
                                                                              10),
                                                                      Container(
                                                                        //width:100,
                                                                        child:
                                                                            Text(
                                                                          (posts
                                                                              .data()['code']??""),
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            6,
                                                                      ),
                                                                      InkWell(
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              55,
                                                                          height:
                                                                              50,
                                                                          child:
                                                                              Center(child: Image.asset("assets/copy2.png")),
                                                                        ),
                                                                        onTap:
                                                                            () {
                                                                          FlutterClipboard.copy(posts.data()['code']).then((value) =>
                                                                              print('copied'));
                                                                          Get.snackbar(
                                                                            'Done',
                                                                            'Code Copied',
                                                                            backgroundColor:
                                                                                Colors.lightGreen,
                                                                            colorText:
                                                                                Colors.white,
                                                                          );
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: 5),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    Directionality(
                                                                  textDirection:
                                                                      TextDirection
                                                                          .ltr,
                                                                  child: Row(
                                                                    children: [
                                                                      Container(
                                                                        //width:100,
                                                                        child:
                                                                            Text(
                                                                          ("coins : "),
                                                                          style: TextStyle(
                                                                              color: Colors.blue,
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                          width:
                                                                              10),
                                                                      Container(
                                                                        //width:100,
                                                                        child:
                                                                            Text(
                                                                          (posts.data()['coins']??"")
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    Directionality(
                                                                  textDirection:
                                                                      TextDirection
                                                                          .ltr,
                                                                  child: Row(
                                                                    children: [
                                                                      Container(
                                                                        //width:100,
                                                                        child:
                                                                            Text(
                                                                          ("downloads : "),
                                                                          style: TextStyle(
                                                                              color: Colors.blue,
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                          width:
                                                                              10),
                                                                      Container(
                                                                        //width:100,
                                                                        child:
                                                                            Text(
                                                                          (posts.data()['downloads']).toString() ??
                                                                              "0",
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () {},
                                                )),
                                            RaisedButton(
                                                color: Colors.blue,
                                                child: Text(
                                                  "انتقل للرئيسية ",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                ),
                                                onPressed: () {
                                                  Get.put(HomeViewModel());
                                                  Get.to(MainPage());
                                                })
                                          ],
                                        ),
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

//                         }
//                       }
//                   ),
//                 ),
//               //),


//             ]),
//       ),


//     );
//   }
// }

