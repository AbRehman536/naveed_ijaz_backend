import 'package:flutter/material.dart';
import 'package:ijaz_naveed_backend/models/country.dart';
import 'package:ijaz_naveed_backend/services/country.dart';

class CreateUpdateCountry extends StatefulWidget {
  final CountryModel model;
  final bool isUpdatedMode;
  const CreateUpdateCountry({super.key, required this.model, required this.isUpdatedMode});

  @override
  State<CreateUpdateCountry> createState() => _CreateUpdateCountryState();
}

class _CreateUpdateCountryState extends State<CreateUpdateCountry> {
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  @override
  void initState(){
    super.initState();
    if(widget.isUpdatedMode == true) {
      nameController = TextEditingController(
          text: widget.model.name.toString()
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isUpdatedMode ? "Update Country" : "Create Country"),
        backgroundColor: widget.isUpdatedMode ? Colors.blue : Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
                hint: Text("Country Name"),
                border: OutlineInputBorder()
            ),
          ),
          SizedBox(height: 10,),
          isLoading ? Center(child: CircularProgressIndicator(),)
         : ElevatedButton(onPressed: ()async{
            try{
              isLoading = true;
              setState(() {});
              if(widget.isUpdatedMode == true){
                await CountryServices().updateCountry(
                  CountryModel(
                    docId: widget.model.docId.toString(),
                    name: nameController.text.toString()
                  )
                ).then((val){
                  isLoading = false;
                  setState(() {});
                  showDialog(context: context, builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text("Update Successfully"),
                      actions: [
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }, child: Text("Okay"))
                      ],
                    );
                  }, );
                });
              }else{
                await CountryServices().createCountry(
                    CountryModel(
                        name: nameController.text.toString(),
                      createdAt: DateTime.now().millisecondsSinceEpoch
                    )
                ).then((val){

                setState(() {
                  isLoading = false;
                });
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
              }
            }catch(e){
              isLoading = false;
              setState(() {});
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(e.toString())));
            }
          }, child: Text(
            widget.isUpdatedMode ? "Update Country" : "Create Country"
          ))
        ],
      ),
    );
  }
}
