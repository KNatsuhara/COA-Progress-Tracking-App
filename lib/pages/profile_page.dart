import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utilities/app_bar_wrapper.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final buttonColor = Colors.green[700]!;
  final user = FirebaseAuth.instance.currentUser!;

  String username = "user1";
  String name = "Johnny buah";
  String password = "****";
  String groupName = "Group1";

  //change text controller
  late TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState()
  {
    super.initState();
    getProfileData();
  }

  Future<String?> changeField() {
    return showDialog<String>(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey[900],
            content: TextField(
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white))),
              controller: controller,
              style: const TextStyle(color: Colors.white),
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop(controller.text);
                  controller.clear();
                },
                child: Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.black,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  controller.clear();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.black,
              ),
            ],
          );
        });
  }
  
  Future updateProfileField(String fieldname, String newvalue) async
  {
    if(fieldname == "password")
      {
        var user = FirebaseAuth.instance.currentUser;
        user?.updatePassword(newvalue).then((_) {
          print("Password updated successfully");
        }).catchError((error) {
          print("Error updating password: $error");
          // handle the error here
        });
        return;
      }
    else if(fieldname == "Name") {
      List<String> words = newvalue.split(" ");
      if (words.length == 2) {
        var updateUserField = await FirebaseFirestore.instance.collection(
            'users').doc(user.uid)
            .update({"firstName": words[0]}).then(
                (value) => print("firstName successfully updated!"),
            onError: (e) => print("Error updating document $e"));
        var updateUserField2 = await FirebaseFirestore.instance.collection('users').doc(user.uid)
            .update({"lastName": words[1]}).then(
                (value) => print("lastName successfully updated!"),
            onError: (e) => print("Error updating document $e"));
        return;
      }
      else {
        print("Error: Name not in correct format");
        return;
      }
      }
    var updateUserField = await FirebaseFirestore.instance.collection('users').doc(user.uid)
        .update({fieldname: newvalue}).then(
            (value) => print("${fieldname} successfully updated!"),
        onError: (e) => print("Error updating document $e"));

    return;
  }

  Future getProfileData() async {
    // Get user collection
    final CollectionReference userCollection =
    FirebaseFirestore.instance.collection('users');

    // Get current doc
    final docRef = userCollection.doc(user.uid);
    await docRef.get().then(
          (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        username = data['username'];
        name = data['firstName'] + ' ' + data['lastName'];
      },
      onError: (e) => print("Error getting document: $e"),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.grey[350],

        /// ***** App Bar ***** ///
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBarWrapper(
            title: "Profile",
          ),
        ),
        body: Container(
            child: Column(
          children: [
            //add more rows for additional settings
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border: Border(
                      bottom: BorderSide(color: Colors.grey)
                  )
              ),
              child: Row(
                //NOTE: Username row
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IntrinsicWidth(
                    child: Container(
                        //width: width * 0.5,
                        constraints: BoxConstraints(
                            minWidth: width * 0.1, maxWidth: width * 0.6),
                        // username textbox container
                        margin: EdgeInsets.symmetric(
                            horizontal: width * 0.025,
                            vertical: height * 0.025),
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.02, vertical: height * 0.015),
                        decoration: BoxDecoration(
                          //color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Text(
                            'Username: $username',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: Colors.black,
                              fontSize: width * 0.05,
                            ),
                          ),
                        )),
                  ),
                  Flexible(
                    //container for edit button
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: width * 0.05, vertical: height * 0.01),
                      child: SizedBox(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            bool valid = false;
                            final name = await changeField();
                            setState(() {
                              if (name != null &&
                                  name.length < 30 &&
                                  name.isNotEmpty &&
                                  !RegExp(r"/s").hasMatch(name)) {
                                this.username = name;
                                valid = true;
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Invalid Username"),
                                  duration: Duration(seconds: 2),
                                ));
                              }
                            });
                            //put in database
                            if(valid == true)
                              {
                                updateProfileField("username", name!);
                              }
                          },
                          icon: const Icon(Icons.edit),
                          label: const Text('Edit'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // NOTE: Name container
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border: Border(
                      bottom: BorderSide(color: Colors.grey)
                  )
              ),
              child: Row(
                //NOTE: Username row
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IntrinsicWidth(
                    child: Container(
                        // username textbox container
                        constraints: BoxConstraints(
                            minWidth: width * 0.1, maxWidth: width * 0.6),
                        margin: EdgeInsets.symmetric(
                            horizontal: width * 0.025,
                            vertical: height * 0.025),
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.02, vertical: height * 0.015),
                        decoration: BoxDecoration(
                          //color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Text(
                            'Name: $name',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: Colors.black,
                              fontSize: width * 0.05,
                            ),
                          ),
                        )),
                  ),
                  Flexible(
                    //container for edit button
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: width * 0.05, vertical: height * 0.01),
                      child: SizedBox(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            bool valid = false;
                            final name = await changeField();
                            List<String>? words = name?.split(" ");
                            setState(() {
                              if (name != null &&
                                  name.length < 30 &&
                                  name.isNotEmpty &&
                                  !RegExp(r"/s").hasMatch(name) && words?.length == 2) {
                                this.name = name;
                                valid = true;
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Invalid"),
                                  duration: Duration(seconds: 2),
                                ));
                              }
                            });
                            //put in database
                            if(valid == true)
                            {
                              updateProfileField("Name", name!);
                            }
                          },
                          icon: const Icon(Icons.edit),
                          label: const Text('Edit'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //NOTE: Password container
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border: Border(
                      bottom: BorderSide(color: Colors.grey)
                  )
              ),
              child: Row(
                //NOTE: Username row
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IntrinsicWidth(
                    child: Container(
                        // username textbox container
                        constraints: BoxConstraints(
                            minWidth: width * 0.1, maxWidth: width * 0.6),
                        margin: EdgeInsets.symmetric(
                            horizontal: width * 0.025,
                            vertical: height * 0.025),
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.02, vertical: height * 0.015),
                        decoration: BoxDecoration(
                          //color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Text(
                            'Password: $password',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: Colors.black,
                              fontSize: width * 0.05,
                            ),
                          ),
                        )),
                  ),
                  Flexible(
                    //container for edit button
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: width * 0.05, vertical: height * 0.01),
                      child: SizedBox(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            bool valid = false;
                            final name = await changeField();
                            setState(() {
                              if (name != null &&
                                  name.length < 30 &&
                                  name.isNotEmpty &&
                                  !RegExp(r"/s").hasMatch(name)) {
                                this.password = name;
                                valid = true;
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Invalid"),
                                  duration: Duration(seconds: 2),
                                ));
                              }
                            });
                            //put in database
                            if(valid == true)
                            {
                              //TODO: update password
                              updateProfileField("password", name!);
                            }
                          },
                          icon: const Icon(Icons.edit),
                          label: const Text('Edit'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //NOTE: Group container
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border: Border(
                      bottom: BorderSide(color: Colors.grey)
                  )
              ),

            )
          ],
        )));
  }
}
