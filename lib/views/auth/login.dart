import 'package:flutter/material.dart';
import 'package:ijaz_naveed_backend/models/User.dart';
import 'package:ijaz_naveed_backend/services/auth.dart';
import 'package:ijaz_naveed_backend/services/user.dart';
import 'package:ijaz_naveed_backend/views/auth/register.dart';
import 'package:ijaz_naveed_backend/views/auth/reset_password.dart';
import 'package:ijaz_naveed_backend/views/city/get_all_cities.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
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
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              hint: Text("Password"),
            ),
          ),
          isLoading ? Center(child: CircularProgressIndicator(),)
              :ElevatedButton(onPressed: ()async{
            try{
              setState(() {
                isLoading = true;
              });
              await AuthService().loginUser(
                  email: emailController.text,
                  password: passwordController.text)
                 .then((value){
                   if(value.emailVerified == true){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>GetAllCities()));
                   }
                   else{

                     setState(() {
                       isLoading = false;
                     });
                     showDialog(context: context, builder: (BuildContext context) {
                       return AlertDialog(
                         content: Text("Kindly Verify Your Email"),
                         actions: [
                           TextButton(onPressed: (){
                             Navigator.pop(context);
                           }, child: Text("Okay"))
                         ],
                       );
                     }, );
                   }
              });
            }catch(e){
              setState(() {
                isLoading = false;
              });
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(e.toString())));

            }
          }, child: Text("Login")),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Register()));
          }, child: Text("Register")),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> ResetPassword()));
          }, child: Text("Forget Password")),
        ],
      ),
    );
  }
}
