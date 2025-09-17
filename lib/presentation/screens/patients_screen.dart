import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PatientsScreen extends StatefulWidget {
  const PatientsScreen({super.key});

  @override
  State<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  String selectedValue = "This Week"; // default value

  final List<String> options = ["This Week", "This Month", "This Year"];

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back_rounded),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none)),
          ],
        ),
        body: Column(
          children: [
            Container(
              height: screenHeight * (121 / 896),
              width: screenWidth,
              color: Colors.transparent,
              child: Column(
                children: [
                  Container(
                    height: screenHeight * (40 / 896),
                    width: screenWidth * (360 / 414),
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: screenWidth * (249 / 414),
                          color: Colors.transparent,
                          child: TextField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              hintText: 'Search for treatments',
                              hintStyle: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF006837),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.52),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Search',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * (31 / 896)),
                  Container(
                    height: screenHeight * (40 / 896),
                    width: screenWidth * (360 / 414),
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sort by:',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 39,
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(33),
                          ),
                          child: DropdownButton<String>(
                            value: selectedValue,
                            isExpanded: true,
                            hint: Text(
                              'Date',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            ),
                            items: options.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedValue = newValue!;
                              });
                            },
                            underline: Container(),
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Divider(height: 1, thickness: 1, color: Color(0xFFCCCCCC)),
                ],
              ),
            ),
            SizedBox(height: screenHeight * (14 / 896)),
            Expanded(
              child: Container(
                width: screenWidth * (350 / 414),
                color: Colors.transparent,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      width: screenWidth * (350 / 414),
                      height: screenHeight * (166 / 896),
                      decoration: BoxDecoration(
                        color: Color(0xFFF1F1F1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 23),
                            child: Container(
                              height: screenHeight * (29 / 896),
                              width: screenWidth * (146 / 414),
                              color: Colors.transparent,
                              child: Text(
                                '1.  Vikram Singh',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 3),
                          Padding(
                            padding: const EdgeInsets.only(left: 45),
                            child: Container(
                              height: screenHeight * (24 / 896),
                              width: screenWidth * (277 / 414),
                              color: Colors.transparent,
                              child: Text(
                                'Couple Combo Package (Rejuven...',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 3),
                          Padding(
                            padding: const EdgeInsets.only(left: 45),
                            child: Container(
                              height: screenHeight * (24 / 896),
                              width: screenWidth * (222 / 414),
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    size: 13,
                                    color: Color(0xFFF24E1E),
                                  ),
                                  Text('31/01/2024'),

                                  Icon(
                                    Icons.people,
                                    size: 13,
                                    color: Color(0xFFF24E1E),
                                  ),
                                  Text('jitheesh'),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Divider(
                            height: 1,
                            thickness: 1,
                            color: Color(0xFFCCCCCC),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 45, top: 9),
                            child: Container(
                              height: screenHeight * (23 / 896),
                              width: screenWidth * (277 / 414),
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'View Booking details',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 12,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    Container(
                      width: screenWidth * (350 / 414),
                      height: screenHeight * (166 / 896),
                      decoration: BoxDecoration(
                        color: Color(0xFFF1F1F1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 23),
                            child: Container(
                              height: screenHeight * (29 / 896),
                              width: screenWidth * (146 / 414),
                              color: Colors.transparent,
                              child: Text(
                                '2.  Vikram Singh',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 3),
                          Padding(
                            padding: const EdgeInsets.only(left: 45),
                            child: Container(
                              height: screenHeight * (24 / 896),
                              width: screenWidth * (277 / 414),
                              color: Colors.transparent,
                              child: Text(
                                'Couple Combo Package (Rejuven...',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 3),
                          Padding(
                            padding: const EdgeInsets.only(left: 45),
                            child: Container(
                              height: screenHeight * (24 / 896),
                              width: screenWidth * (222 / 414),
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    size: 13,
                                    color: Color(0xFFF24E1E),
                                  ),
                                  Text('31/01/2024'),

                                  Icon(
                                    Icons.people,
                                    size: 13,
                                    color: Color(0xFFF24E1E),
                                  ),
                                  Text('jitheesh'),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Divider(
                            height: 1,
                            thickness: 1,
                            color: Color(0xFFCCCCCC),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 45, top: 9),
                            child: Container(
                              height: screenHeight * (23 / 896),
                              width: screenWidth * (277 / 414),
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'View Booking details',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 12,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    Container(
                      width: screenWidth * (350 / 414),
                      height: screenHeight * (166 / 896),
                      decoration: BoxDecoration(
                        color: Color(0xFFF1F1F1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 23),
                            child: Container(
                              height: screenHeight * (29 / 896),
                              width: screenWidth * (146 / 414),
                              color: Colors.transparent,
                              child: Text(
                                '2.  Vikram Singh',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 3),
                          Padding(
                            padding: const EdgeInsets.only(left: 45),
                            child: Container(
                              height: screenHeight * (24 / 896),
                              width: screenWidth * (277 / 414),
                              color: Colors.transparent,
                              child: Text(
                                'Couple Combo Package (Rejuven...',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 3),
                          Padding(
                            padding: const EdgeInsets.only(left: 45),
                            child: Container(
                              height: screenHeight * (24 / 896),
                              width: screenWidth * (222 / 414),
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    size: 13,
                                    color: Color(0xFFF24E1E),
                                  ),
                                  Text('31/01/2024'),

                                  Icon(
                                    Icons.people,
                                    size: 13,
                                    color: Color(0xFFF24E1E),
                                  ),
                                  Text('jitheesh'),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Divider(
                            height: 1,
                            thickness: 1,
                            color: Color(0xFFCCCCCC),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 45, top: 9),
                            child: Container(
                              height: screenHeight * (23 / 896),
                              width: screenWidth * (277 / 414),
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'View Booking details',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 12,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    Container(
                      width: screenWidth * (350 / 414),
                      height: screenHeight * (166 / 896),
                      decoration: BoxDecoration(
                        color: Color(0xFFF1F1F1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 23),
                            child: Container(
                              height: screenHeight * (29 / 896),
                              width: screenWidth * (146 / 414),
                              color: Colors.transparent,
                              child: Text(
                                '2.  Vikram Singh',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 3),
                          Padding(
                            padding: const EdgeInsets.only(left: 45),
                            child: Container(
                              height: screenHeight * (24 / 896),
                              width: screenWidth * (277 / 414),
                              color: Colors.transparent,
                              child: Text(
                                'Couple Combo Package (Rejuven...',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 3),
                          Padding(
                            padding: const EdgeInsets.only(left: 45),
                            child: Container(
                              height: screenHeight * (24 / 896),
                              width: screenWidth * (222 / 414),
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    size: 13,
                                    color: Color(0xFFF24E1E),
                                  ),
                                  Text('31/01/2024'),

                                  Icon(
                                    Icons.people,
                                    size: 13,
                                    color: Color(0xFFF24E1E),
                                  ),
                                  Text('jitheesh'),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Divider(
                            height: 1,
                            thickness: 1,
                            color: Color(0xFFCCCCCC),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 45, top: 9),
                            child: Container(
                              height: screenHeight * (23 / 896),
                              width: screenWidth * (277 / 414),
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'View Booking details',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 12,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
