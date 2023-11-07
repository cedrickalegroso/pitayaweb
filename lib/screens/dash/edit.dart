import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pitaya_web/services/database.dart';
import 'package:pitaya_web/services/models.dart';
import 'package:provider/provider.dart';

class EditPrev extends StatefulWidget {
  const EditPrev({Key? key}) : super(key: key);

  @override
  _DashboardPagePageState createState() => _DashboardPagePageState();
}

class _DashboardPagePageState extends State<EditPrev> {
  @override
  void initState() {
    super.initState();
  }

  final cause = TextEditingController();
  final howtoidentify = TextEditingController();
  final whyandwhereoccurs = TextEditingController();
  final howtomanage = TextEditingController();
  final name = TextEditingController();
  final category = TextEditingController();
  final photo = TextEditingController();

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); //ma identify na its a form

  bool hasimg = false;

  XFile? featuredImage;

  final _imagePicker = ImagePicker();

  String featuredImageLink = "";

  int selectedEdit = 0;
  bool haspicked = false;

  String postuid = "";

  @override
  Widget build(BuildContext context) {
    final descriptions = Provider.of<List<Descriptions>>(context);
    final firebaseuser = FirebaseAuth.instance.currentUser;

    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              haspicked
                  ? Container(
                      child: Column(
                        children: [
                          !hasimg
                              ? GestureDetector(
                                  onTap: () {
                                    pickFeaturedImage(firebaseuser!.uid);
                                  },
                                  child: Container(
                                    width: 250,
                                    height: 250,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Colors.grey,
                                    ),
                                    child: const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [Text('Add IMG')],
                                    ),
                                  ),
                                )
                              : Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        pickFeaturedImage(firebaseuser!.uid);
                                      },
                                      child: Container(
                                        width: 250,
                                        height: 250,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          image: DecorationImage(
                                            image:
                                                NetworkImage(featuredImageLink),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Text('Click the image to change')
                                  ],
                                ),
                          const SizedBox(
                            height: 24,
                          ),
                          TextFormField(
                            controller: name,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please enter the name';
                              }
                              return null;
                            },
                            onChanged: (event) {
                              setState(() {
                                name.text.trim();
                              });
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: cause,
                            decoration: InputDecoration(
                              labelText: 'cause',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please enter the cause';
                              }
                              return null;
                            },
                            onChanged: (event) {
                              setState(() {
                                cause.text.trim();
                              });
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: howtoidentify,
                            decoration: InputDecoration(
                              labelText: 'How to Identify',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please enter How to Identify';
                              }
                              return null;
                            },
                            onChanged: (event) {
                              setState(() {
                                howtoidentify.text.trim();
                              });
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: whyandwhereoccurs,
                            decoration: InputDecoration(
                              labelText: 'Why and Where it Occurs',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please enter Why and Where it Occurs';
                              }
                              return null;
                            },
                            onChanged: (event) {
                              setState(() {
                                whyandwhereoccurs.text.trim();
                              });
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: howtomanage,
                            decoration: InputDecoration(
                              labelText: 'How to manage',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please enter How to manage';
                              }
                              return null;
                            },
                            onChanged: (event) {
                              setState(() {
                                howtomanage.text.trim();
                              });
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: category,
                            decoration: InputDecoration(
                              labelText: 'Category',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please enter the category';
                              }
                              return null;
                            },
                            onChanged: (event) {
                              setState(() {
                                category.text.trim();
                              });
                            },
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      DatabaseService(uid: firebaseuser!.uid)
                                          .updateData(
                                              cause.text.trim(),
                                              howtoidentify.text.trim(),
                                              whyandwhereoccurs.text.trim(),
                                              howtomanage.text.trim(),
                                              name.text.trim(),
                                              category.text.trim(),
                                              featuredImageLink,
                                              postuid);
                                    }

                                    // var response = await context
                                    //     .read<DatabaseService>()
                                    //     .insertnewData(
                                    //         cause,
                                    //         howtoidentify,
                                    //         whyandwhereoccurs,
                                    //         howtomanage,
                                    //         name,
                                    //         category,
                                    //         featuredImageLink);

                                    // response ? _pushtoLogin() : _showMessageError(response);
                                  },
                                  child: const Text('UPDATE DATA'))),
                        ],
                      ),
                    )
                  : const SizedBox(
                      height: 600,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text('Pick something below to edit')],
                      ),
                    ),
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                height: 250, // Set the desired height for your horizontal list
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: descriptions.length,
                  itemBuilder: (context, index) {
                    final description = descriptions[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          postuid = description.uid;
                          haspicked = true;
                          hasimg = true;
                          selectedEdit = index;

                          cause.text = description.cause;
                          name.text = description.name;
                          whyandwhereoccurs.text =
                              description.whyandwhereoccurs;

                          howtoidentify.text = description.howtoidentify;

                          howtomanage.text = description.howtomanage;

                          category.text = description.category;

                          featuredImageLink = description.photo;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(
                            8.0), // Adjust the padding as needed
                        child: Card(

                            // Create a card or any other widget to display each item
                            child: SizedBox(
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
          ),
        ),
      ),
    );
  }

  void _showMessageError(msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          msg,
          style: const TextStyle(color: Colors.white),
        )));
  }

  void _pushtoLogin() {
    Navigator.pushNamed(context, '/authCheck');
  }

  String generateRandomString(int len) {
    var r = Random();
    return String.fromCharCodes(
        List.generate(len, (index) => r.nextInt(33) + 89));
  }

  pickFeaturedImage(uid) async {
    featuredImage = await _imagePicker.pickImage(source: ImageSource.gallery);

    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('/$uid')
        .child('medias')
        .child('places')
        .child(uid)
        .child('featured')
        .child('${generateRandomString(5) + uid}.png');

    firebase_storage.UploadTask uploadTask;
    uploadTask = ref.putData(await featuredImage!.readAsBytes());

    await uploadTask;

    await ref.getDownloadURL().then((fileUrl) {
      featuredImageLink = fileUrl;
      setState(() {
        hasimg = true;
      });
    });
  }
}
