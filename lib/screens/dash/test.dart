import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pitaya_web/services/database.dart';
import 'package:pitaya_web/services/models.dart';
import 'package:provider/provider.dart';

class CreateNew extends StatefulWidget {
  const CreateNew({Key? key}) : super(key: key);

  @override
  _DashboardPagePageState createState() => _DashboardPagePageState();
}

class _DashboardPagePageState extends State<CreateNew> {
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

  @override
  Widget build(BuildContext context) {
    final descriptions = Provider.of<List<Descriptions>>(context);
    final firebaseuser = FirebaseAuth.instance.currentUser;

    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 16),
        child: Form(
          key: _formKey,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text('Add IMG')],
                        ),
                      ),
                    )
                  : Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image: DecorationImage(
                          image: NetworkImage(featuredImageLink),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              SizedBox(
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
              SizedBox(
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
              SizedBox(
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
              SizedBox(
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
              SizedBox(
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
              SizedBox(
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
              SizedBox(
                height: 24,
              ),
              Container(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          DatabaseService(uid: firebaseuser!.uid).insertnewData(
                              cause.text.trim(),
                              howtoidentify.text.trim(),
                              whyandwhereoccurs.text.trim(),
                              howtomanage.text.trim(),
                              name.text.trim(),
                              category.text.trim(),
                              featuredImageLink);
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
                      child: Text('SUBMIT DATA')))
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
