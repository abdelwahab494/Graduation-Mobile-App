import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:grad_project/Tools/colors.dart';
import 'package:grad_project/Tools/customtextfield.dart';
import 'package:grad_project/Tools/functions.dart';
import 'package:grad_project/Database/medicine.dart';
import 'package:grad_project/Database/medicine_database.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddMedicine extends StatefulWidget {
  const AddMedicine({super.key});

  @override
  State<AddMedicine> createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  ScrollController scrollController = ScrollController();
  TextEditingController nameController = TextEditingController();
  TextEditingController dosageController = TextEditingController();
  int? selectedFrequency;
  List<TimeOfDay> doseTimes = [];
  DateTime? startDate;
  DateTime? endDate;
  String? mealTiming;
  Medicine? editingMedicine;
  final _streamKey = GlobalKey();

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
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    boxShadow: [
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
                        dropdownColor: Colors.white,
                        decoration: InputDecoration(
                          label: Text("Frequency per day"),
                          labelStyle: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
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
                            List.generate(6, (index) => index + 1)
                                .map(
                                  (value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(
                                      '$value time${value > 1 ? 's' : ''}',
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
                          color: Colors.grey[800],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<String>(
                              title: const Text(
                                "Before Meal",
                                style: TextStyle(fontSize: 14),
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
                              title: const Text(
                                "After Meal",
                                style: TextStyle(fontSize: 14),
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
                          color: Colors.grey[800],
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
                            final TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (picked != null) {
                              setModalState(() {
                                doseTimes.add(picked);
                              });
                            }
                          },
                          icon: Icon(Icons.access_time, size: 18),
                          label: Text("Add Dose Time"),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.primary,
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
                                  color: Colors.grey[800],
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
                                          icon: Icon(
                                            Icons.edit_calendar_rounded,
                                            size: 18,
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
                                  color: Colors.grey[800],
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
                                          icon: Icon(
                                            Icons.edit_calendar_rounded,
                                            size: 18,
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
                      botton(
                        editingMedicine != null
                            ? "Update Medicine"
                            : "Add Medicine",
                        () async {
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Medicine updated successfully'),
                              ),
                            );
                          } else {
                            await db.createMedicine(medicine);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Medicine added successfully'),
                              ),
                            );
                          }
                          Navigator.pop(context);
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
    return Scaffold(
      appBar: appBar("Medicine Tracking"),
      body: StreamBuilder<List<Medicine>>(
        key: _streamKey,
        stream: db.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No medicines found. \nAdd a new medicine!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          }
          final medicines = snapshot.data!;
          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: medicines.length,
            itemBuilder: (context, index) {
              final medicine = medicines[index];
              return Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        medicine.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      Gap(8),
                      Text('Dosage: ${medicine.dosage}'),
                      if (medicine.frequency != null)
                        Text(
                          'Frequency: ${medicine.frequency} time${medicine.frequency! > 1 ? 's' : ''} per day',
                        ),
                      Text('Dose Times: ${medicine.doseTimes.join(', ')}'),
                      if (medicine.mealTiming != null)
                        Text('Meal Timing: ${medicine.mealTiming}'),
                      if (medicine.startDate != null)
                        Text(
                          'Start Date: ${medicine.startDate!.day}/${medicine.startDate!.month}/${medicine.startDate!.year}',
                        ),
                      if (medicine.endDate != null)
                        Text(
                          'End Date: ${medicine.endDate!.day}/${medicine.endDate!.month}/${medicine.endDate!.year}',
                        ),
                      Gap(12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              _showBottomSheet(medicineToEdit: medicine);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              final db = MedicineDatabase();
                              await db.deleteMedicine(medicine);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Medicine deleted successfully',
                                  ),
                                ),
                              );
                              setState(() {
                                _streamKey.currentState?.dispose();
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        onPressed: () => _showBottomSheet(),
        child: Icon(Icons.add_alarm_outlined),
      ),
    );
  }
}
