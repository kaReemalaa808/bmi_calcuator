import 'package:flutter_bloc/flutter_bloc.dart';
import 'bmi_state.dart';

class BmiCubit extends Cubit<BmiState> {
  BmiCubit() : super(BmiInitialState());

  void calculateBmi({
    required double weight,
    required double height,
    required int age,
  }) {
    if (weight < 10 || age < 5 || height < 50) {
      emit(BmiWarningState("برجاء إدخال بيانات صحيحةيابطل"));
      return;
    }
    final heightMeter = height / 100;
    final bmi = weight / (heightMeter * heightMeter);
    emit(BmiCalculatedState(bmi));
  }
}
