


 import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatefulWidget {
   const SupportScreen({Key key}) : super(key: key);

   @override
   State<SupportScreen> createState() => _SupportScreenState();
 }

 class _SupportScreenState extends State<SupportScreen> {
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         toolbarHeight: 0,
         backgroundColor: Colors.yellow,
         elevation: 0,

       ),
       body:Center(
         child: Column(
         //  mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             SizedBox(
               height: 20,
             ),
             Container(
               height:120,
               child:Image.asset('assets/support.png'),
             ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'support'.tr,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
             SizedBox(
               height: 20,
             ),



              RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                color:Colors.yellow,
                  child:Text("support2".tr,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color:Colors.black
                  ),
                  ),
                  onPressed:(){
                     sendWhatsApp('+201007484001', "عندي استفسار انا احد عملاء تطبيق Travira");
              })
           ],
         ),
       ),

     );
   }

   sendWhatsApp(String phone,String msg)async{

     String url(){
       if(Platform.isAndroid){
         return 'whatsapp://send?phone=$phone&text=$msg';
           //'https://app.quicktype.io/';
           //'whatsapp://send?phone=$phone&text=$msg';
         //  return 'whatsapp://wa.me/$phone/?text=${Uri.parse(msg)}';
       }
       else{

            return 'whatsapp://wa.me/$phone&text=$msg';
       }
     }
     await canLaunch(url())?launch(url()) : launch(url());

     //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('there is no whats app in your device')));
   }
 }







