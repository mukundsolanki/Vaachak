import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LearnScreen extends StatelessWidget {
  final String link_asl_basics =
      'https://youtu.be/DaMjr4AfYA0?si=EMSi_vNlIxLy_vJ8';
  final String link_basics_isl =
      'https://youtu.be/DOFPRw6Epl0?si=8UF8LIhABJ0LOc82';
  final String link_feelingn_isl =
      'https://youtu.be/XiyJFuz01PE?si=k6AILTNL63QJau5i';
  final String link_asl_phrases =
      'https://youtu.be/v1desDduz5M?si=csiXTj_ZMk1C-4Fb';
  final String link_article1 =
      'https://www.healthyhearing.com/report/52606-Why-you-should-learn-sign-language-in-the-new-year';
  final String link_article2 =
      'https://def.org.in/indian-sign-language-classes/';

  Future<void> _launchURL(String url) async {
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        await launch(url);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Learnings,', 
                style: TextStyle(fontSize: 35,
                fontWeight: FontWeight.w500),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _launchURL(link_asl_basics);
                },
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  elevation: 3,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(14.0),
                          topRight: Radius.circular(14.0),
                        ),
                        child: Container(
                          height: 180.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                              image: AssetImage("assets/images/asl_basics.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(16.0),
                        child: const Column(
                          children: [
                            Text(
                              "Basics of American Sign Language",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                            ),
                            Text(
                              "Learn ASL Basics: From essential signs to foundational gestures, discover an easy-to-follow guide that introduces you to the basics of communication through ASL. This tutorial is perfect for beginners",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5),
              GestureDetector(
                onTap: () {
                  _launchURL(link_basics_isl);
                },
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  elevation: 3,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(14.0),
                          topRight: Radius.circular(14.0),
                        ),
                        child: Container(
                          height: 180.0,
                          child: Ink(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14.0),
                              image: DecorationImage(
                                image: AssetImage("assets/images/basics_isl.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: const Column(children: [
                          Text(
                            "Learn Indian Sign Language",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Padding(padding: const EdgeInsets.all(5.0)),
                          Text(
                            'This series aims to bring ISL into the public sphere. It is for people who can hear. Medium of instruction will be English. Anyone with a basic understanding of English can gain from this.',
                            style: TextStyle(fontSize: 15),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5),
              GestureDetector(
                onTap: () {
                  _launchURL(link_article1);
                },
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  elevation: 3,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(14.0),
                          topRight: Radius.circular(14.0),
                        ),
                        child: Container(
                          height: 130.0,
                          child: Ink(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14.0),
                              image: DecorationImage(
                                image: AssetImage("assets/images/article_1.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: const Column(children: [
                          Text(
                            "Why you should Learn Sign Language ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Padding(padding: const EdgeInsets.all(5.0)),
                          Text(
                            'Juan Pablo de Bonet is credited with publishing the first sign language instructional book for the deaf in 1620. The book was based on the work of Girolamo Cardano, an Italian physician, who believed that it wasn’t necessary to hear words in order to understand ideas.',
                            style: TextStyle(fontSize: 15),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5),
              GestureDetector(
                onTap: () {
                  _launchURL(link_feelingn_isl);
                },
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  elevation: 3,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(14.0),
                          topRight: Radius.circular(14.0),
                        ),
                        child: Container(
                          height: 170.0,
                          child: Ink(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14.0),
                              image: DecorationImage(
                                image: AssetImage("assets/images/feelingin_isl.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(16.0),
                        alignment: Alignment.centerLeft,
                        child: const Column(children: [
                          Text(
                            "Express feelings and emotion in ISL",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Padding(padding: const EdgeInsets.all(5.0)),
                          Text(
                            "Learn about the subtle nuances and intricate hand movements that encapsulate emotions in Indian Sign Language. Explore a diverse range of feelings, from the warmth of happiness to the depths of sorrow, understanding the cultural context behind each expression",
                            style: TextStyle(fontSize: 15),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5),
              GestureDetector(
                onTap: () {
                  _launchURL(link_asl_phrases);
                },
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  elevation: 3,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(14.0),
                          topRight: Radius.circular(14.0),
                        ),
                        child: Container(
                          height: 180.0,
                          child: Ink(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14.0),
                              image: DecorationImage(
                                image: AssetImage("assets/images/asl_phrases.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: const Column(children: [
                          Text(
                            "ASL Phrases",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Padding(padding: const EdgeInsets.all(5.0)),
                          Text(
                            'This tutorial aims to empower individuals of all backgrounds to communicate inclusively through ASL. With demonstrations and practical examples, we strive to make learning ASL an engaging and accessible experience for everyone.',
                            style: TextStyle(fontSize: 15),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5),
              GestureDetector(
                onTap: () {
                  _launchURL(link_article2);
                },
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  elevation: 3,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(14.0),
                          topRight: Radius.circular(14.0),
                        ),
                        child: Container(
                          height: 180.0,
                          child: Ink(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14.0),
                              image: DecorationImage(
                                image: AssetImage("assets/images/article2.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: const Column(children: [
                          Text(
                            "Deaf Enabled Foundation",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Padding(padding: const EdgeInsets.all(5.0)),
                          Text(
                            'DEF aims to bridge the gap between hearing and Deaf people in society. With this goal in mind, we provide Sign Language courses for anyone who is interested in learning it as a language.',
                            style: TextStyle(fontSize: 15),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}