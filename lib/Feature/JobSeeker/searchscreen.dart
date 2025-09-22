import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

// ignore: camel_case_types
class searchscreen extends StatefulWidget {
  const searchscreen({super.key});

  @override
  State<searchscreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<searchscreen> {
  TextEditingController searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 40,left:20,right: 20),
        child: Column(
          children: [
            SizedBox(height: 50,),
            TextField(
              decoration: InputDecoration(
                hintText: 'search a job ..',
                hintStyle: textTheme.bodySmall?.copyWith(
                  color: colorScheme.secondary,
                ),
                prefixIcon: Icon(Iconsax.search_normal),
                labelText: 'search',
                labelStyle: textTheme.bodySmall?.copyWith(
                  color: colorScheme.secondary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: colorScheme.surface,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: colorScheme.secondary),
                ),
                // Border when focused
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: colorScheme.onSecondary,
                    width: 2.0,
                  ),
                ),
                // Border when there's an error
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.red),
                ), // Removes border when focused
                contentPadding: EdgeInsets
                    .zero, // Removes padding to eliminate any visual gaps
              ),
            ),
            SizedBox(height: 20,),
            Lottie.asset('asset/icons/Loading animation blue.json'),
          ],
        ),
      ),
    );
  }
}
