class IcecreamsData {
  List<Icecreams>? icecreams;

  IcecreamsData({this.icecreams});

  IcecreamsData.fromJson(Map<String, dynamic> json) {
    if (json['icecreams'] != null) {
      icecreams = <Icecreams>[];
      json['icecreams'].forEach((v) {
        icecreams!.add(Icecreams.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (icecreams != null) {
      data['icecreams'] = icecreams!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Icecreams {
  String flavour;
  String? description;
  List<String>? toppings;
  double price;
  String? image;
  List<Ingredients>? ingredients;

  Icecreams({
    required this.flavour,
    this.description,
    this.toppings,
    required this.price,
    this.image,
    this.ingredients,
  });

  Icecreams.fromJson(Map<String, dynamic> json)
      : flavour = json['flavour'],
        description = json['description'],
        toppings = json['toppings'] != null
            ? List<String>.from(json['toppings'])
            : null,
        price = json['price'].toDouble(),  // Ensure price is converted to double
        image = json['image'],
        ingredients = json['ingredients'] != null
            ? (json['ingredients'] as List)
            .map((v) => Ingredients.fromJson(v))
            .toList()
            : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['flavour'] = flavour;
    data['description'] = description;
    data['toppings'] = toppings;
    data['price'] = price;
    data['image'] = image;
    if (ingredients != null) {
      data['ingredients'] = ingredients!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ingredients {
  String? name;
  String? quantity;

  Ingredients({this.name, this.quantity});

  Ingredients.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        quantity = json['quantity'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['quantity'] = quantity;
    return data;
  }
}