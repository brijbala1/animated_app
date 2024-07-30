import 'dart:ui';
import 'package:animated_app/widget/sign_in_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late RiveAnimationController _btnAnimationController;

  bool isSignInDialogueShown = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _btnAnimationController = OneShotAnimation("active", autoplay: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
            width: MediaQuery.of(context).size.width * 1.7,
            bottom: 100,
            left: 100,
            child: Image.asset("assets/Backgrounds/Spline.png")),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
            child: const SizedBox(),
          ),
        ),
        const RiveAnimation.asset("assets/RiveAssets/shapes.riv"),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
            child: const SizedBox(),
          ),
        ),

        ///add text in this line
        AnimatedPositioned(
            top: isSignInDialogueShown ? -50 : 0,
            duration: Duration(milliseconds: 240),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    const SizedBox(
                      width: 260,
                      child: Column(
                        children: [
                          Text(
                            "Learn design & code",
                            style: TextStyle(
                                fontSize: 60,
                                fontFamily: "poppins",
                                height: 1.2),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.")
                        ],
                      ),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    GestureDetector(
                      onTap: () {
                        _btnAnimationController.isActive = true;
                        Future.delayed(Duration(milliseconds: 800), () {
                          customSigningDialog(context);
                          isSignInDialogueShown = true;
                        });
                      },
                      child: SizedBox(
                          height: 64,
                          width: 260,
                          child: Stack(
                            children: [
                              RiveAnimation.asset(
                                "assets/RiveAssets/button.riv",
                                controllers: [_btnAnimationController],
                              ),
                              const Positioned.fill(
                                top: 8,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(CupertinoIcons.arrow_right),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Start the course",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                          "Hello, welcome to my new Flutter series focused entirely on animation. This is the app we are planning to build."),
                    ),
                  ],
                ),
              ),
            )),
      ],
    ));
  }

  Future<Object?> customSigningDialog(BuildContext context) {
    return showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: 'Sign In',
      transitionDuration: Duration(milliseconds: 400),
      transitionBuilder: (context, animation, sec_anim, child) {
        Tween<Offset> tween;
        tween = Tween(begin: Offset(0, -1), end: Offset.zero);
        return SlideTransition(
          position: tween.animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          ),
          child: child,
        );
      },
      context: context,
      pageBuilder: (context, _, __) => Center(
        child: Container(
          height: 600,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 25),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(.94),
              borderRadius: BorderRadius.circular(40)),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Sign In",
                          style: TextStyle(
                              fontSize: 34, fontWeight: FontWeight.bold),
                        ),
                        CircleAvatar(
                            radius: 20,
                            backgroundColor: Color(0xFFF77D8E),
                            child: IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ))
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        "Design 240+ hours of content. Learn designn and code,By build real app.",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SignInForm(),
                  ],
                ),
              )),
        ),
      ),
    ).then((onValue) {
      print("object");
      setState(() {
        isSignInDialogueShown = false;
      });
    });
  }
}
