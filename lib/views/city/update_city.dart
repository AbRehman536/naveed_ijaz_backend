import 'package:flutter/material.dart';
import 'package:ijaz_naveed_backend/models/city.dart';
import 'package:ijaz_naveed_backend/services/city.dart';

class UpdateCity extends StatefulWidget {
  final CityModel model;
  const UpdateCity({super.key, required this.model});

  @override
  State<UpdateCity> createState() => _UpdateCityState();
}

class _UpdateCityState extends State<UpdateCity> {
  TextEditingController nameController = TextEditingController();
  TextEditingController populationController = TextEditingController();
  @override
  void initState(){
    super.initState();
    nameController = TextEditingController(
      text: widget.model.city.toString()
    );
    populationController = TextEditingController(
      text: widget.model.population.toString()
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update City"),
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
                await CityServices().updateCity(
                    CityModel(
                      docId: widget.model.docId.toString(),
                        city: nameController.text.toString(),
                        population: int.parse(populationController.text.toString())
                    )
                );
              }catch(e){
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(e.toString())));
              }
            }, child: Text("Update City"))
          ],
        ),
      ),
    );
  }
}
