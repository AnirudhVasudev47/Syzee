import 'package:flutter/material.dart';
import 'package:syzee/global/tools.dart';
import 'package:syzee/models/user_model.dart';
import 'package:syzee/services/cart_services.dart';
import 'package:syzee/services/profile_service.dart';
import 'package:syzee/ui/widgets/appbar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late Future<UserModel> user;

  TextEditingController emailText = TextEditingController();
  TextEditingController usernameText = TextEditingController();
  TextEditingController codeText = TextEditingController();
  TextEditingController mobileText = TextEditingController();

  updateUser(context) {
    if (emailText.text == '' || usernameText.text == '' || codeText.text == '' || mobileText.text == '') {
      return displayToast(
        context,
      );
    } else {
      loadingDialog(context, asset: 'assets/images/home/lottie/loading.json');
      updateProfile(usernameText.text, mobileText.text, codeText.text);
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  fetchUserData(UserModel user) async {
      emailText.text = user.email;
      usernameText.text = user.name;
      codeText.text = user.code;
      mobileText.text = user.phone;
  }

  @override
  void initState() {
    super.initState();
    user = getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: FutureBuilder(
          future: user,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserModel data = snapshot.data as UserModel;
              fetchUserData(data);
              return Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25),
                          child: TextField(
                            controller: emailText,
                            enabled: false,
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xff169B93),
                                  width: 1,
                                ),
                              ),
                              hintText: 'Your email',
                              hintStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25),
                          child: TextField(
                            controller: usernameText,
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                            ),
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xff169B93),
                                  width: 1,
                                ),
                              ),
                              hintText: 'Your username',
                              hintStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextField(
                                  controller: codeText,
                                  style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 16,
                                  ),
                                  keyboardType: TextInputType.phone,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xff169B93),
                                        width: 1,
                                      ),
                                    ),
                                    hintText: 'Country Code',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                flex: 6,
                                child: TextField(
                                  controller: mobileText,
                                  style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 16,
                                  ),
                                  keyboardType: TextInputType.phone,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xff169B93),
                                        width: 1,
                                      ),
                                    ),
                                    hintText: 'Your mobile',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      updateUser(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xff169B93),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 70,
                      ),
                    ),
                    child: const Text(
                      'Update Profile',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 55,
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
