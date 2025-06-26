import 'package:flutter/material.dart';
import '../../model/payslip_model.dart';
import '../../utils/pdf_generator.dart';

class PayslipHistoryScreen extends StatefulWidget {
  @override
  _PayslipHistoryScreenState createState() => _PayslipHistoryScreenState();
}

class _PayslipHistoryScreenState extends State<PayslipHistoryScreen> {
  List<PayslipModel> payslips = []; // You should fill this with real data
  PayslipModel? selectedPayslip;

  @override
  void initState() {
    super.initState();

    // Example data
    payslips = [
      PayslipModel(
        employeeName: 'Hemant Rangarajan',
        designation: 'Full-stack Developer',
        employeeId: 'EMP123',
        dateOfJoining: '30/05/2025',
        payPeriod: 'May 2025',
        payDate: '15/06/2025',
        pfNumber: 'AA/AAA/999999/99G/9899',
        uan: '111111111111',
        earnings: {'Basic': 25000, 'HRA': 10000, 'Travel Allowance': 3000, 'Meal / Other Allowance': 2000},
        earningsYTD: {'Basic': 300000, 'HRA': 120000, 'Travel Allowance': 36000, 'Meal / Other Allowance': 24000},
        deductions: {'PF Deduction': 2500, 'Tax Deduction': 7500},
        deductionsYTD: {'PF Deduction': 30000, 'Tax Deduction': 90000},
        grossEarnings: 55000,
        totalDeductions: 10000,
        netPayable: 45000,
      ),
      // Add more payslip data for April and March here
    ];

    selectedPayslip = payslips[0]; // Show the first payslip by default
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Monthly Payslip History')),
      body: Column(
        children: [
          // Payslip History Table
          DataTable(
            columns: [
              DataColumn(label: Text('Month')),
              DataColumn(label: Text('Net Pay')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('Action')),
            ],
            rows: payslips.map((payslip) {
              return DataRow(cells: [
                DataCell(Text(payslip.payPeriod)),
                DataCell(Text('₹${payslip.netPayable.toStringAsFixed(0)}')),
                DataCell(Row(
                  children: [
                    Icon(Icons.check_box, color: Colors.green),
                    Text('Generated'),
                  ],
                )),
                DataCell(
                  GestureDetector(
                    onTap: ()async {
                      await PayslipPdfGenerator.generateAndDownload(payslip);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.download, color: Colors.brown),
                        Text(' Download'),
                      ],
                    ),
                  ),
                ),
              ]);
            }).toList(),
          ),

          SizedBox(height: 20),

          // Selected Payslip Details
          if (selectedPayslip != null) ...[
            Text(
              'Payslip Details for ${selectedPayslip!.payPeriod}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Employee: ${selectedPayslip!.employeeName}'),
            Text('Designation: ${selectedPayslip!.designation}'),
            Text('Employee ID: ${selectedPayslip!.employeeId}'),
            Text('Date of Joining: ${selectedPayslip!.dateOfJoining}'),
            Text('PF Number: ${selectedPayslip!.pfNumber}'),
            Text('UAN: ${selectedPayslip!.uan}'),
            SizedBox(height: 10),
            Text('Net Pay: ₹${selectedPayslip!.netPayable.toStringAsFixed(0)}',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Divider(),
            Text('Earnings:', style: TextStyle(fontWeight: FontWeight.bold)),
            ...selectedPayslip!.earnings.entries.map((e) => Text('${e.key}: ₹${e.value.toStringAsFixed(0)}')).toList(),
            SizedBox(height: 10),
            Text('Deductions:', style: TextStyle(fontWeight: FontWeight.bold)),
            ...selectedPayslip!.deductions.entries.map((d) => Text('${d.key}: ₹${d.value.toStringAsFixed(0)}')).toList(),
          ],
        ],
      ),
    );
  }
}
