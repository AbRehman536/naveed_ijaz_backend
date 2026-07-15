import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/country.dart';

class CountryServices{
  String countryCollection = "CountryCollection";
  ///Create Country
  Future createCountry(CountryModel model)async{
    DocumentReference documentReference =
    await FirebaseFirestore.instance
        .collection(countryCollection)
        .doc();
    return await FirebaseFirestore.instance
        .collection(countryCollection)
        .doc(documentReference.id)
        .set(model.toJson(documentReference.id));
  }
  ///Update Country
  Future updateCountry(CountryModel model)async{
    return await FirebaseFirestore.instance
        .collection(countryCollection)
        .doc(model.docId)
        .update({"name": model.name,});
  }
  ///Delete Country
  Future deleteCountry(String countryID)async{
    return await FirebaseFirestore.instance
        .collection(countryCollection)
        .doc(countryID)
        .delete();
  }

  ///Get All Country
  Stream<List<CountryModel>> getAllCountry(){
    return FirebaseFirestore.instance
        .collection(countryCollection)
        .snapshots()
        .map((countryList)=> countryList.docs
        .map((countryJson) => CountryModel.fromJson(countryJson.data()),
    ).toList()
    );
  }
  ///Get Country
  Future<List<CountryModel>> getCountry(){
    return FirebaseFirestore.instance
        .collection(countryCollection)
        .get()
        .then((countryList)=> countryList.docs
        .map((countryJson) => CountryModel.fromJson(countryJson.data()),
    ).toList()
    );
  }
}