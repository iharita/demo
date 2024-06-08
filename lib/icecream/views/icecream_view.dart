import 'dart:convert';
import 'package:demo/icecream/model/icecream.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IceCreamView extends StatelessWidget {
  const IceCreamView({Key? key}) : super(key: key);

  Future<List<Icecreams>?> loadIcecreams() async {
    final rawIcecreams = await rootBundle.loadString("assets/icecream.json");
    await Future.delayed(const Duration(seconds: 1));
    final Map<String, dynamic> jsonMap = jsonDecode(rawIcecreams);
    final icecreamsData = IcecreamsData.fromJson(jsonMap);
    return icecreamsData.icecreams;
  }

  @override
  Widget build(BuildContext context) {
    Icecreams? selectedIcecream;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Icecreams",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Text(
            "We have something yummy for you",
            style: Theme.of(context).textTheme.bodySmall!,
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FutureBuilder<List<Icecreams>?>(
                  future: loadIcecreams(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData && snapshot.data != null) {
                        final icecreams = snapshot.data!;
                        selectedIcecream = icecreams[0];
                        if (icecreams.isNotEmpty) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width,
                                height: MediaQuery.sizeOf(context).height / 2,
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    final icecream = icecreams[index];
                                    return SizedBox(
                                      width: 200,
                                      child: Card(
                                        clipBehavior: Clip.hardEdge,
                                        color: Colors.orange.shade100,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16)),
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            Image.network(
                                              icecream.image!,
                                              fit: BoxFit.cover,
                                              color: Colors.orange.withOpacity(0.5),
                                              colorBlendMode: BlendMode.color,
                                            ),
                                            Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(16.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(icecream.flavour,
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .labelLarge),
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
                                    );
                                  },
                                  scrollDirection: Axis.horizontal,
                                  itemCount: icecreams.length,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          );
                        } else {
                          return const Text("No ice creams available");
                        }
                      } else {
                        return const Text("Failed to load ice creams");
                      }
                    } else {
                      return const CircularProgressIndicator.adaptive();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Text(
// "Toppings for you",
// style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// ),
// SizedBox(
// height: 20,
// ),
// ListView.builder(
// shrinkWrap: true,
// itemBuilder: (context, index) {
// final topping = selectedIcecream!.toppings![index];
// return ListTile(
// leading: CircleAvatar(backgroundImage: NetworkImage(selectedIcecream!.image!),),
// title: Text(topping),);
// },
// scrollDirection: Axis.vertical,
// itemCount: selectedIcecream!.toppings!.length,
// ),