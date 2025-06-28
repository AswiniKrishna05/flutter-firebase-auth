import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/constants/app_colors.dart';
import 'package:flutter_firebase_auth/view/widgets/bottom_bar.dart';
import 'package:flutter_firebase_auth/view/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';
import '../../utils/pdf_generator.dart';
import '../../view_model/payslip_view_model.dart';
import '../../constants/strings.dart';

class PayslipScreen extends StatelessWidget {
  const PayslipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PayslipViewModel(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: CustomAppBar(),
        body: Consumer<PayslipViewModel>(
          builder: (context, model, _) {
            final p = model.payslip;

            return Stack(children: [
              // Watermark Image
              Positioned(
                top: 270, // Optional: adjust position
                left: 100, // Optional: adjust position
                child: Opacity(
                  opacity: 0.1, // Low opacity for watermark effect
                  child: Image.asset(
                    'assets/Vector.png',
                    width: 200, // Decrease width
                    height: 200, // Decrease height
                  ),
                ),
              ),

              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage('assets/Vector.png'),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(AppStrings.appName,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.blue)),
                                Text(AppStrings.appSubtitle,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.green)),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(AppStrings.payslipForMonth,
                                style: TextStyle(
                                    fontSize: 12, color: AppColors.textLight)),
                            Text(p.payPeriod,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 16),
                    const Text(AppStrings.employeeSummary,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _PayslipInfoRow(
                                  AppStrings.employeeName, p.employeeName),
                              _PayslipInfoRow(
                                  AppStrings.fullStackDeveloper, p.designation),
                              _PayslipInfoRow(
                                  AppStrings.employeeId, p.employeeId),
                              _PayslipInfoRow(
                                  AppStrings.dateOfJoining, p.dateOfJoining),
                              _PayslipInfoRow(
                                  AppStrings.payPeriod, p.payPeriod),
                              _PayslipInfoRow(AppStrings.payDate, p.payDate),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(color: AppColors.verylightgreen),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Top Section with Light Green Background
                                Container(
                                  width: double.infinity,
                                  color: AppColors.verylightgreen,
                                  // Light green shade
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 2,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: AppColors.green,
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "₹ 45,000",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.black,
                                            ),
                                          ),
                                          Text(
                                            AppStrings.employeeNetPay,
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: AppColors.textLight,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                // Dotted Divider
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 0),
                                  child: LayoutBuilder(
                                    builder: (BuildContext context,
                                        BoxConstraints constraints) {
                                      final boxWidth =
                                          constraints.constrainWidth();
                                      const dashWidth = 2.0;
                                      const dashHeight = 1.0;
                                      const dashSpacing = 2.0;
                                      final dashCount =
                                          (boxWidth / (dashWidth + dashSpacing))
                                              .floor();

                                      return Flex(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        direction: Axis.horizontal,
                                        children: List.generate(dashCount, (_) {
                                          return SizedBox(
                                            width: dashWidth,
                                            height: dashHeight,
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                  color: AppColors.grey),
                                            ),
                                          );
                                        }),
                                      );
                                    },
                                  ),
                                ),

                                // Bottom Section (White Background)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  child: Wrap(
                                    runSpacing: 4,
                                    spacing: 8,
                                    direction: Axis.horizontal,
                                    children: const [
                                      _BoxInfoRow(AppStrings.paidDays, "31"),
                                      _BoxInfoRow(AppStrings.lopDays, "0"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    Row(
                      children: [
                        Text(
                          "${AppStrings.pfAc} Number    :  ${p.pfNumber}",
                          style: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "UAN   :   ${p.uan}",
                              style: const TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.grey400),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: const [
                                Expanded(
                                    flex: 2,
                                    child: Text(AppStrings.earnings,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 9))),
                                Expanded(
                                    child: Text(AppStrings.amount,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 9))),
                                Expanded(
                                    child: Text(" ${AppStrings.ytd}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 9))),
                                SizedBox(width: 14),
                                Expanded(
                                    flex: 2,
                                    child: Text(AppStrings.deductions,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 9))),
                                Expanded(
                                    child: Text("${AppStrings.amount} ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 9))),
                                Expanded(
                                    child: Text(" ${AppStrings.ytd}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 9))),
                              ],
                            ),
                          ),
                          ...List.generate(
                            p.earnings.length,
                            (i) {
                              final eKey = p.earnings.keys.elementAt(i);
                              final eAmt = p.earnings[eKey]!;
                              final eYTD = p.earningsYTD[eKey] ?? 0;

                              final dKey = i < p.deductions.length
                                  ? p.deductions.keys.elementAt(i)
                                  : "";
                              final dAmt = i < p.deductions.length
                                  ? p.deductions[dKey]!
                                  : 0;
                              final dYTD = i < p.deductions.length
                                  ? p.deductionsYTD[dKey] ?? 0
                                  : 0;

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 12),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: Text(eKey,
                                            style: TextStyle(fontSize: 9))),
                                    Expanded(
                                        child: Text(
                                            "₹ ${eAmt.toStringAsFixed(0)}",
                                            style: TextStyle(fontSize: 8))),
                                    Expanded(
                                        child: Text(
                                            "₹ ${eYTD.toStringAsFixed(0)}",
                                            style: TextStyle(fontSize: 8))),
                                    const SizedBox(width: 16),
                                    Expanded(
                                        flex: 2,
                                        child: Text(dKey,
                                            style: TextStyle(fontSize: 8))),
                                    Expanded(
                                        child: Text(
                                            "₹ ${dAmt.toStringAsFixed(0)}",
                                            style: TextStyle(fontSize: 8))),
                                    Expanded(
                                        child: Text(
                                            "₹ ${dYTD.toStringAsFixed(0)}",
                                            style: TextStyle(fontSize: 8))),
                                  ],
                                ),
                              );
                            },
                          ),
                          Container(
                            color: Colors.blue.shade50,
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 12),
                            child: Row(
                              children: [
                                const Expanded(
                                    flex: 2,
                                    child: Text(AppStrings.grossEarnings,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10))),
                                Expanded(
                                  child: Text(
                                      "₹ ${p.grossEarnings.toStringAsFixed(0)}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10)),
                                ),
                                const Expanded(
                                    child: Text("",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10))),
                                const SizedBox(width: 16),
                                const Expanded(
                                    flex: 2,
                                    child: Text(AppStrings.totalDeductions,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10))),
                                Expanded(
                                    child: Text(
                                        "₹ ${p.totalDeductions.toStringAsFixed(0)}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10))),
                                const Expanded(child: Text("")),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.grey400),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            flex: 3,
                            child: Padding(
                              padding: EdgeInsets.only(left: 16),
                              // You can adjust this value as needed
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(AppStrings.totalNetPayable,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13)),
                                  Text(AppStrings.grossEarningsTotalDeductions,
                                      style: TextStyle(
                                          color: AppColors.textLight,
                                          fontSize: 12)),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                "₹ ${p.netPayable.toStringAsFixed(0)}",
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.only(left: 80.0),
                      // Add margin to the start
                      child: Row(
                        children: [
                          const Text(AppStrings.amountInWordsPrefix,
                              style: TextStyle(
                                  color: AppColors.textLight,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              AppStrings.indianRupeeFortyFiveThousandOnly,
                              style: TextStyle(
                                  color: AppColors.textLight,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Divider(),
                    const Center(
                      child: Text(
                        AppStrings.autoGeneratedText,
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textLight),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          await PayslipPdfGenerator.generateAndDownload(
                              model.payslip);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[400],
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text(
                          AppStrings.downloadPayslip,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(AppStrings.monthlyPayslipHistory,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.grey400),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          _buildHistoryRow(AppStrings.month, AppStrings.netPay,
                              AppStrings.status, AppStrings.action,
                              isHeader: true),
                          ...List.generate(model.payslipHistory.length, (i) {
                            final payslip = model.payslipHistory[i];
                            final isSelected =
                                payslip.payPeriod == model.payslip.payPeriod;
                            return InkWell(
                              onTap: () {
                                model.selectPayslip(payslip);
                              },
                              child: Container(
                                decoration: isSelected
                                    ? BoxDecoration(
                                        color: Colors.blue.withOpacity(0.08),
                                        borderRadius: BorderRadius.circular(6),
                                      )
                                    : null,
                                child: _buildHistoryRow(
                                  payslip.payPeriod,
                                  "₹${payslip.netPayable.toStringAsFixed(0)}",
                                  "✅Generated",
                                  "[📥 Download]",
                                  isHeader: false,
                                  onDownload: () async {
                                    await PayslipPdfGenerator
                                        .generateAndDownload(payslip);
                                  },
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ]);
          },
        ),
        bottomNavigationBar: BottomBar(),
      ),
    );
  }

  Widget _buildHistoryRow(
      String month, String pay, String status, String action,
      {bool isHeader = false, VoidCallback? onDownload}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text(month,
                  style: TextStyle(
                      fontWeight:
                          isHeader ? FontWeight.bold : FontWeight.normal,
                      fontSize: 11))),
          Expanded(
              child: Text(pay,
                  style: TextStyle(
                      fontWeight:
                          isHeader ? FontWeight.bold : FontWeight.normal,
                      fontSize: 11))),
          Expanded(
              child: Text(status,
                  style: TextStyle(
                      fontWeight:
                          isHeader ? FontWeight.bold : FontWeight.normal,
                      fontSize: 11))),
          Expanded(
            child: isHeader
                ? Text(action,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))
                : GestureDetector(
                    onTap: onDownload,
                    child: Text(action,
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 11,
                            decoration: TextDecoration.underline)),
                  ),
          ),
        ],
      ),
    );
  }
}

class _PayslipInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _PayslipInfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
              child: Text(label,
                  style: const TextStyle(
                      color: AppColors.textLight, fontSize: 12))),
          const Text(" : "),
          Expanded(
              child: Text(value,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 12))),
        ],
      ),
    );
  }
}

class _BoxInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _BoxInfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
          const SizedBox(width: 4),
          const Text(":",
              style: TextStyle(fontSize: 11, color: AppColors.textLight)),
          const SizedBox(width: 4),
          Text(value,
              style:
                  const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
