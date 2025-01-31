class IcecreamsData {
  List<Icecreams>? icecreams;

  IcecreamsData({this.icecreams});

  // Constructor to create an IcecreamsData instance from a JSON map
  IcecreamsData.fromJson(Map<String, dynamic> json) {
    if (json['icecreams'] != null) {
      icecreams = <Icecreams>[];
      // Iterate through each item in the JSON 'icecreams' array and convert it to an Icecreams object
      json['icecreams'].forEach((v) {
        icecreams!.add(Icecreams.fromJson(v));
      });
    }
  }

  // Method to convert an IcecreamsData instance to a JSON map
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (icecreams != null) {
      // Convert each Icecreams object in the list to JSON and add it to the 'icecreams' array
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

  // Constructor to create an Icecreams instance from a JSON map
  Icecreams.fromJson(Map<String, dynamic> json)
      : flavour = json['flavour'],
        description = json['description'],
        toppings = json['toppings'] != null
            ? List<String>.from(json['toppings']) // Convert the JSON 'toppings' array to a List<String>
            : null,
        price = json['price'].toDouble(), // Ensure price is converted to double
        image = json['image'],
        ingredients = json['ingredients'] != null
            ? (json['ingredients'] as List)
            .map((v) => Ingredients.fromJson(v))
            .toList() // Convert the JSON 'ingredients' array to a List<Ingredients>
            : null;

  // Method to convert an Icecreams instance to a JSON map
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['flavour'] = flavour;
    data['description'] = description;
    data['toppings'] = toppings;
    data['price'] = price;
    data['image'] = image;
    if (ingredients != null) {
      // Convert each Ingredients object in the list to JSON and add it to the 'ingredients' array
      data['ingredients'] = ingredients!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ingredients {
  String? name;
  String? quantity;

  Ingredients({this.name, this.quantity});

  // Constructor to create an Ingredients instance from a JSON map
  Ingredients.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        quantity = json['quantity'];

  // Method to convert an Ingredients instance to a JSON map
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['quantity'] = quantity;
    return data;
  }
}
