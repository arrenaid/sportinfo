import 'package:flutter/material.dart';
import '../model/sport_fact.dart';

class PlaceholderAlertScreen extends StatelessWidget {
  const PlaceholderAlertScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SportFact? fact =
        ModalRoute.of(context)!.settings.arguments as SportFact;
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const SizedBox(height: 4),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/weather.png',
                      width: double.maxFinite,
                      image: fact.img,
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, trace) =>
                          const CircularProgressIndicator(),
                    ),
                  ),
                ),
                const SizedBox(height: 26),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    fact.title.toUpperCase(),
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrangeAccent[700],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  fact.description,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.65)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
