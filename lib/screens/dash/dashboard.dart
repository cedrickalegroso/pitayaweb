import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pitaya_web/services/models.dart';
import 'package:provider/provider.dart';

class DashboardPageMain extends StatefulWidget {
  const DashboardPageMain({Key? key}) : super(key: key);

  @override
  _DashboardPagePageState createState() => _DashboardPagePageState();
}

class _DashboardPagePageState extends State<DashboardPageMain> {
  @override
  void initState() {
    super.initState();
  }

  bool isviewing = false;
  int viewingId = 0;

  @override
  Widget build(BuildContext context) {
    final descriptions = Provider.of<List<Descriptions>>(context);
    final firebaseuser = FirebaseAuth.instance.currentUser;

    return descriptions.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isviewing
                  ? Container(
                      width: 600,
                      height: 600,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 300,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        descriptions[viewingId].photo),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                width: 250,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Name : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(descriptions[viewingId].name),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    const Text(
                                      'Category : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(descriptions[viewingId].category),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    const Text(
                                      'How to Identify : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(descriptions[viewingId].howtoidentify),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    const Text(
                                      'Why and where it occurs : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(descriptions[viewingId]
                                        .whyandwhereoccurs),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    const Text(
                                      'How to manage : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(descriptions[viewingId].howtomanage),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  : Container(
                      height: 600,
                      width: double.infinity,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Click on a something to view details')
                        ],
                      )),
              const Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Diseases',
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                ),
              ),
              Container(
                height: 250, // Set the desired height for your horizontal list
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: descriptions.length,
                  itemBuilder: (context, index) {
                    final description = descriptions[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          isviewing = true;
                          viewingId = index;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(
                            8.0), // Adjust the padding as needed
                        child: Card(

                            // Create a card or any other widget to display each item
                            child: Container(
                          width: 200,
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  image: DecorationImage(
                                    image: NetworkImage(description.photo),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Text(
                                description.uiname,
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              Text(description.category),
                              const Padding(
                                padding: EdgeInsets.only(left: 16, right: 16),
                              )
                            ],
                          ),
                        )),
                      ),
                    );
                  },
                ),
              ),
            ],
          )
        : const Scaffold(
            body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 64,
                    width: 64,
                    child: CircularProgressIndicator(),
                  )
                ]),
          );
  }
}
