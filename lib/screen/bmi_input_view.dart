import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bmi_cubit.dart';
import 'bmi_state.dart';
import 'bmi_result_view.dart';

class BmiInputView extends StatelessWidget {
  BmiInputView({super.key});

  final TextEditingController weightController = TextEditingController();

  final TextEditingController heightController = TextEditingController();

  final TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<BmiCubit, BmiState>(
      listener: (context, state) {
        if (state is BmiWarningState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(backgroundColor: Colors.red, content: Text(state.message)),
          );
        }

        if (state is BmiCalculatedState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => BmiResultView(bmi: state.bmi)),
          );
        }
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff4A00E0), Color(0xff8E2DE2)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  const Icon(Icons.favorite, color: Colors.white, size: 90),

                  const SizedBox(height: 10),

                  const Text(
                    "BMI Calculator",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 40),

                  Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(35),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: weightController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Weight (kg)",
                            prefixIcon: const Icon(
                              Icons.monitor_weight,
                              color: Colors.deepPurple,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        TextField(
                          controller: heightController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Height (cm)",
                            prefixIcon: const Icon(
                              Icons.height,
                              color: Colors.deepPurple,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        TextField(
                          controller: ageController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Age",
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Colors.deepPurple,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),

                        const SizedBox(height: 35),

                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              final weight =
                                  double.tryParse(weightController.text) ?? 0;

                              final height =
                                  double.tryParse(heightController.text) ?? 0;

                              final age = int.tryParse(ageController.text) ?? 0;

                              context.read<BmiCubit>().calculateBmi(
                                weight: weight,
                                height: height,
                                age: age,
                              );
                            },
                            child: const Text(
                              "Calculate BMI",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
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
        ),
      ),
    );
  }
}
