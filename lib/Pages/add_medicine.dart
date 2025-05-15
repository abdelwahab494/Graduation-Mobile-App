import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:grad_project/Tools/colors.dart';
import 'package:grad_project/Tools/functions.dart';

class AddMedicine extends StatefulWidget {
  const AddMedicine({super.key});

  @override
  State<AddMedicine> createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  ScrollController scrollController = ScrollController();
  TextEditingController nameController = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showBottomSheet();
    });
    super.initState();
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // barrierColor: Colors.transparent,
      builder: (c) {
        return DraggableScrollableSheet(
          initialChildSize: 0.16,
          minChildSize: 0.16,
          shouldCloseOnMinExtent: false,
          maxChildSize: 0.85,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              width: double.infinity,
              height: 138,
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 11),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: ListView(
                controller: scrollController,
                children: [
                  Center(
                    child: Container(
                      width: 42,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Color(0xffD9D9D9),
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                    ),
                  ),
                  Gap(10),
                  Text(
                    "Add Medicine",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(10),
                  TextField(controller: nameController),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Medicine Tracking"),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        onPressed: () {},
        child: Icon(Icons.add_alarm_outlined),
      ),
    );
  }
}
