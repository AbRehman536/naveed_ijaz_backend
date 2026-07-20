import 'package:flutter/material.dart';
import 'package:ijaz_naveed_backend/models/User.dart';
import 'package:ijaz_naveed_backend/services/auth.dart';
import 'package:ijaz_naveed_backend/services/user.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hint: Text("Name"),
            ),
          ),
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
          TextField(
            controller: addressController,
            decoration: InputDecoration(
              hint: Text("Address"),
            ),
          ),
          TextField(
            controller: phoneController,
            decoration: InputDecoration(
              hint: Text("Contact"),
            ),
          ),
          isLoading ? Center(child: CircularProgressIndicator(),)
              :ElevatedButton(onPressed: ()async{
                try{
                  setState(() {
                    isLoading = true;
                  });
                  await AuthService().registerUser(
                      email: emailController.text,
                      password: passwordController.text)
                      .then((value)async{
                        await UserServices().createUser(
                          UserModel(
                            docId: value.uid,
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            address: addressController.text,
                            createdAt: DateTime.now().millisecondsSinceEpoch
                          )
                        ).then((val){
                          setState(() {
                            isLoading = false;
                          });
                          showDialog(context: context, builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text("Register Successfully"),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }, child: Text("Okay"))
                              ],
                            );
                          }, );
                        });
                  });
                }catch(e){
                  setState(() {
                    isLoading = false;
                  });
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));

                }
          }, child: Text("Register"))
        ],
      ),
    );
  }
}
