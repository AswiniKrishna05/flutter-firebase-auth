enum TaskStatus {
  notStarted,
  inProgress,
  completed,
  overdue,
  cancelled,
}

enum TaskPriority {
  low,
  medium,
  high,
  urgent,
}

class TaskModel {
  final String id;
  final String title;
  final String description;
  final String assignedTo;
  final String assignedBy;
  final DateTime assignedDate;
  final DateTime dueDate;
  final TaskStatus status;
  final TaskPriority priority;
  final double progress; // 0.0 to 1.0
  final List<String> tags;
  final String? attachment;
  final String? notes;
  final DateTime? completedDate;
  final String? completedBy;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.assignedTo,
    required this.assignedBy,
    required this.assignedDate,
    required this.dueDate,
    this.status = TaskStatus.notStarted,
    this.priority = TaskPriority.medium,
    this.progress = 0.0,
    this.tags = const [],
    this.attachment,
    this.notes,
    this.completedDate,
    this.completedBy,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'assignedTo': assignedTo,
      'assignedBy': assignedBy,
      'assignedDate': assignedDate.toIso8601String(),
      'dueDate': dueDate.toIso8601String(),
      'status': status.name,
      'priority': priority.name,
      'progress': progress,
      'tags': tags,
      'attachment': attachment,
      'notes': notes,
      'completedDate': completedDate?.toIso8601String(),
      'completedBy': completedBy,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      assignedTo: map['assignedTo'] ?? '',
      assignedBy: map['assignedBy'] ?? '',
      assignedDate: DateTime.parse(map['assignedDate']),
      dueDate: DateTime.parse(map['dueDate']),
      status: TaskStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => TaskStatus.notStarted,
      ),
      priority: TaskPriority.values.firstWhere(
        (e) => e.name == map['priority'],
        orElse: () => TaskPriority.medium,
      ),
      progress: (map['progress'] ?? 0.0).toDouble(),
      tags: List<String>.from(map['tags'] ?? []),
      attachment: map['attachment'],
      notes: map['notes'],
      completedDate: map['completedDate'] != null 
          ? DateTime.parse(map['completedDate']) 
          : null,
      completedBy: map['completedBy'],
    );
  }

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    String? assignedTo,
    String? assignedBy,
    DateTime? assignedDate,
    DateTime? dueDate,
    TaskStatus? status,
    TaskPriority? priority,
    double? progress,
    List<String>? tags,
    String? attachment,
    String? notes,
    DateTime? completedDate,
    String? completedBy,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      assignedTo: assignedTo ?? this.assignedTo,
      assignedBy: assignedBy ?? this.assignedBy,
      assignedDate: assignedDate ?? this.assignedDate,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      progress: progress ?? this.progress,
      tags: tags ?? this.tags,
      attachment: attachment ?? this.attachment,
      notes: notes ?? this.notes,
      completedDate: completedDate ?? this.completedDate,
      completedBy: completedBy ?? this.completedBy,
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
} 