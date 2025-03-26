class AddAddressSendData {
  String addressCon;
  String apartmentCon;
  String houseCon;
  String streetCon;
  String addressLineCon;
  String areaCon;
  String postCodeCon;
  String stateCon;
  String countryCon;
  String countryISOCodeCon;
  String typeCon;
  String cityCon;

  // Constructor
  AddAddressSendData({
    required this.addressCon,
    required this.apartmentCon,
    required this.houseCon,
    required this.streetCon,
    required this.addressLineCon,
    required this.areaCon,
    required this.postCodeCon,
    required this.stateCon,
    required this.countryCon,
    required this.countryISOCodeCon,
    required this.typeCon,
    required this.cityCon,
  });

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'address': addressCon,
      'apartment': apartmentCon,
      'house': houseCon,
      'street': streetCon,
      'addressLine': addressLineCon,
      'area': areaCon,
      'postCode': postCodeCon,
      'state': stateCon,
      'country': countryCon,
      'countryISOCode': countryISOCodeCon,
      'type': typeCon,
      'city': cityCon,
    };
  }
}
