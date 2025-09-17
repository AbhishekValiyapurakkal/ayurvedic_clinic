import 'package:ayurvedic_clinic_app/data/models/branch_model.dart';
import 'package:ayurvedic_clinic_app/data/models/register_patients_model.dart';
import 'package:ayurvedic_clinic_app/data/models/treatment_model.dart';
import 'package:ayurvedic_clinic_app/presentation/providers/branch_provider.dart';
import 'package:ayurvedic_clinic_app/presentation/providers/registerPatients_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ayurvedic_clinic_app/presentation/providers/patients_provider.dart';

class RegisterSceen extends StatefulWidget {
  const RegisterSceen({super.key});

  @override
  State<RegisterSceen> createState() => _RegisterSceenState();
}

class _RegisterSceenState extends State<RegisterSceen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _whatsappnumber = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _totalamount = TextEditingController();
  final TextEditingController _discountamount = TextEditingController();
  final TextEditingController _advanceamount = TextEditingController();
  final TextEditingController _balanceamount = TextEditingController();
  final TextEditingController _treatmentdate = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RegisterPatientProvider>().fetchTreatments();
      context.read<BranchProvider>().fetchBranches();
    });
  }

  String? selectedPaymentOption;

  String? selectedHour;
  String? selectedMinute;

  final List<String> hours = List.generate(
    12,
    (index) => (index + 1).toString(),
  );
  final List<String> minutes = List.generate(
    59,
    (index) => (index + 1).toString(),
  );

  String? selectedlocation;
  Branch? selectedBranch;

  String? selectedTreatmentValue;
  String? selectedTreatmentId;
  int selectedMaleCount = 0;
  int selectedFemaleCount = 0;

  final List<String> location = ["banglore", "kochi", "chennai", "malappuram"];
  final List<String> branch = ["banglore", "kochi", "chennai", "malappuram"];

  void _showTreatmentDialog() async {
    final registerProvider = context.read<RegisterPatientProvider>();

    // Show loading dialog first
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    // Fetch treatments
    await registerProvider.fetchTreatments();

    // Close the loading dialog
    Navigator.of(context).pop();

    // Now show the actual treatment dialog
    final Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    Treatment? selectedTreatment;

    int maleCounter = 0;
    int femaleCounter = 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                'Choose Treatment',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              content: registerProvider.treatmentError != null
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Error: ${registerProvider.treatmentError}',
                          style: TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () async {
                            // Show loading
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) =>
                                  Center(child: CircularProgressIndicator()),
                            );
                            await registerProvider.fetchTreatments();
                            Navigator.of(context).pop();
                          },
                          child: Text('Retry'),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 50,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromARGB(64, 28, 26, 26),
                            ),
                            borderRadius: BorderRadius.circular(8.53),
                          ),
                          child: DropdownButton<Treatment>(
                            value: selectedTreatment,
                            isExpanded: true,
                            hint: Text(
                              'Choose treatment',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                            items: registerProvider.treatments.map((
                              Treatment treatment,
                            ) {
                              return DropdownMenuItem<Treatment>(
                                value: treatment,
                                child: Text(
                                  '${treatment.name} - ₹${treatment.price}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (Treatment? newValue) {
                              setState(() {
                                selectedTreatment = newValue;
                              });
                            },
                            underline: Container(),
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Add patient',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 20),

                        Row(
                          children: [
                            Container(
                              height: screenHeight * (50 / 896),
                              width: screenWidth * (124 / 414),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(
                                    255,
                                    61,
                                    60,
                                    60,
                                  ).withOpacity(0.25),
                                ),
                                borderRadius: BorderRadius.circular(8.53),
                              ),
                              child: Center(
                                child: Text(
                                  'Male',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0x40D9D9D9)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (maleCounter > 0) {
                                          maleCounter--;
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      Icons.remove_circle,
                                      color: Colors.green,
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: 40,
                                      minHeight: 40,
                                    ),
                                  ),
                                  Container(
                                    height: screenHeight * (44 / 896),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color.fromARGB(64, 28, 26, 26),
                                      ),
                                      borderRadius: BorderRadius.circular(8.53),
                                    ),
                                    child: Center(
                                      child: Text(
                                        maleCounter.toString(),
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        maleCounter++;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.add_circle_rounded,
                                      color: Colors.green,
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: 40,
                                      minHeight: 40,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Container(
                              height: screenHeight * (50 / 896),
                              width: screenWidth * (124 / 414),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(
                                    255,
                                    61,
                                    60,
                                    60,
                                  ).withOpacity(0.25),
                                ),
                                borderRadius: BorderRadius.circular(8.53),
                              ),
                              child: Center(
                                child: Text(
                                  'Female',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0x40D9D9D9)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (femaleCounter > 0) {
                                          femaleCounter--;
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      Icons.remove_circle,
                                      color: Colors.green,
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: 40,
                                      minHeight: 40,
                                    ),
                                  ),
                                  Container(
                                    height: screenHeight * (44 / 896),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color.fromARGB(64, 28, 26, 26),
                                      ),
                                      borderRadius: BorderRadius.circular(8.53),
                                    ),
                                    child: Center(
                                      child: Text(
                                        femaleCounter.toString(),
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        femaleCounter++;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.add_circle_rounded,
                                      color: Colors.green,
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: 40,
                                      minHeight: 40,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
              actions: [
                if (registerProvider.treatmentError == null)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF389A48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop({
                        "treatment": selectedTreatment?.name,
                        "treatment_id": selectedTreatment?.id.toString(),
                        "male": maleCounter,
                        "female": femaleCounter,
                      });
                    },
                    child: Text(
                      'Save',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      },
    ).then((result) {
      if (result != null) {
        setState(() {
          selectedTreatmentValue = result["treatment"];
          selectedTreatmentId = result["treatment_id"];
          selectedMaleCount = result["male"];
          selectedFemaleCount = result["female"];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_rounded),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none)),
          ],
        ),
        body: Column(
          children: [
            Container(
              height: screenHeight * (55 / 896),
              width: screenWidth,
              color: Colors.transparent,
              child: Column(
                children: [
                  Container(
                    height: screenHeight * (40 / 896),
                    width: screenWidth * (360 / 414),
                    color: Colors.transparent,
                    child: Text(
                      'Register',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Spacer(),
                  Divider(height: 1, thickness: 1, color: Color(0xFFCCCCCC)),
                ],
              ),
            ),
            SizedBox(height: screenHeight * (14 / 896)),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: (screenWidth - (screenWidth * (350 / 414))) / 2,
                ).add(EdgeInsets.only(bottom: 24)),
                child: Container(
                  width: screenWidth * (350 / 414),
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 6),
                      SizedBox(
                        height: screenHeight * (50 / 896),
                        child: TextField(
                          controller: _name,
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
                            hintText: 'Enter Your Name',
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
                      SizedBox(height: 20),
                      Text(
                        'Whatsapp Number',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 6),
                      SizedBox(
                        height: screenHeight * (50 / 896),
                        child: TextField(
                          controller: _whatsappnumber,
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
                            hintText: 'Enter Your Whatsapp number',
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
                      SizedBox(height: 20),
                      Text(
                        'Address',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 6),
                      SizedBox(
                        height: screenHeight * (50 / 896),
                        child: TextField(
                          controller: _address,
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
                            hintText: 'Enter Your Address',
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
                      SizedBox(height: 20),
                      Text(
                        'Location',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 6),
                      Container(
                        width: screenWidth * (350 / 414),
                        height: screenHeight * (50 / 896),
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0x40D9D9D9)),
                          borderRadius: BorderRadius.circular(8.53),
                        ),
                        child: DropdownButton<String>(
                          value: selectedlocation,
                          isExpanded: true,
                          hint: Text(
                            'Choose your location',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                          items: location.map((String value) {
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
                              selectedlocation = newValue;
                            });
                          },
                          underline: Container(),
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Branch',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      Consumer<BranchProvider>(
                        builder: (context, branchProvider, child) {
                          if (branchProvider.isLoading) {
                            return Container(
                              width: screenWidth * (350 / 414),
                              height: screenHeight * (50 / 896),
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0x40D9D9D9)),
                                borderRadius: BorderRadius.circular(8.53),
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              ),
                            );
                          } else if (branchProvider.error != null) {
                            return Container(
                              width: screenWidth * (350 / 414),
                              height: screenHeight * (50 / 896),
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.red.withOpacity(0.5),
                                ),
                                borderRadius: BorderRadius.circular(8.53),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Error loading branches',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.refresh, size: 20),
                                    onPressed: () =>
                                        branchProvider.fetchBranches(),
                                  ),
                                ],
                              ),
                            );
                          } else if (branchProvider.branches.isEmpty) {
                            return Container(
                              width: screenWidth * (350 / 414),
                              height: screenHeight * (50 / 896),
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0x40D9D9D9)),
                                borderRadius: BorderRadius.circular(8.53),
                              ),
                              child: Center(
                                child: Text(
                                  'No branches available',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              width: screenWidth * (350 / 414),
                              height: screenHeight * (50 / 896),
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0x40D9D9D9)),
                                borderRadius: BorderRadius.circular(8.53),
                              ),
                              child: DropdownButton<Branch>(
                                value: selectedBranch,
                                isExpanded: true,
                                hint: Text(
                                  'Choose your branch',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                ),
                                items: branchProvider.branches.map((branch) {
                                  return DropdownMenuItem<Branch>(
                                    value: branch,
                                    child: Text(
                                      branch.name,
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );

                                  
                                }).toList(),
                                onChanged: (Branch? newBranch) {
                                  setState(() {
                                    selectedBranch = newBranch;
                                  });
                                },
                                underline: Container(),
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          }
                        },
                      ),

                      SizedBox(height: 20),
                      Text(
                        'Treatments',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 6),

                      Container(
                        width: screenWidth * (350 / 414),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFFD9D9D9).withOpacity(0.25),
                          ),
                          borderRadius: BorderRadius.circular(8.53),
                        ),
                        child: selectedTreatmentValue == null
                            ? Text(
                                "No treatment selected",
                                style: GoogleFonts.poppins(fontSize: 14),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Treatment: $selectedTreatmentValue",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Text(
                                        "Male ",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: Colors.green,
                                        ),
                                      ),
                                      Container(
                                        height: screenHeight * (44 / 896),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color.fromARGB(
                                              64,
                                              28,
                                              26,
                                              26,
                                            ),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8.53,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "$selectedMaleCount",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 35),
                                      Text(
                                        "Female ",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: Colors.green,
                                        ),
                                      ),
                                      Container(
                                        height: screenHeight * (44 / 896),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color.fromARGB(
                                              64,
                                              28,
                                              26,
                                              26,
                                            ),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8.53,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "$selectedFemaleCount",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                ],
                              ),
                      ),

                      SizedBox(height: 8),
                      Consumer<RegisterPatientProvider>(
                        builder: (context, registerProvider, child) {
                          return SizedBox(
                            width: screenWidth * (350 / 414),
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0x4D389A48),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.52),
                                ),
                              ),
                              onPressed: () {
                                _showTreatmentDialog();
                              },
                              child: Text(
                                '+ Add Treatments',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Total Amount',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 6),
                      SizedBox(
                        height: screenHeight * (50 / 896),
                        child: TextField(
                          controller: _totalamount,
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
                            fillColor: Color(0xFFD9D9D9).withOpacity(0.25),
                            filled: true,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Discount Amount',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 6),
                      SizedBox(
                        height: screenHeight * (50 / 896),
                        child: TextField(
                          controller: _discountamount,
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
                            fillColor: Color(0xFFD9D9D9).withOpacity(0.25),
                            filled: true,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Payment Options',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Radio<String>(
                                value: "Cash",
                                groupValue: selectedPaymentOption,
                                onChanged: (value) {
                                  setState(() {
                                    selectedPaymentOption = value;
                                  });
                                },
                                activeColor: Color(0xFF389A48),
                              ),
                              Text(
                                "Cash",
                                style: GoogleFonts.poppins(fontSize: 16),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio<String>(
                                value: "Card",
                                groupValue: selectedPaymentOption,
                                onChanged: (value) {
                                  setState(() {
                                    selectedPaymentOption = value;
                                  });
                                },
                                activeColor: Color(0xFF389A48),
                              ),
                              Text(
                                "Card",
                                style: GoogleFonts.poppins(fontSize: 16),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio<String>(
                                value: "UPI",
                                groupValue: selectedPaymentOption,
                                onChanged: (value) {
                                  setState(() {
                                    selectedPaymentOption = value;
                                  });
                                },
                                activeColor: Color(0xFF389A48),
                              ),
                              Text(
                                "UPI",
                                style: GoogleFonts.poppins(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Advance Amount',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 6),
                      SizedBox(
                        height: screenHeight * (50 / 896),
                        child: TextField(
                          controller: _advanceamount,
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
                            fillColor: Color(0xFFD9D9D9).withOpacity(0.25),
                            filled: true,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Balance Amount',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 6),
                      SizedBox(
                        height: screenHeight * (50 / 896),
                        child: TextField(
                          controller: _balanceamount,
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
                            fillColor: Color(0xFFD9D9D9).withOpacity(0.25),
                            filled: true,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Treatment Date',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 6),
                      SizedBox(
                        height: screenHeight * (50 / 896),
                        child: TextField(
                          controller: _treatmentdate,
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
                            fillColor: Color(0xFFD9D9D9).withOpacity(0.25),
                            filled: true,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Treatment Time',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 6),

                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: screenHeight * (50 / 896),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0x40D9D9D9)),
                                borderRadius: BorderRadius.circular(8.53),
                              ),
                              child: DropdownButton<String>(
                                value: selectedHour,
                                isExpanded: true,
                                hint: Text(
                                  'Hour',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                ),
                                items: hours.map((String value) {
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
                                    selectedHour = newValue;
                                  });
                                },
                                underline: Container(),
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Container(
                              height: screenHeight * (50 / 896),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0x40D9D9D9)),
                                borderRadius: BorderRadius.circular(8.53),
                              ),
                              child: DropdownButton<String>(
                                value: selectedMinute,
                                isExpanded: true,
                                hint: Text(
                                  'Minute',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                ),
                                items: minutes.map((String value) {
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
                                    selectedMinute = newValue;
                                  });
                                },
                                underline: Container(),
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Center(
                          child: SizedBox(
                            width: screenWidth * (350 / 414),
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF006837),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.52),
                                ),
                              ),
                              onPressed: () async {
                                final provider = context
                                    .read<RegisterPatientProvider>();

                                final request = RegisterPatientRequest(
                                  name: _name.text.trim(),
                                  excecutive: "",
                                  payment: selectedPaymentOption ?? "Cash",
                                  phone: _whatsappnumber.text.trim(),
                                  address: _address.text.trim(),
                                  totalAmount:
                                      double.tryParse(_totalamount.text) ?? 0,
                                  discountAmount:
                                      double.tryParse(_discountamount.text) ??
                                      0,
                                  advanceAmount:
                                      double.tryParse(_advanceamount.text) ?? 0,
                                  balanceAmount:
                                      double.tryParse(_balanceamount.text) ?? 0,
                                  dateAndTime: DateTime.now().toIso8601String(),
                                  id: "",
                                  male: selectedMaleCount.toString(),
                                  female: selectedFemaleCount.toString(),
                                  branch: selectedBranch?.name ?? "",
                                  treatments: selectedTreatmentId ?? "",
                                );

                                await provider.registerPatient(request);

                                if (provider.success) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Patient registered successfully!",
                                      ),
                                    ),
                                  );
                                  Navigator.pop(context);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        provider.errorMessage ??
                                            "Something went wrong",
                                      ),
                                    ),
                                  );
                                }
                              },

                              child: Text(
                                'Save',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
