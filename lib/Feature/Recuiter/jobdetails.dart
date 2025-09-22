import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jobapp/core/typography.dart';

class JobdetailScreen extends StatefulWidget {
  const JobdetailScreen({super.key});

  @override
  State<JobdetailScreen> createState() => _JobdetailScreenState();
}

class _JobdetailScreenState extends State<JobdetailScreen> {
  int selectedIndex = 0; // 0: no selection, 1: Airline, 2: Hospitality

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('recuiterhome screen'),
        leading: Icon(Iconsax.menu, color: colorScheme.onPrimary),
        actions: [
          SizedBox(width: width * 0.01),
          Icon(Iconsax.notification, color: colorScheme.onPrimary),
          Icon(Iconsax.notification, color: colorScheme.onPrimary),
        ],
        backgroundColor: colorScheme.onSecondary,
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.022),
        child: Column(
          children: [
            Row(
              children: [
                // Airline button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = 1; // Set to 1 for Airline
                    });
                  },
                  child: choicecontainer(
                    height,
                    width,
                    'Airline',
                    colorScheme,
                    textTheme,
                    selectedIndex == 1,
                  ),
                ),
                // Hospitality button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = 2; // Set to 2 for Hospitality
                    });
                  },
                  child: choicecontainer(
                    height,
                    width,
                    'Hospitality',
                    colorScheme,
                    textTheme,
                    selectedIndex == 2,
                  ),
                ),
              ],
            ),
            // Display the selected container based on the selectedIndex
            selectedcontainer(height, width, selectedIndex, colorScheme),
          ],
        ),
      ),
    );
  }

  Widget selectedcontainer(
    double height,
    double width,
    int index,
    ColorScheme colorscheme,
  ) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: (index == 1)
              ? airlinecontainer(height, width, colorscheme)
              : (index == 2)
              ? _hospitality(height, width, colorscheme)
              : Container(), // Empty container when no selection
        ),
      ],
    );
  }

  Widget airlinecontainer(double height, double width, colorschem) {
    TextEditingController namecontroller = TextEditingController();
    TextEditingController designationcontroller = TextEditingController();
    TextEditingController ctccontroller = TextEditingController();
    TextEditingController noticePeriodcontroller = TextEditingController();
    TextEditingController locationcontroller = TextEditingController();
    TextEditingController applicationcontroller = TextEditingController();

    return Column(
      children: [
        textformfield(
          height,
          width,
          namecontroller,
          'full Name',
          icon: Icon(Iconsax.user),
        ),
        textformfield(
          height,
          width,
          designationcontroller,
          'Designation',
          icon: Icon(Iconsax.briefcase),
        ),
        textformfield(
          height,
          width,
          ctccontroller,
          'CTC',
          icon: Icon(Iconsax.wallet),
        ),
        textformfield(
          height,
          width,
          noticePeriodcontroller,
          'Notice Period',
          icon: Icon(Iconsax.calendar),
        ),
        textformfield(
          height,
          width,
          locationcontroller,
          'Location',
          icon: Icon(Iconsax.user),
        ),
        textformfield(
          height,
          width,
          applicationcontroller,
          'Application',
          icon: Icon(Iconsax.document_text),
        ),
        SizedBox(height: height * 0.04),
        _submitbutton(height, width, colorschem, textTheme),
      ],
    );
  }

  Widget textformfield(
    double height,
    double width,
    TextEditingController controller,
    String label, {
    Icon? icon,
    int? maxline,
    bool isRequired = false,
    bool isEmail = false,
    bool isPhone = false,
    bool isNumber = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.015,
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: isEmail
            ? TextInputType.emailAddress
            : isPhone || isNumber
            ? TextInputType.phone
            : TextInputType.text,
        maxLines: maxline ?? 1,
        decoration: InputDecoration(
          labelText: label + (isRequired ? ' *' : ''),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          prefixIcon: icon,
          filled: true,
          fillColor: Color.fromRGBO(223, 226, 230, 1),
        ),
      ),
    );
  }

  Widget _submitbutton(
    double height,
    double width,
    ColorScheme colorscheme,
    texttheme,
  ) {
    return SizedBox(
      width: width - 200,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {},
        child: Text(
          'Submit',
          style: texttheme.labelMedium?.copyWith(
            color: colorscheme.onSecondary,
          ),
        ),
      ),
    );
  }

  Widget choicecontainer(
    double height,
    double width,
    String text,
    ColorScheme colorScheme,
    TextTheme textTheme,
    bool isSelected,
  ) {
    return Padding(
      padding: EdgeInsets.all(width * 0.02),
      child: Container(
        height: height * 0.05,
        width: width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? colorScheme.primaryFixed : colorScheme.onPrimary,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(2, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: textTheme.headlineSmall?.copyWith(
              color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }

  Widget _hospitality(double height, double width, colorschem) {
    TextEditingController hospitalitynamecontroller = TextEditingController();
    TextEditingController hospitalitydesignationcontroller =
        TextEditingController();
    TextEditingController hospitalityctccontroller = TextEditingController();
    TextEditingController hospitalitynoticePeriodcontroller =
        TextEditingController();
    TextEditingController hospitalitylocationcontroller =
        TextEditingController();
    TextEditingController hospitalityapplicationcontroller =
        TextEditingController();

    return Column(
      children: [
        textformfield(
          height,
          width,
          hospitalitynamecontroller,
          ' Full Name',
          icon: Icon(Iconsax.user),
        ),
        textformfield(
          height,
          width,
          hospitalitydesignationcontroller,
          'Designation',
          icon: Icon(Iconsax.briefcase),
        ),
        textformfield(
          height,
          width,
          hospitalityctccontroller,
          'CTC',
          icon: Icon(Iconsax.wallet),
        ),
        textformfield(
          height,
          width,
          hospitalitynoticePeriodcontroller,
          'Notice Period',
          icon: Icon(Iconsax.calendar),
        ),
        textformfield(
          height,
          width,
          hospitalitylocationcontroller,
          'Location',
          icon: Icon(Iconsax.user),
        ),
        textformfield(
          height,
          width,
          hospitalityapplicationcontroller,
          'Application',
          icon: Icon(Iconsax.document_text),
        ),
        SizedBox(height: height * 0.04),
        _submitbutton(height, width, colorschem, textTheme),
      ],
    );
  }
}
