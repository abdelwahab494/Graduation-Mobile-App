import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/auth/auth_service.dart';
import 'package:grad_project/components/custom_medicine_row.dart';
import 'package:grad_project/components/new_medicine_botton.dart';
import 'package:grad_project/core/colors.dart';
import 'package:grad_project/components/custom_botton.dart';
import 'package:grad_project/components/customtextfield.dart';
import 'package:grad_project/database/medicine/medicine.dart';
import 'package:grad_project/database/medicine/medicine_database.dart';
import 'package:grad_project/noti_service.dart';
import 'package:grad_project/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddMedicine extends StatefulWidget {
  const AddMedicine({super.key, required this.onNavigate});
  final Function(int) onNavigate;

  @override
  State<AddMedicine> createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  ScrollController scrollController = ScrollController();
  TextEditingController nameController = TextEditingController();
  TextEditingController dosageController = TextEditingController();
  final bool isPartner = AuthService().getCurrentItemBool("isPartner");
  int? selectedFrequency;
  List<TimeOfDay> doseTimes = [];
  DateTime? startDate;
  DateTime? endDate;
  String? mealTiming;
  Medicine? editingMedicine;
  final _streamKey = GlobalKey();
  String error = "";

  @override
  void dispose() {
    _streamKey.currentState?.dispose();
    scrollController.dispose();
    nameController.dispose();
    dosageController.dispose();
    super.dispose();
  }

  String formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return TimeOfDay.fromDateTime(dt).format(context);
  }

  TimeOfDay parseTimeOfDay(String time) {
    final parts = time.split(' ');
    final timeParts = parts[0].split(':');
    int hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);
    if (parts[1].toLowerCase() == 'pm' && hour != 12) {
      hour += 12;
    } else if (parts[1].toLowerCase() == 'am' && hour == 12) {
      hour = 0;
    }
    return TimeOfDay(hour: hour, minute: minute);
  }

  void _showBottomSheet({Medicine? medicineToEdit}) {
    if (medicineToEdit != null) {
      setState(() {
        editingMedicine = medicineToEdit;
        nameController.text = medicineToEdit.name;
        dosageController.text = medicineToEdit.dosage;
        selectedFrequency = medicineToEdit.frequency;
        doseTimes = medicineToEdit.doseTimes.map(parseTimeOfDay).toList();
        startDate = medicineToEdit.startDate;
        endDate = medicineToEdit.endDate;
        mealTiming = medicineToEdit.mealTiming;
      });
    } else {
      setState(() {
        editingMedicine = null;
        nameController.clear();
        dosageController.clear();
        selectedFrequency = null;
        doseTimes.clear();
        startDate = null;
        endDate = null;
        mealTiming = null;
      });
    }

    showModalBottomSheet(
      // isDismissible: false,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (c) {
        bool isLight = Provider.of<ChangeThemeProvider>(context).isLight;

        return StatefulBuilder(
          builder: (context, setModalState) {
            return DraggableScrollableSheet(
              initialChildSize: 0.73,
              minChildSize: 0.73,
              maxChildSize: 0.9,
              expand: false,
              builder: (
                BuildContext context,
                ScrollController scrollController,
              ) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.backGround,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                  child: ListView(
                    controller: scrollController,
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Color(0xffD9D9D9),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      Text(
                        editingMedicine != null
                            ? "Edit Medicine"
                            : "Add Medicine",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Gap(10),
                      Customtextfield2(
                        controller: nameController,
                        label: "Medicine Name",
                      ),
                      Gap(12),
                      Customtextfield2(
                        controller: dosageController,
                        label: "Dosage",
                      ),
                      Gap(12),
                      DropdownButtonFormField<int>(
                        dropdownColor: AppColors.backGround,
                        decoration: InputDecoration(
                          label: Text("Frequency per day"),
                          labelStyle: TextStyle(
                            color:
                                isLight
                                    ? Color.fromARGB(255, 73, 73, 73)
                                    : Color(0xffF2F2F2),
                            fontSize: 14,
                          ),
                          filled: true,
                          fillColor:
                              isLight
                                  ? Color(0xffF2F2F2)
                                  : Color.fromARGB(255, 73, 73, 73),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primary,
                              width: 2.0,
                            ),
                          ),
                        ),
                        value: selectedFrequency,
                        items:
                            List.generate(5, (index) => index + 1)
                                .map(
                                  (value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(
                                      '$value time${value > 1 ? 's' : ''}',
                                      style: TextStyle(
                                        color:
                                            isLight
                                                ? Colors.grey[800]
                                                : Colors.grey[500],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          setModalState(() {
                            selectedFrequency = value;
                          });
                        },
                      ),
                      Gap(10),
                      Text(
                        "Meal Timing",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: isLight ? Colors.grey[800] : Colors.grey[500],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<String>(
                              title: Text(
                                "Before Meal",
                                style: TextStyle(
                                  fontSize: 14,
                                  color:
                                      isLight
                                          ? Colors.grey[800]
                                          : Colors.grey[500],
                                ),
                              ),
                              value: "Before Meal",
                              groupValue: mealTiming,
                              onChanged: (value) {
                                setModalState(() {
                                  mealTiming = value;
                                });
                              },
                              activeColor: AppColors.primary,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<String>(
                              title: Text(
                                "After Meal",
                                style: TextStyle(
                                  fontSize: 14,
                                  color:
                                      isLight
                                          ? Colors.grey[800]
                                          : Colors.grey[500],
                                ),
                              ),
                              value: "After Meal",
                              groupValue: mealTiming,
                              onChanged: (value) {
                                setModalState(() {
                                  mealTiming = value;
                                });
                              },
                              activeColor: AppColors.primary,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Dose Times",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: isLight ? Colors.grey[800] : Colors.grey[500],
                          fontSize: 14,
                        ),
                      ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children:
                            doseTimes
                                .map(
                                  (time) => Chip(
                                    label: Text(
                                      formatTime(time),
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 12,
                                      ),
                                    ),
                                    backgroundColor: Color.fromARGB(
                                      255,
                                      215,
                                      228,
                                      251,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: AppColors.primary,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 6,
                                    ),
                                    elevation: 1,
                                  ),
                                )
                                .toList(),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: TextButton.icon(
                          onPressed: () async {
                            if ((selectedFrequency ?? 0) > doseTimes.length) {
                              final TimeOfDay? picked = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (picked != null) {
                                setModalState(() {
                                  doseTimes.add(picked);
                                });
                              }
                            } else {
                              null;
                            }
                          },
                          icon: Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color:
                                  (selectedFrequency ?? 0) > doseTimes.length
                                      ? Color(0xffe6eefb)
                                      : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(500),
                            ),
                            child: Icon(Icons.access_time, size: 18),
                          ),
                          label: Text("Add Dose Time"),
                          style: TextButton.styleFrom(
                            foregroundColor:
                                (selectedFrequency ?? 0) > doseTimes.length
                                    ? AppColors.primary
                                    : Colors.grey.shade400,
                            textStyle: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Start Date",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color:
                                      isLight
                                          ? Colors.grey[800]
                                          : Colors.grey[500],
                                  fontSize: 14,
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child:
                                    startDate != null
                                        ? TextButton(
                                          onPressed: () async {
                                            final DateTime? picked =
                                                await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2024),
                                                  lastDate: DateTime(2030),
                                                );
                                            if (picked != null) {
                                              setModalState(() {
                                                startDate = picked;
                                              });
                                            }
                                          },
                                          child: Text(
                                            "${startDate!.day}/${startDate!.month}/${startDate!.year}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.primary,
                                              fontSize: 20,
                                            ),
                                          ),
                                        )
                                        : TextButton.icon(
                                          onPressed: () async {
                                            final DateTime? picked =
                                                await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2024),
                                                  lastDate: DateTime(2030),
                                                );
                                            if (picked != null) {
                                              setModalState(() {
                                                startDate = picked;
                                              });
                                            }
                                          },
                                          icon: Container(
                                            padding: EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                              color: Color(0xffe6eefb),
                                              borderRadius:
                                                  BorderRadius.circular(500),
                                            ),
                                            child: Icon(
                                              Icons.edit_calendar_rounded,
                                              size: 18,
                                            ),
                                          ),
                                          label: Text("Select Start Date"),
                                          style: TextButton.styleFrom(
                                            foregroundColor: AppColors.primary,
                                            textStyle: TextStyle(fontSize: 14),
                                          ),
                                        ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "End Date",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color:
                                      isLight
                                          ? Colors.grey[800]
                                          : Colors.grey[500],
                                  fontSize: 14,
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child:
                                    endDate != null
                                        ? TextButton(
                                          onPressed: () async {
                                            final DateTime? picked =
                                                await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2024),
                                                  lastDate: DateTime(2030),
                                                );
                                            if (picked != null) {
                                              setModalState(() {
                                                endDate = picked;
                                              });
                                            }
                                          },
                                          child: Text(
                                            "${endDate!.day}/${endDate!.month}/${endDate!.year}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.primary,
                                              fontSize: 20,
                                            ),
                                          ),
                                        )
                                        : TextButton.icon(
                                          onPressed: () async {
                                            final DateTime? picked =
                                                await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2024),
                                                  lastDate: DateTime(2030),
                                                );
                                            if (picked != null) {
                                              setModalState(() {
                                                endDate = picked;
                                              });
                                            }
                                          },
                                          icon: Container(
                                            padding: EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                              color: Color(0xffe6eefb),
                                              borderRadius:
                                                  BorderRadius.circular(500),
                                            ),
                                            child: Icon(
                                              Icons.edit_calendar_rounded,
                                              size: 18,
                                            ),
                                          ),
                                          label: Text("Select End Date"),
                                          style: TextButton.styleFrom(
                                            foregroundColor: AppColors.primary,
                                            textStyle: TextStyle(fontSize: 14),
                                          ),
                                        ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Gap(10),
                      CustomBotton(
                        text:
                            editingMedicine != null
                                ? "Update Medicine"
                                : "Add Medicine",
                        onTap: () async {
                          // Validation for required fields
                          if (nameController.text.isEmpty ||
                              dosageController.text.isEmpty ||
                              selectedFrequency == null ||
                              doseTimes.isEmpty ||
                              startDate == null ||
                              endDate == null ||
                              mealTiming == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Please fill in all required fields!',
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          // Proceed if all fields are filled
                          final userId =
                              Supabase.instance.client.auth.currentUser?.id;
                          if (userId == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Please log in to add a medicine',
                                ),
                              ),
                            );
                            return;
                          }
                          final doseTimesStr =
                              doseTimes
                                  .map((time) => formatTime(time))
                                  .toList();
                          final medicine = Medicine(
                            id: editingMedicine?.id,
                            userId: userId,
                            name: nameController.text,
                            dosage: dosageController.text,
                            frequency: selectedFrequency,
                            doseTimes: doseTimesStr,
                            startDate: startDate,
                            endDate: endDate,
                            mealTiming: mealTiming,
                          );
                          final db = MedicineDatabase();
                          if (editingMedicine != null) {
                            await db.updateMedicine(editingMedicine!, medicine);
                            // Provider.of<NotificationProvider>(
                            //   context,
                            //   listen: false,
                            // ).scheduleDailyMedicineNotifications(medicine);
                          } else {
                            await db.createMedicine(medicine);
                          }
                          // Clear fields and pop the modal
                          setState(() {
                            editingMedicine = null;
                            nameController.clear();
                            dosageController.clear();
                            selectedFrequency = null;
                            doseTimes.clear();
                            startDate = null;
                            endDate = null;
                            mealTiming = null;
                          });
                          await ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                editingMedicine != null
                                    ? 'Medicine Added Successfully.'
                                    : "Medicine Updated Successfully.",
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.pop(context);
                          widget.onNavigate(2);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final db = MedicineDatabase();
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backGround,
        elevation: 0,
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        title: Text(
          !isPartner ? "Medicine Tracker" : "Your Patient Medicine Tracker",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.text,
          ),
        ),
      ),
      body: StreamBuilder<List<Medicine>>(
        key: _streamKey,
        stream: db.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              backgroundColor: AppColors.backGround,
              body: Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            );
          }
          if (snapshot.hasError) {
            return Scaffold(
              backgroundColor: AppColors.backGround,
              body: Center(
                child: Text(
                  'Error: Something went wrong!\n please check your connection.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Scaffold(
              backgroundColor: AppColors.backGround,
              body: Center(
                child: Text(
                  !isPartner
                      ? "No added medicine yet.\nAdd a new medicine!"
                      : 'Your patient has no medicine yet. \nAdd a new medicine!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                ),
              ),
            );
          }
          final medicines = snapshot.data!;
          for (var medicine in medicines) {
            NotiService().scheduleNotification(medicine);
          }
          return Scaffold(
            backgroundColor: AppColors.backGround,
            body: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              itemCount: medicines.length,
              itemBuilder: (context, index) {
                final medicine = medicines[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              medicine.name.toUpperCase(),
                              style: GoogleFonts.poppins(
                                fontSize: 25,
                                letterSpacing: 3,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.mode_edit_outline_outlined,
                                    color: Colors.blue,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    _showBottomSheet(medicineToEdit: medicine);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    CupertinoIcons.delete_simple,
                                    color: Colors.red,
                                    size: 18,
                                  ),
                                  onPressed: () async {
                                    final db = MedicineDatabase();
                                    await NotiService()
                                        .cancelMedicineNotifications(medicine);
                                    await db.deleteMedicine(medicine);
                                    await ScaffoldMessenger.of(
                                      context,
                                    ).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Medicine deleted successfully',
                                        ),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                    widget.onNavigate(2);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        Gap(10),
                        CustomMedicineRow(
                          icon: "assets/icons/Pharmacy.svg",
                          title: 'Dosage:',
                          data: '${medicine.dosage}',
                          type: 'SVG',
                        ),
                        Gap(10),
                        if (medicine.frequency != null)
                          CustomMedicineRow(
                            icon: "assets/icons/meal.png",
                            title: 'Meal Timing:',
                            data: '${medicine.mealTiming}',
                            type: 'PNG',
                          ),
                        Gap(10),
                        if (medicine.frequency != null)
                          CustomMedicineRow(
                            icon: "assets/icons/swap.png",
                            title: 'Frequancy:',
                            data:
                                '${medicine.frequency} time${medicine.frequency! > 1 ? 's' : ''} per day',
                            type: "PNG",
                          ),
                        Gap(10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      color: AppColors.primary,
                                      size: 20,
                                    ),
                                    Gap(10),
                                    Text(
                                      'Dose Times:',
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                                Gap(5),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: SizedBox(
                                    width: width - 100,
                                    child: Wrap(
                                      spacing: 8,
                                      runSpacing: 2,
                                      children:
                                          medicine.doseTimes
                                              .map(
                                                (time) => Chip(
                                                  label: Text(
                                                    time,
                                                    style: TextStyle(
                                                      color: AppColors.primary,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                        255,
                                                        215,
                                                        228,
                                                        251,
                                                      ),
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      color: AppColors.primary,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          16,
                                                        ),
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 5,
                                                    vertical: 4,
                                                  ),
                                                  elevation: 1,
                                                ),
                                              )
                                              .toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Gap(10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.calendar_month,
                              color: AppColors.primary,
                              size: 20,
                            ),
                            Gap(10),
                            Text(
                              "Period:",
                              style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                            Gap(5),
                            Text(
                              "${_formatDate(medicine.startDate!)} to ${medicine.endDate != null ? _formatDate(medicine.endDate!) : "Ongoing"}",
                              style: GoogleFonts.poppins(
                                color: AppColors.text,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 5),
        child: NewMedicineBotton(showBottomSheet: _showBottomSheet),
      ),
      backgroundColor: AppColors.backGround,
    );
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }
}
