import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strolls/features/home/presentation/pages/home_page.dart';
import 'package:strolls/features/home/presentation/pages/main_page.dart';
import 'package:strolls/features/home/presentation/widgets/background_with_circles.dart';
import 'package:strolls/features/home/presentation/widgets/glass_container.dart';
import 'package:strolls/features/home/presentation/widgets/gradient_text_field.dart';
import 'package:strolls/features/home/presentation/widgets/white_button.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  TextEditingController username = TextEditingController(), password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackgroundWithCircles(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 25, right: 20, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: const Text(
                          "Sign in",
                          style: TextStyle(
                              color: Colors.white,
                              height: 1.2,
                              fontSize: 56,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: GlassContainer(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 5),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          child: Center(
                                            child: Text(
                                              "Strolls",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 35,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.topCenter,
                                                child: GradientTextField(
                                                  label: "Username or email",
                                                  hint: "Password",
                                                  controller:
                                                      username,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.bottomCenter,
                                                child: GradientTextField(
                                                  label: "Password",
                                                  hint: "Password",
                                                  controller:
                                                      password,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(flex: 2,)
                                    ],
                                  ),
                                  Positioned(
                                    bottom: 25,
                                    child: GestureDetector(
                                      onTap: (){
                                        showCupertinoDialog(context: context, barrierDismissible:true,builder: (context){
                                          return CupertinoAlertDialog(content: Text("In developing"),title: Text("Soon"), actions: [
                                            CupertinoDialogAction(child: Text("Ok",style: TextStyle(color: Colors.blue),),isDefaultAction: true,onPressed: (){
                                              Navigator.pop(context);
                                            },)
                                          ],);
                                        });
                                      },
                                      child: Text(
                                        "I have not an account.",
                                        style: TextStyle(
                                            color: Colors.white.withOpacity(0.7),
                                            fontSize: 16),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(child: Align(alignment: Alignment.bottomCenter,child: WhiteButton(text: "Continue", onTap: () {
                        if(username.text == "adm" && password.text == "pass"){
                          Navigator.push(context, CupertinoPageRoute(builder: (context){
                            return MainPage();
                          }));
                        }
                        else{
                          showCupertinoDialog(context: context, barrierDismissible:true,builder: (context){
                            return CupertinoAlertDialog(content: Text("Username or Password is wrong"),title: Text("Oooops!"),actions: [
                              CupertinoDialogAction(child: Text("Ok",style: TextStyle(color: Colors.blue),),isDefaultAction: true,onPressed: (){
                                Navigator.pop(context);
                              },)
                            ],);
                          });

                        }
                      }))),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
