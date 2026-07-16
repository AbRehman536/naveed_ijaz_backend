import 'package:flutter/material.dart';
import 'package:ijaz_naveed_backend/models/city.dart';
import 'package:ijaz_naveed_backend/models/country.dart';
import 'package:ijaz_naveed_backend/services/city.dart';
import 'package:provider/provider.dart';

class GetCountries extends StatelessWidget {
  final CountryModel model;
  const GetCountries({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${model.name}"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: StreamProvider<List<CityModel>>.value(
        value: CityServices().getCityByCountryID(model.docId.toString()),
        initialData: const [],
        builder: (context, child) {
          List<CityModel> cityList = context.watch<List<CityModel>>();

          return ListView.builder(
            itemCount: cityList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.location_city),
                title: Text(cityList[index].city ?? ''),
                subtitle: Text(cityList[index].population.toString()),
              );
            },
          );
        },
      ),
    );
  }
}
