import 'package:flutter/material.dart';
import '../model/payslip_model.dart';

class PayslipViewModel extends ChangeNotifier {
  late PayslipModel payslip;

  // Payslip history
  final List<PayslipModel> payslipHistory = [
    PayslipModel(
      employeeName: "Hemant Rangarajan",
      designation: "Full-stack Developer",
      employeeId: "Employee ID",
      dateOfJoining: "30/05/2025",
      payPeriod: "June 2025",
      payDate: "15/07/2025",
      earnings: {
        "Basic": 25000,
        "HRA": 10000,
        "Travel Allowance": 3000,
        "Meal / Other Allowance": 2000,
      },
      earningsYTD: {
        "Basic": 300000,
        "HRA": 120000,
        "Travel Allowance": 36000,
        "Meal / Other Allowance": 24000,
      },
      deductions: {
        "PF Deduction": 2500,
        "Tax Deduction": 7500,
      },
      deductionsYTD: {
        "PF Deduction": 30000,
        "Tax Deduction": 90000,
      },
      grossEarnings: 55000,
      totalDeductions: 10000,
      netPayable: 45000,
      pfNumber: 'AA/AAA/999999/99G/9899',
      uan: '1111111111',
    ),
    PayslipModel(
      employeeName: "Hemant Rangarajan",
      designation: "Full-stack Developer",
      employeeId: "Employee ID",
      dateOfJoining: "30/05/2025",
      payPeriod: "May 2025",
      payDate: "15/06/2025",
      earnings: {
        "Basic": 25000,
        "HRA": 10000,
        "Travel Allowance": 3000,
        "Meal / Other Allowance": 2000,
      },
      earningsYTD: {
        "Basic": 275000,
        "HRA": 110000,
        "Travel Allowance": 33000,
        "Meal / Other Allowance": 22000,
      },
      deductions: {
        "PF Deduction": 2500,
        "Tax Deduction": 7500,
      },
      deductionsYTD: {
        "PF Deduction": 27500,
        "Tax Deduction": 82500,
      },
      grossEarnings: 55000,
      totalDeductions: 10000,
      netPayable: 45000,
      pfNumber: 'AA/AAA/999999/99G/9899',
      uan: '1111111111',
    ),
    PayslipModel(
      employeeName: "Hemant Rangarajan",
      designation: "Full-stack Developer",
      employeeId: "Employee ID",
      dateOfJoining: "30/05/2025",
      payPeriod: "April 2025",
      payDate: "15/05/2025",
      earnings: {
        "Basic": 23000,
        "HRA": 9500,
        "Travel Allowance": 3000,
        "Meal / Other Allowance": 2000,
      },
      earningsYTD: {
        "Basic": 250000,
        "HRA": 100000,
        "Travel Allowance": 30000,
        "Meal / Other Allowance": 20000,
      },
      deductions: {
        "PF Deduction": 2500,
        "Tax Deduction": 7500,
      },
      deductionsYTD: {
        "PF Deduction": 25000,
        "Tax Deduction": 75000,
      },
      grossEarnings: 55000,
      totalDeductions: 10000,
      netPayable: 43500,
      pfNumber: 'AA/AAA/999999/99G/9899',
      uan: '1111111111',
    ),
  ];

  PayslipViewModel() {
    // Set initial payslip to latest
    payslip = payslipHistory[0];
  }

  void selectPayslip(PayslipModel selected) {
    payslip = selected;
    notifyListeners();
  }
}
