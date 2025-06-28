import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../model/payslip_model.dart';

class PayslipPdfGenerator {
  static Future<void> generateAndDownload(PayslipModel payslip) async {
    final pdf = pw.Document();
    final logoBytes = await rootBundle.load('assets/Vector.png');
    final logoImage = pw.MemoryImage(logoBytes.buffer.asUint8List());

    final watermarkBytes = await rootBundle.load('assets/Vector.png');
    final watermarkImage = pw.MemoryImage(watermarkBytes.buffer.asUint8List());

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Stack(
            children: [
              // Watermark (behind everything)
              pw.Positioned.fill(
                child: pw.Opacity(
                  opacity: 0.1,
                  child: pw.Center(
                    child: pw.Image(watermarkImage,
                        width: 300, height: 300, fit: pw.BoxFit.contain),
                  ),
                ),
              ),

              // Payslip Content
              pw.Padding(
                padding: const pw.EdgeInsets.all(16),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // Your existing header and employee summary code...
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Row(
                          children: [
                            pw.Image(logoImage, width: 40, height: 40),
                            pw.SizedBox(width: 8),
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text('ZiyaAcademy',
                                    style: pw.TextStyle(
                                        fontSize: 18,
                                        fontWeight: pw.FontWeight.bold,
                                        color: PdfColors.blue)),
                                pw.Text('KEY-TO SUCCESS',
                                    style: pw.TextStyle(
                                        fontSize: 12, color: PdfColors.green)),
                              ],
                            ),
                          ],
                        ),
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Text('Payslip for the Month',
                                style: pw.TextStyle(
                                    fontSize: 12, color: PdfColors.grey700)),
                            pw.Text(payslip.payPeriod,
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 12),
                    pw.Divider(),
                    pw.Text('EMPLOYEE SUMMARY',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(height: 8),

                    pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Expanded(
                          flex: 3,
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              _pdfInfoRow(
                                  'Employee Name', payslip.employeeName),
                              _pdfInfoRow('Designation', payslip.designation),
                              _pdfInfoRow('Employee ID', payslip.employeeId),
                              _pdfInfoRow(
                                  'Date of Joining', payslip.dateOfJoining),
                              _pdfInfoRow('Pay Period', payslip.payPeriod),
                              _pdfInfoRow('Pay Date', payslip.payDate),
                            ],
                          ),
                        ),
                        pw.SizedBox(width: 12),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(8),
                            decoration: pw.BoxDecoration(
                              color: PdfColors.green100,
                              borderRadius: pw.BorderRadius.circular(8),
                            ),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Text(
                                    '₹ ${payslip.netPayable.toStringAsFixed(0)}',
                                    style: pw.TextStyle(
                                        fontSize: 16,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text('Employee Net Pay',
                                    style: pw.TextStyle(
                                        fontSize: 10,
                                        color: PdfColors.green800)),
                                pw.SizedBox(height: 8),
                                pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text('Paid Days: 31',
                                        style: pw.TextStyle(fontSize: 9)),
                                    pw.Text('LOP Days: 0',
                                        style: pw.TextStyle(fontSize: 9)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    pw.SizedBox(height: 12),
                    pw.Text('PF A/C Number : ${payslip.pfNumber}'),
                    pw.Text('UAN : ${payslip.uan}'),

                    pw.SizedBox(height: 12),

                    pw.Table(
                      border: pw.TableBorder.all(color: PdfColors.grey300),
                      columnWidths: {
                        0: pw.FlexColumnWidth(2),
                        1: pw.FlexColumnWidth(1),
                        2: pw.FlexColumnWidth(1),
                        3: pw.FlexColumnWidth(2),
                        4: pw.FlexColumnWidth(1),
                        5: pw.FlexColumnWidth(1),
                      },
                      children: [
                        pw.TableRow(
                          decoration:
                              pw.BoxDecoration(color: PdfColors.grey200),
                          children: [
                            _tableCell('EARNINGS', isHeader: true),
                            _tableCell('AMOUNT', isHeader: true),
                            _tableCell('YTD', isHeader: true),
                            _tableCell('DEDUCTIONS', isHeader: true),
                            _tableCell('AMOUNT', isHeader: true),
                            _tableCell('YTD', isHeader: true),
                          ],
                        ),
                        ..._buildEarningsDeductionsRows(payslip),
                      ],
                    ),

                    pw.SizedBox(height: 16),
                    pw.Container(
                      color: PdfColors.blue50,
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Row(
                        children: [
                          pw.Expanded(
                              flex: 2,
                              child: pw.Text(
                                  'Gross Earnings: ₹ ${payslip.grossEarnings.toStringAsFixed(0)}',
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 10))),
                          pw.Expanded(
                              flex: 2,
                              child: pw.Text(
                                  'Total Deductions: ₹ ${payslip.totalDeductions.toStringAsFixed(0)}',
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 10))),
                        ],
                      ),
                    ),

                    // NEW TOTAL NET PAYABLE SECTION ADDED HERE
                    pw.SizedBox(height: 16),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          '# Total Net Payable',
                          style: pw.TextStyle(
                            fontSize: 14,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          'Gross Earnings - Total Deductions',
                          style: pw.TextStyle(
                            fontSize: 10,
                            color: PdfColors.grey600,
                          ),
                        ),
                        pw.SizedBox(height: 8),
                        pw.Text(
                          '¥ ${payslip.netPayable.toStringAsFixed(0)}',
                          style: pw.TextStyle(
                            fontSize: 18,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 8),
                        pw.Text(
                          'Amount in Words: Indian Rupee ${_amountToWords(payslip.netPayable)} Only',
                          style: pw.TextStyle(
                            fontSize: 10,
                            fontStyle: pw.FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 24),

                    pw.Divider(),
                    pw.Center(
                        child: pw.Text(
                            '- This document has been automatically generated by ZiyaAcademy -',
                            style: pw.TextStyle(
                                fontSize: 10, color: PdfColors.grey))),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }

  // Rest of your existing helper methods remain unchanged...
  static pw.Widget _pdfInfoRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        children: [
          pw.Expanded(child: pw.Text(label, style: pw.TextStyle(fontSize: 10))),
          pw.Text(': '),
          pw.Expanded(
              child: pw.Text(value,
                  style: pw.TextStyle(
                      fontSize: 10, fontWeight: pw.FontWeight.bold))),
        ],
      ),
    );
  }

  static List<pw.TableRow> _buildEarningsDeductionsRows(PayslipModel payslip) {
    final length = payslip.earnings.length > payslip.deductions.length
        ? payslip.earnings.length
        : payslip.deductions.length;

    List<pw.TableRow> rows = [];

    for (int i = 0; i < length; i++) {
      final eKey =
          i < payslip.earnings.length ? payslip.earnings.keys.elementAt(i) : '';
      final eAmt = i < payslip.earnings.length ? payslip.earnings[eKey]! : 0;
      final eYTD =
          i < payslip.earnings.length ? payslip.earningsYTD[eKey] ?? 0 : 0;

      final dKey = i < payslip.deductions.length
          ? payslip.deductions.keys.elementAt(i)
          : '';
      final dAmt =
          i < payslip.deductions.length ? payslip.deductions[dKey]! : 0;
      final dYTD =
          i < payslip.deductions.length ? payslip.deductionsYTD[dKey] ?? 0 : 0;

      rows.add(
        pw.TableRow(
          children: [
            _tableCell(eKey),
            _tableCell('₹ ${eAmt.toStringAsFixed(0)}'),
            _tableCell('₹ ${eYTD.toStringAsFixed(0)}'),
            _tableCell(dKey),
            _tableCell('₹ ${dAmt.toStringAsFixed(0)}'),
            _tableCell('₹ ${dYTD.toStringAsFixed(0)}'),
          ],
        ),
      );
    }

    return rows;
  }

  static pw.Widget _tableCell(String text, {bool isHeader = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(6),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 9,
          fontWeight: isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      ),
    );
  }

  static String _amountToWords(double amount) {
    // Implement your number to words conversion logic here
    return "Forty-Five Thousand"; // Example implementation
  }
}
