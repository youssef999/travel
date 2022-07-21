import 'package:admob_flutter/admob_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/view/category/Allcat.dart';
import 'package:ecommerce/viewmodel/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:get/get.dart';

class AllCities extends StatefulWidget {
  String city;

  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<AllCities> {
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
                      .collection('cities')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData)
                      return Center(child: Text('Loading'));
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return new Text('Loading...');
                      default:
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GridView.builder(
                              itemCount: snapshot.data.documents.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 2 / 3,
                                crossAxisSpacing: 1,
                                mainAxisSpacing: 1,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                DocumentSnapshot posts =
                                    snapshot.data.documents[index];
                                return GetBuilder<HomeViewModel>(
                                    init: Get.find(),
                                    builder: (controller) => Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: InkWell(
                                        child: Container(
                                         // width: 230,
                                          height: 280,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(12),
                                                  topRight: Radius.circular(12),
                                                  bottomLeft: Radius.circular(12),
                                                  bottomRight: Radius.circular(12)
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.5),
                                                  spreadRadius: 2,
                                                  blurRadius: 4,
                                                  offset: Offset(0, 3), // changes position of shadow
                                                ),
                                              ]),
                                          child: Column(
                                            children: [
                                              Container(
                                                height:220,
                                                child: Image.network(
                                                    posts.data()['image'],

                                                    fit: BoxFit.fill),
                                              ),
                                            ],
                                          ),
                                        ),
                                        onTap: () {
                                          Get.to(AllCat(
                                              city: posts.data()['name']));
                                        },
                                      ),
                                    ));
                              }),
                        );
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
