import 'package:flutter/material.dart';
import '../model/sport_fact.dart';

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final SportFact fact = facts[Random().nextInt(facts.length)];
    SportFact? fact =
    ModalRoute.of(context)!.settings.arguments as SportFact ?? facts.first ;
    return Scaffold(
      backgroundColor: Colors.green[800],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                color: Colors.white60,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(height:4),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2,
                      child: Stack(
                        children: [
                          Container(
                            // width: MediaQuery.of(context).size.height/3,
                            height: MediaQuery.of(context).size.height / 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35),
                              color: Colors.green[300],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(35),
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/weather.png',
                                image: fact.img,
                                fit: BoxFit.cover,
                                imageErrorBuilder: (context, error, trace) =>
                                    const CircularProgressIndicator(),
                              ),
                            ),
                          ),
                          Align(
                            alignment: const FractionalOffset(0.2, 0.8),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: Colors.white70,
                                borderRadius: BorderRadius.circular(35),
                              ),
                              child: Text(
                                fact.title.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[800],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //const Spacer(),
                    const SizedBox(height: 16),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 4, vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: Colors.white70,
                      ),
                      child: Text(
                        fact.description,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.green[900],
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
