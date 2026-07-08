import 'package:flutter/material.dart';
import 'package:ijaz_naveed_backend/models/city.dart';
import 'package:ijaz_naveed_backend/services/city.dart';
import 'package:ijaz_naveed_backend/views/city/create_city.dart';
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
                );
              },);
          },
        ),
    );
  }
}
