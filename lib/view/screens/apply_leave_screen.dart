import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/apply_leave_view_model.dart';

class ApplyLeaveScreen extends StatelessWidget {
  const ApplyLeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ApplyLeaveViewModel()
        ..nameController.text = 'Employee name - auto-filled'
        ..idController.text = 'Employee ID - auto-filled',
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Custom Top Bar
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/ziya_logo.png', width: 40),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 38,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: "Search",
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Stack(
                    children: [
                      const Icon(Icons.notifications, color: Colors.blue, size: 28),
                      Positioned(
                        right: 0,
                        top: 2,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  const CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage('https://media.istockphoto.com/id/1682296067/photo/happy-studio-portrait-or-professional-man-real-estate-agent-or-asian-businessman-smile-for.jpg?s=612x612&w=0&k=20&c=9zbG2-9fl741fbTWw5fNgcEEe4ll-JegrGlQQ6m54rg='),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 2.0, bottom: 4),
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 36,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.arrow_back, size: 20),
                            SizedBox(width: 6),
                            Text('Back', style: TextStyle(fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),
              Text('Apply for Leave', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),

              const SizedBox(height: 18),
              // Employee Name
              Text('Employee Name', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.grey[600])),
              const SizedBox(height: 6),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: model.nameController,
                  readOnly: true,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: Colors.grey[600]),
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
              Text('Employee ID', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.grey[600])),
              const SizedBox(height: 6),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: model.idController,
                  readOnly: true,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: Colors.grey[600]),
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
                        Text('From', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.grey[600])),
                        const SizedBox(height: 6),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            readOnly: true,
                            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: Colors.grey[600]),
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.calendar_today),
                              hintText: 'From Date',
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
                                firstDate: DateTime(2020),
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
                    child: const Icon(Icons.compare_arrows, color: Colors.grey, size: 18),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('To', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.grey[600])),
                        const SizedBox(height: 6),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            readOnly: true,
                            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: Colors.grey[600]),
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.calendar_today),
                              hintText: 'To Date',
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
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
                            return DropdownMenuItem(value: type, child: Text(type, style: TextStyle(fontSize: 15, color: Colors.grey[600])));
                          }).toList(),
                          onChanged: null,
                          isExpanded: true,
                          icon: SizedBox.shrink(),
                          style: TextStyle(color: Colors.grey[600]),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.exit_to_app, size: 20),
                            hintText: 'Leave Type',
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: DropdownButtonFormField<String>(
                        value: model.chooseType,
                        items: model.chooseTypes.map((type) {
                          return DropdownMenuItem(value: type, child: Text(type, style: TextStyle(fontSize: 15, color: Colors.grey[600])));
                        }).toList(),
                        onChanged: model.setChooseType,
                        isExpanded: true,
                        style: TextStyle(color: Colors.grey[600]),
                        decoration: const InputDecoration(
                          hintText: 'Choose Type',
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
              Text('Reason', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.grey[600])),
              const SizedBox(height: 6),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: model.reasonController,
                  maxLines: 4,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: Colors.grey[600]),
                  decoration: const InputDecoration(
                    hintText: 'Text area',
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
              Text('Attachment', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.grey[600])),
              const SizedBox(height: 6),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextFormField(
                  style: TextStyle(color: Colors.grey[600]),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.attachment),
                    hintText: 'Attachment(Optional)',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  ),
                  onChanged: model.setAttachment,
                ),
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => model.submitLeaveForm(context),
                  child: const Text('Submit', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
