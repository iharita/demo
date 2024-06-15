import 'package:cached_network_image/cached_network_image.dart'; // Import for caching network images
import 'package:demo/icecream/model/icecream.dart'; // Import for the ice cream model
import 'package:flutter/material.dart'; // Import for Material design widgets

class IcecreamDetailView extends StatelessWidget {
  // Constructor for IcecreamDetailView, requires an ice cream object
  const IcecreamDetailView({Key? key, required this.icecream}) : super(key: key);

  final Icecreams icecream; // The ice cream object to display details for

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange, // Background color of the app bar
        title: Text(icecream.flavour), // Title of the app bar
        elevation: 0.0, // Remove shadow from the app bar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding around the content
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Hero(
                    tag: icecream.image!, // Hero tag for smooth image transition
                    child: CircleAvatar(
                      radius: 100, // Size of the avatar
                      backgroundImage: CachedNetworkImageProvider(icecream.image!), // Display image from URL
                    ),
                  ),
                  const SizedBox(
                    width: 20, // Space between image and price
                  ),
                  Text("\$${icecream.price.toString()}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 50)), // Display the price
                ],
              ),
              const SizedBox(
                height: 20, // Space between elements
              ),
              Text(
                icecream.description!,
                style: Theme.of(context).textTheme.bodyMedium, // Display the description
              ),
              const SizedBox(
                height: 20, // Space between elements
              ),
              const Text(
                "Toppings",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // Toppings header
              ),
              SizedBox(
                height: 70, // Height for the toppings list
                child: ListView.builder(
                  scrollDirection: Axis.horizontal, // Horizontal scrolling
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0), // Padding around each chip
                      child: Chip(label: Text(icecream.toppings![index])), // Display each topping
                    );
                  },
                  itemCount: icecream.toppings!.length, // Number of toppings
                ),
              ),
              const Text(
                "Ingredients",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // Ingredients header
              ),
              const SizedBox(
                height: 10, // Space between elements
              ),
              ListView.builder(
                scrollDirection: Axis.vertical, // Vertical scrolling
                shrinkWrap: true, // Wrap the list to its content size
                itemBuilder: (context, index) {
                  final ing = icecream.ingredients![index]; // Get each ingredient
                  return Card(
                    child: ListTile(
                      title: Text(ing.name ?? 'Unknown Ingredient'), // Display ingredient name or 'Unknown Ingredient'
                      subtitle: Text("QTY - ${ing.quantity}"), // Display quantity
                    ),
                  );
                },
                itemCount: icecream.ingredients!.length, // Number of ingredients
              ),
            ],
          ),
        ),
      ),
    );
  }
}
