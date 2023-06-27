import 'package:flutter/material.dart';
import 'package:sportinfo/model/sport_fact.dart';
class SportListScreen extends StatelessWidget {
  const SportListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[800],
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: facts.length,
            itemBuilder: (context ,index){
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, 'PlaceholderScreen',
                        arguments: facts[index]);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width -16,
                    height: MediaQuery.of(context).size.height /4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      border: Border.all(width: 2, color: Colors.white),
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        tileMode: TileMode.mirror,
                        colors: [
                          Colors.white,
                          Colors.lightGreen,
                        ],
                      ),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(35),
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/images/weather.png',
                            image: facts[index].img,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width /2 -16,
                            height: MediaQuery.of(context).size.height /4,
                            imageErrorBuilder: (context, error, trace) =>
                            const CircularProgressIndicator(),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width /2 - 16,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(facts[index].title, style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[800],
                              overflow: TextOverflow.ellipsis,

                            ),
                              maxLines: 8,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
        ),
      ),
    );
  }
}
