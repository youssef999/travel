import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/pay_mob/modules/payment/cubit/cubit.dart';
import 'package:ecommerce/pay_mob/modules/payment/cubit/states.dart';
import 'package:ecommerce/pay_mob/modules/payment/cubit/toogle.dart';

import 'package:ecommerce/viewmodel/auth_view_model.dart';
import 'package:ecommerce/viewmodel/codes_view_model.dart';
import 'package:ecommerce/viewmodel/employee_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class BookingForm extends StatefulWidget {
  String city, trip;
  int price;

  BookingForm({this.city, this.trip, this.price});

  @override
  State<BookingForm> createState() => _AdressScreenState();
}

class _AdressScreenState extends State<BookingForm> {
  //String brand_email;

  String x = 'القاهرة';

  int shipping = 0;
  num pricex = 0.0;


  @override
  Widget build(BuildContext context) {

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController name = TextEditingController();
    TextEditingController mobile = TextEditingController();
    TextEditingController code = TextEditingController();
    final box = GetStorage();



    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              height: 220,
              width: 550,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image.asset(
                  'assets/tx2.jpg',
                  //'assets/ezgif.com-gif-maker.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 11,
            ),
            Text(
              "43".tr,
              style: TextStyle(color: Colors.black, fontSize: 19),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Center(
                child: DropdownButton<String>(
                  value: x,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 18,
                  style: const TextStyle(color: Colors.yellow, fontSize: 19),
                  underline: Center(
                    child: Container(
                      height: 2,
                      color: Colors.yellow,
                    ),
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      x = newValue.toString();
                    });

                    print('x=' + x.toString());
                  },
                  items: <String>[
                    'القاهرة',
                    'الاسكندرية',
                    'الاسماعلية',
                    'اسوان',
                    'الجيزة',
                    'الأقصر',
                    'الأسيوط',
                    'البحر الأحمر',
                    'البحيرة',
                    'المنيا',
                    'الدقهلية',
                    'السويس',
                    'الشرقية',
                    'الغربية',
                    'الفيوم',
                    'القليوبية',
                    'المنوفية',
                    'الوادى الجديد',
                    'بورسعيد',
                    'جنوب سيناء',
                    'سوهاج',
                    'شمال سيناء',
                    'قنا',
                    'كفر الشيخ',
                    'مرسى مطروح',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 88,
                    ),
                    Text(
                      "  To : ",
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                    Text(
                      widget.city,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 19,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 65,
                    ),
                    Text(
                      "  Trip :  ",
                      style: TextStyle(color: Colors.grey, fontSize: 17),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      widget.trip,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),

            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 40, left: 40),
              child: Center(
                child: TextFormField(
                  controller: name,
                  onSaved: (value) {
                    name.text = value;
                  },
                  validator: (value) {
                    if (value == null || value == '') {
                      return ("18".tr);
                    }
                  },

                  // textAlign:TextAlign.end,
                  decoration: InputDecoration(
                    hintText: '18'.tr,
                    hintStyle: TextStyle(color: Colors.grey),
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),

            SizedBox(height: 12),
            Column(
              children: [
                Text(
                  "44".tr,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                GetBuilder<AuthViewModel>(
                    init: Get.find(),
                    builder: (controller) => Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: DropdownButton<int>(
                            value: controller.x2,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 22,
                            style: const TextStyle(
                                color: Colors.yellow, fontSize: 19),
                            underline: Container(
                              height: 2,
                              color: Colors.yellow,
                            ),
                            onChanged: (int newValue) {
                              controller.x2 = newValue;
                              controller.chooseCity(
                                  widget.price, newValue, shipping);
                              final box = GetStorage();
                              box.write('num', controller.x2);
                            },
                            items: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                                .map<DropdownMenuItem<int>>((int value) {
                              return DropdownMenuItem<int>(
                                value: value,
                                child: Text(
                                  value.toString(),
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList(),
                          ),
                        )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 40, left: 40),
              child: Center(
                child: TextFormField(
                  controller: mobile,
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    mobile.text = value;
                  },
                  validator: (value) {
                    if (value == null || value == '') {
                      return ("20".tr);
                    }
                  },
                  // textAlign:TextAlign.end,

                  decoration: InputDecoration(
                    hintText: '20'.tr,
                    hintStyle: TextStyle(color: Colors.grey),
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),

            Padding(
              padding: const EdgeInsets.only(top: 0.5, left: 40, right: 40),
              child: GetBuilder<CodesViewModel>(
                init: Get.find(),
                builder: (controller) => SingleChildScrollView(
                  child: Container(
                    height: 170,
                    child: ListView.separated(
                      itemCount: 1, //controller.employeeModel.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        //controller.codeModel[index].codes.toString(),
                        return Column(
                          children: [
                            Container(
                              width: 310,
                              child: TextFormField(
                                controller: code,
                                decoration: InputDecoration(
                                  hintText: "24".tr,
                                  hintStyle: TextStyle(fontSize: 15),
                                ),
                                // validator: (value) {
                                //   if (value.isEmpty) {
                                //     return "ادخل البرومو كود  ";
                                //   }
                                // },
                                onSaved: (value) {
                                  print(value);
                                  code.text = value;
                                  if (code.text.contains(controller
                                      .codeModel[index].codes
                                      .toString()
                                      .split(',')
                                      .toString())) {
                                    print("ttttt");
                                  } else {
                                    print("xxx");
                                  }
                                },
                              ),
                            ),
                            Text(
                              "46".tr,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GetBuilder<AuthViewModel>(
                                init: Get.find(),
                                builder: (controller3) => Column(
                                      children: [
                                        GetBuilder<EmployeeViewModel>(
                                          init: Get.find(),
                                          builder: (controller2) => FlatButton(
                                              color: Colors.yellow,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15),
                                                child: Text(
                                                  "45".tr,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontFamily: "Reboto",
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              onPressed: () async {
                                                num px=0;
                                                 _formKey.currentState.save();
                                                    if (_formKey.currentState.validate()) {
                                                      final box = GetStorage();
                                                      String coponCode = box
                                                          .read('code_end') ??
                                                          "x";
                                                      if (controller3.price == null){
                                                        px= (widget.price * controller3.x2);
                                                      }
                                                      if (controller3.price != null){

                                                        px=controller3.price;

                                                      }
                                                      print("px="+px.toString());

                            if (coponCode == 'x' &&  px >=30 || code.text != coponCode && px >=4000) {
                                                        print("ppp");
                                                        if (controller
                                                            .codeModel[index]
                                                            .codes
                                                            .contains(
                                                            code.text)) {
                                                          print("ttt");
                                                          Firestore.instance
                                                              .collection('emp')
                                                              .where("code",
                                                              isEqualTo: code
                                                                  .text)
                                                              .get()
                                                              .then((
                                                              snapshot) async {
                                                            print("sss" +
                                                                snapshot
                                                                    .docs[index]
                                                                ['name']
                                                                    .toString());
                                                            snapshot
                                                                .docs.first
                                                                .reference
                                                                .update({
                                                              'coins':
                                                              snapshot
                                                                  .docs[index]
                                                              ['coins'] +
                                                                  10
                                                            }).then((
                                                                value) async {
                                                              print("fffyy=" +
                                                                  snapshot
                                                                      .docs[index]
                                                                  ['nsba']
                                                                      .toString());

                                                              controller3
                                                                  .travelcode(
                                                                  widget.price,
                                                                  snapshot
                                                                      .docs[index]['nsba'],
                                                                  controller3
                                                                      .x2,
                                                                  shipping);
                                                              final box = GetStorage();

                                                              box.write(
                                                                  'code_end',
                                                                  code.text);

                                                              box.write('nsba',
                                                                  snapshot
                                                                      .docs[index]['nsba']
                                                                      .toString());

                                                              if (controller3
                                                                  .price !=
                                                                  null) {
                                                                pricex =
                                                                    controller3
                                                                        .price;
                                                              }

                                                              if (controller3
                                                                  .price ==
                                                                  null) {
                                                                pricex =
                                                                    widget
                                                                        .price *
                                                                        controller3
                                                                            .x2;
                                                              }

                                                              Get.snackbar(
                                                                  'Done  ',
                                                                  '98'.tr,
                                                                  colorText:
                                                                  Colors.white,
                                                                  backgroundColor:
                                                                  Colors
                                                                      .lightGreen);
                                                            });
                                                          });
                                                        } else {
                                                          print("ooo");
                                                          Get.snackbar(
                                                              'Wrong !',
                                                              '97'.tr,
                                                              colorText: Colors
                                                                  .white,
                                                              backgroundColor:
                                                              Colors.red);
                                                        }
                                                      }
                            else {
                              print("sss");
                              Get.snackbar(
                                  'Wrong !',
                                  '97'.tr,
                                  colorText: Colors
                                      .white,
                                  backgroundColor:
                                  Colors.red);
                            }
                                                    } else {
                                                      print("sss");
                                                      // Get.snackbar(
                                                      //     'Wrong !',
                                                      //     ' Enter information',
                                                      //     colorText: Colors
                                                      //         .white,
                                                      //     backgroundColor:
                                                      //         Colors.red);
                                                    }
                                              }),
                                        ),

                                        SizedBox(
                                          height: 2,
                                        ),

                                        // if(code.text ==null || code.text=='' )
                                        if (controller3.price == null)
                                          Text(
                                            "Total = " +
                                                (widget.price * controller3.x2)
                                                    .toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 22,
                                            ),
                                          ),
                                        if (controller3.price != null)
                                          //   if(code.text !=null && code.text!='' )
                                          Text(
                                            "Total = " +
                                                controller3.price.toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 22,
                                            ),
                                          ),
                                      ],
                                    ))
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        width: 8,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 2,
            ),

        GetBuilder<AuthViewModel>(
          init: Get.find(),
          builder: (controller3) => Column(
              children: [
          GetBuilder<EmployeeViewModel>(
          init: Get.find(),
          builder: (controller2) =>
              BlocProvider(
              create: (context) => paymentCubit(),
              child: BlocConsumer<paymentCubit, PaymentStates>(
                listener: (context, state) {
                  //   // add when paymob is live
                  // if (state is paymentRefCodeSuccessSate) {
                  //   String name1 = box.read('sales_name') ?? 'x';
                  //   String namex = box.read('name') ?? 'x';
                  //   String emailx = box.read('email') ?? 'x';
                  //   String nsba = box.read('nsba') ?? 'x';
                  //   int num = box.read('num') ?? 0;
                  //   int pricex = 0;
                  //   if (pricex == 0) {
                  //     pricex = (widget.price * num + shipping);
                  //   } else {
                  //     pricex = pricex;
                  //   }
                  //   print("pricex=" + pricex.toString());
                  //
                  //   _formKey.currentState.save();
                  //   if (_formKey.currentState.validate()) {
                  //     Get.to(ToogleScreen(
                  //       name: name.text ?? "",
                  //       email: emailx ?? "",
                  //       phone: mobile.text ?? "",
                  //       code: code.text ?? "",
                  //       d_app: name1 ?? "",
                  //       from: x.toString(),
                  //       point: "it will be updated soon",
                  //       to: widget.city.toString(),
                  //       trip: widget.trip.toString(),
                  //       // 'price':widget.price.toString(),
                  //       nsba_offer: nsba,
                  //       num: num.toString(),
                  //       status: "pending",
                  //       total: pricex.toString(),
                  //     ));
                  //   }
                  // }
                },
                builder: (context, state) {
                  return RaisedButton(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          height: 56,
                          width: double.infinity,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: Colors.yellow,
                            child: Text(
                              "42".tr,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 23,
                                  fontFamily: "Reboto",
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                      ),
                      textColor: Colors.black,
                      color: Colors.yellow,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        String name1 = box.read('sales_name') ?? 'x';
                        String namex = box.read('name') ?? 'x';
                        String emailx = box.read('email') ?? 'x';
                        String nsba = box.read('nsba') ?? 'x';
                        int num = box.read('num') ?? 0;
                        int pricex2 = 0;

                        if (pricex2 == 0) {

                          pricex2 = (widget.price * num + shipping);
                        } else {
                          pricex2 = pricex2;
                        }
                        print("pricex=" + pricex2.toString());
                        int finalPrice = pricex2 * 100;

                        if (controller3.price !=
                            null) {

                          pricex =
                              controller3.price;

                          print("p1="+pricex.toString());
                        }

                        if (controller3.price ==
                            null) {
                          pricex = widget.price *
                              controller3.x2;

                          print("p1="+pricex.toString());
                        }


                        _formKey.currentState.save();

                        if (_formKey.currentState.validate()) {

                          Get.to(ToogleScreen(
                            name: name.text ?? "",
                            email: emailx ?? "",
                            phone: mobile.text ?? "",
                            code: code.text ?? "",
                            d_app: name1 ?? "",
                            from: x.toString(),
                            point: "it will be updated soon",
                            to: widget.city.toString(),
                            trip: widget.trip.toString(),
                            // 'price':widget.price.toString(),
                            nsba_offer: nsba,
                            num: num.toString(),
                            status: "pending",
                            total: pricex.toString(),
                          ));
                        } else {
                          Get.snackbar("Error! !!! ", "75".tr,
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              borderRadius: 10,
                              margin: EdgeInsets.all(10),
                              borderColor: Colors.red,
                              borderWidth: 2,
                              icon: Icon(Icons.error, color: Colors.white));
                        }

                        // add when paymob is live
                        // paymentCubit.get(context).getFirstToken(
                        //     finalPrice.toString(),
                        //     emailx,
                        //     x.toString(),
                        //     name.text,
                        //     name.text,
                        //     mobile.text);

                        // await Firestore.instance.collection('orders').add({
                        //   'name': name.text ?? "",
                        //   'email': emailx ?? "",
                        //   'phone': mobile.text ?? "",
                        //   'code': code.text ?? "",
                        //   'd_app': name1 ?? "",
                        //   'from': x.toString(),
                        //   'point': "it will be updated soon",
                        //   'to': widget.city.toString(),
                        //   'trip': widget.trip.toString(),
                        //   // 'price':widget.price.toString(),
                        //   'nsba_offer': nsba,
                        //   'num': num.toString(),
                        //   "status": "pending",
                        //   "total": pricex.toString(),
                        // });
                      });
                },
              ),
            ),
    )])),
            SizedBox(
              height: 0,
            )
          ],
        ),
      ),
    ));
  }
}
