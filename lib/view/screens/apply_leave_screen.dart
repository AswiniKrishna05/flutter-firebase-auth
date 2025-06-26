import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/constants/app_colors.dart';
import 'package:provider/provider.dart';
import '../../constants/strings.dart';
import '../../view_model/apply_leave_view_model.dart';

class ApplyLeaveScreen extends StatelessWidget {
  const ApplyLeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ApplyLeaveViewModel()
        ..nameController.text = AppStrings.employeeNameAutoFilled
        ..idController.text = AppStrings.employeeIdAutoFilled,
      child: const _ApplyLeaveForm(),
    );
  }
}

class _ApplyLeaveForm extends StatelessWidget {
  const _ApplyLeaveForm();

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ApplyLeaveViewModel>(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 20),

              const SizedBox(height: 16),
              Text(AppStrings.applyForLeave, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),

              const SizedBox(height: 18),
              // Employee Name
              const Text(AppStrings.employeeName, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: AppColors.grey)),
              const SizedBox(height: 6),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: model.nameController,
                  readOnly: true,
                  style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: AppColors.grey),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  ),
                ),
              ),

              const SizedBox(height: 12),
              // Employee ID
              const Text(AppStrings.employeeId, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: AppColors.grey)),
              const SizedBox(height: 6),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: model.idController,
                  readOnly: true,
                  style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: AppColors.grey),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.badge_outlined),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  ),
                ),
              ),

              const SizedBox(height: 12),
              // From and To Date
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('From', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: AppColors.grey)),
                        const SizedBox(height: 6),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withOpacity(0.1),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            readOnly: true,
                            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: AppColors.grey),
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.calendar_today),
                              hintText: AppStrings.fromDateHint,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                              ),
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                            ),
                            onTap: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(), // 👈 Prevents selecting past dates
                                lastDate: DateTime(2100),
                              );
                              if (picked != null) model.setFromDate(picked);
                            },

                            controller: TextEditingController(
                              text: model.fromDate != null
                                  ? "${model.fromDate!.day}/${model.fromDate!.month}/${model.fromDate!.year}"
                                  : '',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 20,
                    alignment: Alignment.center,
                    child: const Icon(Icons.compare_arrows, color: AppColors.grey, size: 18),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('To', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: AppColors.grey)),
                        const SizedBox(height: 6),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withOpacity(0.1),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            readOnly: true,
                            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: AppColors.grey),
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.calendar_today),
                              hintText: AppStrings.toDateHint,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                              ),
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                            ),
                            onTap: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: model.fromDate ?? DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2100),
                              );
                              if (picked != null) model.setToDate(picked);
                            },
                            controller: TextEditingController(
                              text: model.toDate != null
                                  ? "${model.toDate!.day}/${model.toDate!.month}/${model.toDate!.year}"
                                  : '',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),
              // Leave Type and Choose Type
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withOpacity(0.1),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IgnorePointer(
                        ignoring: true,
                        child: DropdownButtonFormField<String>(
                          value: model.leaveType,
                          items: model.leaveTypes.map((type) {
                            return DropdownMenuItem(value: type, child: Text(type, style: TextStyle(fontSize: 15, color: AppColors.grey)));
                          }).toList(),
                          onChanged: null,
                          isExpanded: true,
                          icon: SizedBox.shrink(),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.exit_to_app, size: 20),
                            hintText: AppStrings.leaveType,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withOpacity(0.1),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: DropdownButtonFormField<String>(
                        value: model.chooseType,
                        items: model.chooseTypes.map((type) {
                          return DropdownMenuItem(value: type, child: Text(type, style: TextStyle(fontSize: 15, color: AppColors.grey)));
                        }).toList(),
                        onChanged: model.setChooseType,
                        isExpanded: true,
                        decoration: const InputDecoration(
                          hintText: AppStrings.chooseType,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),
              // Reason
              const Text('Reason', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: AppColors.grey)),
              const SizedBox(height: 6),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: model.reasonController,
                  maxLines: 4,
                  style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: AppColors.grey),
                  decoration: const InputDecoration(
                    hintText: AppStrings.textArea,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  ),
                ),
              ),

              const SizedBox(height: 12),
              // Attachment
              const Text('Attachment', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: AppColors.grey)),
              const SizedBox(height: 6),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: model.selectedFile != null
                    ? Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            const Icon(Icons.attachment, color: AppColors.blue),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    model.attachmentName ?? AppStrings.selectedFile,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  Text(
                                    '${(model.selectedFile!.size / 1024).toStringAsFixed(1)} KB',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: model.removeFile,
                              icon: const Icon(Icons.close, color: AppColors.red),
                              iconSize: 20,
                            ),
                          ],
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          print('Attachment button tapped!');
                          model.pickFile();
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                          child: Row(
                            children: [
                              Icon(Icons.attachment, color: AppColors.blue),
                              SizedBox(width: 8),
                              Text(
                                AppStrings.chooseFile,
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => model.submitLeaveForm(context),
                  child: const Text(AppStrings.submit, style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
