abstract class BmiState {}

class BmiInitialState extends BmiState {}

class BmiCalculatedState extends BmiState {
  final double bmi;

  BmiCalculatedState(this.bmi);
}

class BmiWarningState extends BmiState {
  final String message;

  BmiWarningState(this.message);
}