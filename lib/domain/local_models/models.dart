//Onboarding View Models
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:staggered_animated_widget/staggered_animated_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../presentation/components/constants/general_strings.dart';
import '../../presentation/components/constants/route_strings_manager.dart';
import '../../presentation/components/constants/routs_manager.dart';
import '../models/user_model.dart';

//movie show models
class MovieCard extends StatefulWidget {
  final String title;
  final String description;
  final String imageUrl;

  const MovieCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  MovieCardState createState() => MovieCardState();
}

class MovieCardState extends State<MovieCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          setState(() {
            _isExpanded = true;
          });
        },
        child: Stack(
          children: [
            StaggeredAnimatedWidget(
              delay: 200,
              child: Positioned.fill(
                child: SizedBox(
                  width: double.infinity, // لضمان عرض كامل
                  height: double.infinity, // لضمان طول كامل
                  child: Image.asset(
                    'assets/lion.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: StaggeredAnimatedWidget(
                delay: 500,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: _isExpanded
                      ? MediaQuery.of(context).size.height * 0.75
                      : MediaQuery.of(context).size.height * 0.45,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0.009),
                        Colors.white.withOpacity(0.4),
                        Colors.white.withOpacity(0.8),
                        Colors.white,
                      ],
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          StaggeredAnimatedWidget(
                            delay: 750,
                            child: Padding(
                              padding: _isExpanded
                                  ? const EdgeInsets.only(
                                      bottom: 32, left: 32, right: 32, top: 60)
                                  : const EdgeInsets.only(
                                      right: 32, left: 32, bottom: 16, top: 50),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.title,
                                        maxLines: _isExpanded ? null : 1,
                                        overflow: _isExpanded
                                            ? null
                                            : TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.black,
                                        ),
                                      ),
                                      _isExpanded
                                          ? GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _isExpanded = false;
                                                });
                                              },
                                              child: const CircleAvatar(
                                                radius: 12,
                                                backgroundColor: Colors.red,
                                                child: Icon(
                                                  Icons.minimize,
                                                  color: Colors.black,
                                                  size: 16,
                                                ),
                                              ),
                                            )
                                          : const SizedBox(),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    widget.description,
                                    maxLines: _isExpanded ? null : 2,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          StaggeredAnimatedWidget(
                            delay: 1000,
                            child: MaterialButton(
                              onPressed: () {},
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Center(child: Text('Book')),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
navigatorToTheMain(context){
  navigateTo(context!, RouteStringsManager.mainRoute);

}
// handle firebase auth by google and apple

User? currentUser = FirebaseAuth.instance.currentUser;
//initialize in splash screen
List<String> userIds =[];

//sign in with google .>>
final GoogleSignIn _googleSignIn = GoogleSignIn(
  clientId:
      '738356872374-8bdei58fqh2bkocfk0ph7dm3ud6jf4gl.apps.googleusercontent.com',
);

String ? userEmail ;
String ? photoUrl ;
Future<AuthCredential> signInWithGoogle(context) async {
  final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;
  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  return credential;
}

//sign in with apple
//i didn't implement it correctly bcz they want 99$ ^_^
Future<AuthCredential> signInWithApple() async {
  final appleCredential = await SignInWithApple.getAppleIDCredential(
    scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName,
    ],
  );

  final oAuthProvider = OAuthProvider("apple.com");

  final credential = oAuthProvider.credential(
    idToken: appleCredential.identityToken,
    accessToken: appleCredential.authorizationCode,
  );
  return credential;
}


//create new user
Future<UserCredential> createUserAtFirebase(
    {required GlobalKey<FormState>? formKey,
    required String email,
    required String password,
    required String fullName}) async {
  UserCredential credential = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: password);
  return credential;
}




//add user to firebase
Future<void> addUserToFirebase(
    {required String? email,required String? fullName ,String ? uid , String ? userPhotoUrl }) async {
  UserModel userModel= UserModel(
      email: email,
      fullName: fullName,
    id: uid,
    userPhotoUrl: userPhotoUrl,
    );
if(!userIds.contains(userModel.id)) {
  await FirebaseFirestore.instance
      .collection(GeneralStrings.users)
      .doc(currentUser!.uid)
      .set(userModel.toJson());
}

}


