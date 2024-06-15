import 'dart:convert'; // Import for JSON encoding and decoding
import 'package:cached_network_image/cached_network_image.dart'; // Import for caching network images
import 'package:demo/icecream/model/icecream.dart'; // Import for icecream model
import 'package:demo/icecream/views/icecream_detail_view.dart'; // Import for icecream detail view
import 'package:flutter/cupertino.dart'; // Import for Cupertino widgets
import 'package:flutter/material.dart'; // Import for Material design widgets
import 'package:flutter/services.dart'; // Import for loading assets

class IceCreamView extends StatelessWidget {
  const IceCreamView({Key? key}) : super(key: key);

  // Function to load ice cream data from a JSON file
  Future<List<Icecreams>?> loadIcecreams() async {
    // Load the JSON file as a string
    final rawIcecreams = await rootBundle.loadString("assets/icecream.json");
    // Simulate a delay to mimic loading time
    await Future.delayed(const Duration(seconds: 1));
    // Decode the JSON string into a map
    final Map<String, dynamic> jsonMap = jsonDecode(rawIcecreams);
    // Convert the JSON map into an IcecreamsData object
    final icecreamsData = IcecreamsData.fromJson(jsonMap);
    // Return the list of ice creams
    return icecreamsData.icecreams;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Title text
          const Text(
            "Icecreams",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          // Subtitle text
          Text(
            "We have something yummy for you",
            style: Theme.of(context).textTheme.bodySmall!,
          ),
          const SizedBox(
            height: 30,
          ),
          // Expanded widget to make the FutureBuilder take the remaining space
          Expanded(
            // FutureBuilder to handle asynchronous loading of ice cream data
            child: FutureBuilder<List<Icecreams>?>(
              future: loadIcecreams(),
              builder: (context, snapshot) {
                // Check if the Future is done
                if (snapshot.connectionState == ConnectionState.done) {
                  // Check if the snapshot has data
                  if (snapshot.hasData && snapshot.data != null) {
                    final icecreams = snapshot.data!;
                    // Check if there are any ice creams
                    if (icecreams.isNotEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ListView.builder to display ice creams horizontally
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width,
                            height: MediaQuery.sizeOf(context).height / 2,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                final icecream = icecreams[index];
                                return SizedBox(
                                  width: 200,
                                  child: InkWell(
                                    onTap: () {
                                      // Navigate to the detail view when tapped
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  IcecreamDetailView(
                                                      icecream: icecream)));
                                    },
                                    child: Card(
                                      elevation: 5,
                                      clipBehavior: Clip.hardEdge,
                                      color: Colors.orange.shade100,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(16)),
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          // Hero widget for smooth image transition
                                          Hero(
                                            tag: icecream.image!,
                                            child: CachedNetworkImage(
                                              imageUrl: icecream.image!,
                                              fit: BoxFit.cover,
                                              color: Colors.orange.withOpacity(0.5),
                                              colorBlendMode: BlendMode.color,
                                            ),
                                          ),
                                          // Container for displaying ice cream details
                                          Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Container(
                                                padding:
                                                const EdgeInsets.all(16.0),
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                    BorderRadius.only(
                                                        topRight: Radius
                                                            .circular(16),
                                                        bottomRight:
                                                        Radius.circular(
                                                            16))),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  mainAxisSize:
                                                  MainAxisSize.min,
                                                  children: [
                                                    // Display ice cream flavor
                                                    Text(icecream.flavour,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelLarge),
                                                    // Display ice cream price
                                                    Text(
                                                        "\$${icecream.price.toString()}",
                                                        style: const TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold,
                                                        )),
                                                  ],
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              scrollDirection: Axis.horizontal,
                              itemCount: icecreams.length,
                            ),
                          ),
                        ],
                      );
                    } else {
                      // Display message if no ice creams are available
                      return const Text("No ice creams available");
                    }
                  } else {
                    // Display message if failed to load ice creams
                    return const Text("Failed to load ice creams");
                  }
                } else {
                  // Display a loading indicator while the Future is not done
                  return Center(child: const CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}