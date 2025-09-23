import 'package:ayurvedic_clinic_app/presentation/providers/registerPatients_provider.dart';
import 'package:ayurvedic_clinic_app/presentation/screens/patients_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ayurvedic_clinic_app/presentation/providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;

    final auth = context.watch<AuthProvider>();
    context.read<RegisterPatientProvider>();

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: screenHeight * (217 / 896),
              width: screenWidth,
              color: Colors.transparent,
              child: Stack(
                children: [
                  Image.asset(
                    'lib/assets/images/_login.png',
                    fit: BoxFit.cover,
                    width: screenSize.width,
                  ),
                  Center(
                    child: Container(
                      color: Colors.transparent,
                      height: screenHeight * (84 / 896),
                      width: screenWidth * (80 / 414),
                      child: Image.asset(
                        'lib/assets/images/logo2.png',
                        fit: BoxFit.contain,
                        height: screenHeight * (84 / 896),
                        width: screenWidth * (80 / 414),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: screenSize.height * 0.8,
              width: screenSize.width,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Center(
                  child: Container(
                    color: Colors.transparent,
                    width: screenWidth * (350 / 414),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: screenHeight * (81 / 896),
                          width: screenWidth * (350 / 414),
                          color: Colors.transparent,
                          child: Text(
                            'Login Or Register To Book Your Appointments',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                              height: 1.4,
                              letterSpacing: 0,
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Email',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            height: 1,
                            letterSpacing: 0,
                          ),
                        ),
                        SizedBox(height: 6),
                        SizedBox(
                          height: screenHeight * (50 / 896),
                          child: TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFD9D9D9).withOpacity(0.25),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.53),
                                ),
                              ),
                              hintText: 'Enter Your Email',
                              hintStyle: GoogleFonts.inter(
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                height: 1,
                              ),
                              fillColor: Color(0xFFD9D9D9).withOpacity(0.25),
                              filled: true,
                            ),
                          ),
                        ),
                        SizedBox(height: 25.2),
                        Text(
                          'Password',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            height: 1,
                            letterSpacing: 0,
                          ),
                        ),
                        SizedBox(height: 6),
                        SizedBox(
                          height: screenHeight * (50 / 896),
                          child: TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFD9D9D9).withOpacity(0.25),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.53),
                                ),
                              ),
                              hintText: 'Enter Your Password',
                              hintStyle: GoogleFonts.inter(
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                height: 1,
                              ),
                              fillColor: Color(0xFFD9D9D9).withOpacity(0.25),
                              filled: true,
                            ),
                          ),
                        ),
                        SizedBox(height: 84.02),
                        Container(
                          height: screenHeight * (50 / 896),
                          width: screenWidth * (350 / 414),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF006837),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.52),
                              ),
                            ),
                            onPressed: auth.isLoading
                                ? null
                                : () async {
                                    final email = _emailController.text.trim();
                                    final password = _passwordController.text
                                        .trim();
                                    if (email.isEmpty || password.isEmpty) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Enter email and password',
                                          ),
                                        ),
                                      );
                                      return;
                                    }

                                    final success = await context
                                        .read<AuthProvider>()
                                        .login(email, password);

                                    if (success) {
                                      final token = context
                                          .read<AuthProvider>()
                                          .token;
                                      print('Token: $token');

                                      final registerProvider = context
                                          .read<RegisterPatientProvider>();
                                      registerProvider.setToken(token!);

                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PatientsScreen(),
                                        ),
                                      );

                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text('Login success'),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(content: Text('Login failed')),
                                      );
                                    }
                                  },

                            child: Text(
                              'Login',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 104),
                        Container(
                          height: screenHeight * (55 / 896),
                          width: screenHeight * (350 / 414),
                          color: Colors.transparent,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      "By creating or logging into an account you are agreeing with our ",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12,
                                  ),
                                ),
                                TextSpan(
                                  text: "Terms and Conditions",
                                  style: GoogleFonts.poppins(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    letterSpacing: 1,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      print("Terms clicked");
                                    },
                                ),
                                TextSpan(
                                  text: " and ",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12,
                                  ),
                                ),
                                TextSpan(
                                  text: "Privacy Policy",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    letterSpacing: 1,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      print("Privacy clicked");
                                    },
                                ),
                                TextSpan(text: "."),
                              ],
                            ),
                          ),
                        ),
                      ],
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
