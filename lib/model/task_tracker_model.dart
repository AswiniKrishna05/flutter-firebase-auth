import 'task_model.dart';

class TaskTrackerModel {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final double progress;
  final TaskStatus status;
  final TaskPriority priority;
  final String? assignedBy;
  final String assignedTo;
  final DateTime assignedDate;
  final DateTime? completedDate;
  final String? notes;
  final List<String> tags;
  final String? attachment;

  TaskTrackerModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    this.progress = 0.0,
    this.status = TaskStatus.notStarted,
    this.priority = TaskPriority.medium,
    this.assignedBy,
    required this.assignedTo,
    required this.assignedDate,
    this.completedDate,
    this.notes,
    this.tags = const [],
    this.attachment,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'progress': progress,
      'status': status.name,
      'priority': priority.name,
      'assignedBy': assignedBy,
      'assignedTo': assignedTo,
      'assignedDate': assignedDate.toIso8601String(),
      'completedDate': completedDate?.toIso8601String(),
      'notes': notes,
      'tags': tags,
      'attachment': attachment,
    };
  }

  factory TaskTrackerModel.fromMap(Map<String, dynamic> map) {
    return TaskTrackerModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      dueDate: DateTime.parse(map['dueDate']),
      progress: (map['progress'] ?? 0.0).toDouble(),
      status: TaskStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => TaskStatus.notStarted,
      ),
      priority: TaskPriority.values.firstWhere(
        (e) => e.name == map['priority'],
        orElse: () => TaskPriority.medium,
      ),
      assignedBy: map['assignedBy'],
      assignedTo: map['assignedTo'] ?? '',
      assignedDate: DateTime.parse(map['assignedDate']),
      completedDate: map['completedDate'] != null 
          ? DateTime.parse(map['completedDate']) 
          : null,
      notes: map['notes'],
      tags: List<String>.from(map['tags'] ?? []),
      attachment: map['attachment'],
    );
  }

  TaskTrackerModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dueDate,
    double? progress,
    TaskStatus? status,
    TaskPriority? priority,
    String? assignedBy,
    String? assignedTo,
    DateTime? assignedDate,
    DateTime? completedDate,
    String? notes,
    List<String>? tags,
    String? attachment,
  }) {
    return TaskTrackerModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      progress: progress ?? this.progress,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      assignedBy: assignedBy ?? this.assignedBy,
      assignedTo: assignedTo ?? this.assignedTo,
      assignedDate: assignedDate ?? this.assignedDate,
      completedDate: completedDate ?? this.completedDate,
      notes: notes ?? this.notes,
      tags: tags ?? this.tags,
      attachment: attachment ?? this.attachment,
    );
  }

  // Computed properties
  bool get isNotStarted => status == TaskStatus.notStarted;
  bool get isInProgress => status == TaskStatus.inProgress;
  bool get isCompleted => status == TaskStatus.completed;
  bool get isOverdue => status == TaskStatus.overdue;
  bool get isCancelled => status == TaskStatus.cancelled;

  bool get isUrgent => priority == TaskPriority.urgent;
  bool get isHigh => priority == TaskPriority.high;
  bool get isMedium => priority == TaskPriority.medium;
  bool get isLow => priority == TaskPriority.low;

  bool get isOverdueDate => DateTime.now().isAfter(dueDate) && !isCompleted;
  int get daysRemaining => dueDate.difference(DateTime.now()).inDays;
  int get daysOverdue => isOverdueDate ? DateTime.now().difference(dueDate).inDays : 0;

  String get progressPercentage => '${(progress * 100).toInt()}%';

  // Convert to TaskModel
  TaskModel toTaskModel() {
    return TaskModel(
      id: id,
      title: title,
      description: description,
      assignedTo: assignedTo,
      assignedBy: assignedBy ?? '',
      assignedDate: assignedDate,
      dueDate: dueDate,
      status: status,
      priority: priority,
      progress: progress,
      tags: tags,
      attachment: attachment,
      notes: notes,
      completedDate: completedDate,
      completedBy: isCompleted ? assignedTo : null,
    );
  }
}