class UserModel {
  List<Boy>? boys;

  UserModel({this.boys});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      boys: json['Boys'] == null
          ? []
          : List<Boy>.from(json['Boys'].map((x) => Boy.fromJson(x))),
    );
  }
}

class Boy {
  String? name;
  String? price;
  String? type;
  String? description;
  String? image;
  String? link;
  List<Asset>? asset;

  Boy({
    this.name,
    this.price,
    this.type,
    this.description,
    this.image,
    this.link,
    this.asset,
  });

  factory Boy.fromJson(Map<String, dynamic> json) {
    return Boy(
      name: json['Name'],
      price: json['Price'],
      type: json['Type'],
      description: json['Description'],
      image: json['Image'],
      link: json['link'],
      asset: json['asset'] == null
          ? []
          : List<Asset>.from(json['asset'].map((x) => Asset.fromJson(x))),
    );
  }
}

class Asset {
  int? number;
  String? name;
  String? genres;
  String? type;
  String? description;
  String? image;

  Asset({
    this.number,
    this.name,
    this.genres,
    this.type,
    this.description,
    this.image,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      number: json['number'],
      name: json['Name'],
      genres: json['Genres'],
      type: json['Type'],
      description: json['Description'],
      image: json['image'],
    );
  }
}
