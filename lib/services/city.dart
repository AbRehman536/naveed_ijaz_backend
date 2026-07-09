import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ijaz_naveed_backend/models/city.dart';

class CityServices{
 String cityCollection = "CityCollection";
  ///Create City
  Future createCity(CityModel model)async{
    DocumentReference documentReference =
    await FirebaseFirestore.instance
    .collection(cityCollection)
    .doc();
    return await FirebaseFirestore.instance
        .collection(cityCollection)
        .doc(documentReference.id)
        .set(model.toJson(documentReference.id));
  }
  ///Update City
 Future updateCity(CityModel model)async{
   return await FirebaseFirestore.instance
       .collection(cityCollection)
        .doc(model.docId)
       .update({"city": model.city, "population": model.population});
 }
  ///Delete City
 Future deleteCity(String cityID)async{
   return await FirebaseFirestore.instance
       .collection(cityCollection)
        .doc(cityID)
        .delete();
 }
  ///Mark Visited City
 Future markAsVisitedCity(String cityID, bool visited)async{
   return await FirebaseFirestore.instance
       .collection(cityCollection)
        .doc(cityID)
       .update({"visited" : visited});
 }

///Get All City
  Stream<List<CityModel>> getAllCity(){
    return FirebaseFirestore.instance
        .collection(cityCollection)
        .snapshots()
        .map((cityList)=> cityList.docs
        .map((cityJson) => CityModel.fromJson(cityJson.data()),
      ).toList()
    );
  }
///Get Visited City
 Stream<List<CityModel>> getVisitedCity(){
   return FirebaseFirestore.instance
       .collection(cityCollection)
        .where("visited" ,isEqualTo: true)
       .snapshots()
       .map((cityList)=> cityList.docs
       .map((cityJson) => CityModel.fromJson(cityJson.data()),
   ).toList()
   );
 }
///Get Remaining City
 Stream<List<CityModel>> getRemainingCity(){
   return FirebaseFirestore.instance
       .collection(cityCollection)
       .where("visited" ,isEqualTo: false)
       .snapshots()
       .map((cityList)=> cityList.docs
       .map((cityJson) => CityModel.fromJson(cityJson.data()),
   ).toList()
   );
 }
}