import 'package:flutter/material.dart';
import 'package:ijaz_naveed_backend/models/city.dart';
import 'package:ijaz_naveed_backend/services/city.dart';

class CreateCity extends StatefulWidget {
  const CreateCity({super.key});

  @override
  State<CreateCity> createState() => _CreateCityState();
}

class _CreateCityState extends State<CreateCity> {
  TextEditingController nameController = TextEditingController();
  TextEditingController populationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create City"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hint: Text("City Name"),
                border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: populationController,
              decoration: InputDecoration(
                hint: Text("Population"),
                border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: ()async{
              try{
                await CityServices().createCity(
                  CityModel(
                    city: nameController.text.toString(),
                    population: int.parse(populationController.text.toString()),
                    visited: false,
                    createdAt: DateTime.now().millisecondsSinceEpoch
                  )
                ).then((val){
                  showDialog(context: context, builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text("Create Successfully"),
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
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(e.toString())));
              }
            }, child: Text("Create City"))
          ],
        ),
      ),
    );
  }
}
