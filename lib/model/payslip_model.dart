class PayslipModel {
  final String employeeName;
  final String designation;
  final String employeeId;
  final String dateOfJoining;
  final String payPeriod;
  final String payDate;
  final String pfNumber;
  final String uan;

  final Map<String, double> earnings;
  final Map<String, double> earningsYTD;
  final Map<String, double> deductions;
  final Map<String, double> deductionsYTD;

  final double grossEarnings;
  final double totalDeductions;
  final double netPayable;

  PayslipModel({
    required this.employeeName,
    required this.designation,
    required this.employeeId,
    required this.dateOfJoining,
    required this.payPeriod,
    required this.payDate,
    required this.pfNumber,
    required this.uan,
    required this.earnings,
    required this.earningsYTD,
    required this.deductions,
    required this.deductionsYTD,
    required this.grossEarnings,
    required this.totalDeductions,
    required this.netPayable,
  });
}
