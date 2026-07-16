import 'package:flutter/material.dart';
import 'package:ijaz_naveed_backend/models/country.dart';
import 'package:ijaz_naveed_backend/services/country.dart';
import 'package:ijaz_naveed_backend/views/country/create_update_country.dart';
import 'package:ijaz_naveed_backend/views/country/get_city_by_id.dart';
import 'package:provider/provider.dart';

class GetAllCountry extends StatelessWidget {
  const GetAllCountry({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Country"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateUpdateCountry(model: CountryModel(), isUpdatedMode: false)));
      },child: Icon(Icons.add),),
      body: StreamProvider.value(
          value: CountryServices().getAllCountry(),
          initialData: [CountryModel()],
          builder: (context,child){
            List<CountryModel> countryList = context.watch<List<CountryModel>>();
            return ListView.builder(
              itemCount: countryList.length,
              itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.supervisor_account_rounded),
                title: Text(countryList[index].name.toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: ()async{
                      try{
                        await CountryServices().deleteCountry(
                          countryList[index].docId.toString()
                        );
                      }catch(e){
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    }, icon: Icon(Icons.delete,color: Colors.red,)),
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateUpdateCountry(model: CountryModel(), isUpdatedMode: true)));
                    }, icon: Icon(Icons.edit, color: Colors.blue,)),
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> GetCountries(model: countryList[index])));
                    }, icon: Icon(Icons.arrow_forward, color: Colors.green,)),
                  ],
                ),
              );
            },);
          },
      ),
    );
  }
}
