import 'package:flutter/material.dart';
import 'package:ijaz_naveed_backend/models/city.dart';
import 'package:ijaz_naveed_backend/services/city.dart';
import 'package:ijaz_naveed_backend/views/city/create_city.dart';
import 'package:ijaz_naveed_backend/views/city/get_remaining_city.dart';
import 'package:ijaz_naveed_backend/views/city/get_visited_city.dart';
import 'package:ijaz_naveed_backend/views/city/update_city.dart';
import 'package:provider/provider.dart';

class GetAllCities extends StatelessWidget {
  const GetAllCities({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Cities"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetVisitedCity()));
          }, icon: Icon(Icons.location_on)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetRemainingCity()));
          }, icon: Icon(Icons.local_airport)),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateCity()));
      },child: Icon(Icons.add),),
      body: StreamProvider.value(
          value: CityServices().getAllCity(),
          initialData: [CityModel()],
          builder: (context, child){
            List<CityModel> cityList = context.watch<List<CityModel>>();
            return ListView.builder(
              itemCount: cityList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(Icons.location_city),
                  title: Text(cityList[index].city.toString()),
                  subtitle: Text(cityList[index].population.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                          value: cityList[index].visited,
                          onChanged: (val)async{
                            try{
                              await CityServices().markAsVisitedCity(
                                  cityList[index].docId.toString(),
                                  val!);
                            }catch(e){
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text(e.toString())));
                            }
                          }),
                      IconButton(onPressed: ()async{
                        try{
                          await CityServices().deleteCity(
                            cityList[index].docId.toString()
                          );
                        }catch(e){
                         ScaffoldMessenger.of(context)
                         .showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      }, icon: Icon(Icons.delete, color: Colors.red,)),
                      IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateCity(model: cityList[index],)));
                      }, icon: Icon(Icons.edit,color: Colors.blue,))
                    ],
                  ),
                );
              },);
          },
        ),
    );
  }
}
