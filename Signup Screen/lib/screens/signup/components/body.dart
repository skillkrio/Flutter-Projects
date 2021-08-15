import 'package:beginner/components/already_have_an_account_check.dart';
import 'package:beginner/components/rounded_input_field.dart';
import 'package:beginner/components/rounded_password_field.dart';
import 'package:beginner/components/roundedbotton.dart';
import 'package:beginner/screens/const.dart';
import 'package:beginner/screens/login/login.dart';
import 'package:beginner/screens/signup/components/background.dart';
import 'package:beginner/screens/signup/components/or_divider.dart';
import 'package:beginner/screens/signup/components/social_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BackGround(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "SignUp",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            SvgPicture.asset(
              "assets/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onchanged: (value) {},
            ),
            RoundedButton(
                text: "SignUp",
                press: () {},
                bgcolor: kPrimaryColor,
                textcolor: Colors.white),
            SizedBox(
              height: size.height * 0.03,
            ),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialIcon(
                  iconsrc: "assets/facebook.svg",
                  press: () {},
                ),
                SocialIcon(
                  iconsrc: "assets/twitter.svg",
                  press: () {},
                ),
                SocialIcon(
                  iconsrc: "assets/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
