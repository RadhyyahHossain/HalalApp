class Resturant {
  final String name;
  final String address;
  final String price;
  final String phoneNumber;
  final String image;
  final String description;
  final String borough;
  final String latitude;
  final String longitude;
  //List<dynamic> provider = [""];

  Resturant({
    required this.name,
    required this.address,
    required this.price,
    required this.phoneNumber,
    required this.image,
    required this.description,
    required this.borough,
    required this.latitude,
    required this.longitude,
    //required this.provider,
  });

  static fromJson(Map<String, dynamic> json) {
    print("inside fromJson");
    print(json);
    return Resturant(
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      price: json['price'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      image: json['image'] ?? '',
      description: json['description'] ?? '',
      borough: json['borough'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      //provider: [],
    );
  }
}
