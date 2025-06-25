import '../model/leave_status_model.dart';

class LeaveStatusViewModel {
  List<LeaveStatusModel> getLeaveSummary() {
    return [
      LeaveStatusModel(title: 'Leave Taken', value: '16 days'),
      LeaveStatusModel(title: 'Leave Balance', value: '8 days'),
      LeaveStatusModel(title: 'Pending Request', value: '1 request'),
      LeaveStatusModel(title: 'Approved Leaves', value: '5 leaves'),
      LeaveStatusModel(title: 'Rejected Leaves', value: '2 leaves'),
      LeaveStatusModel(title: 'Upcoming Leaves', value: '1 leave'),
    ];
  }
}
