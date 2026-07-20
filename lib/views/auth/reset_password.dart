import 'package:flutter/material.dart';
import 'package:ijaz_naveed_backend/models/User.dart';
import 'package:ijaz_naveed_backend/services/auth.dart';
import 'package:ijaz_naveed_backend/services/user.dart';
import 'package:ijaz_naveed_backend/views/city/get_all_cities.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              hint: Text("Email"),
            ),
          ),
          isLoading ? Center(child: CircularProgressIndicator(),)
              :ElevatedButton(onPressed: ()async{
            try{
              setState(() {
                isLoading = true;
              });
              await AuthService().resetPassword(
                  email: emailController.text,)
                  .then((value){
                showDialog(context: context, builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text("Link Send Successfully"),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }, child: Text("Okay"))
                    ],
                  );
                }, );
              });
            }catch(e){
              setState(() {
                isLoading = false;
              });
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(e.toString())));

            }
          }, child: Text("Send Link"))
        ],
      ),
    );
  }
}
