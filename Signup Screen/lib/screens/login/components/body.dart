import 'package:beginner/components/already_have_an_account_check.dart';
import 'package:beginner/components/rounded_input_field.dart';
import 'package:beginner/components/rounded_password_field.dart';
import 'package:beginner/components/roundedbotton.dart';
//import 'package:beginner/components/text_field_container.dart';
import 'package:beginner/screens/const.dart';
import 'package:beginner/screens/login/components/background.dart';
import 'package:beginner/screens/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            SvgPicture.asset(
              "assets/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            RoundedInputField(
              hintText: "Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onchanged: (value) {},
            ),
            RoundedButton(
                text: "LOGIN",
                press: () {},
                bgcolor: kPrimaryColor,
                textcolor: Colors.white),
            SizedBox(
              height: size.height * 0.03,
            ),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignupPage();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
