import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user_session_model.dart';

class ProfileViewModel extends ChangeNotifier {
  UserSessionModel? _userProfile;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  UserSessionModel? get userProfile => _userProfile;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Profile data getters for easy access
  String get employeeName => _userProfile?.fullName ?? 'Hemant Rangarajan';
  String get employeeId => _userProfile?.employeeId ?? 'EMP00123';
  String get designation => _userProfile?.designation ?? 'Full-Stack Developer';
  String get department => _userProfile?.department ?? 'Software Development Team';
  String? get profileImage => _userProfile?.profileImage;
  String get email => _userProfile?.email ?? '';
  String get phone => _userProfile?.phone ?? '';

  // Constructor to initialize the view model
  ProfileViewModel() {
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Load user data from SharedPreferences
      final fullName = prefs.getString('fullName') ?? 'Hemant Rangarajan';
      final email = prefs.getString('email') ?? '';
      final phone = prefs.getString('phone') ?? '';
      
      // Create user session model with loaded data
      _userProfile = UserSessionModel(
        userId: '', // Will be set if available
        fullName: fullName,
        email: email,
        phone: phone,
        role: UserRole.employee,
        employeeId: 'EMP00123',
        department: 'Software Development Team',
        designation: 'Full-Stack Developer',
        authStatus: AuthStatus.authenticated,
        isActive: true,
      );
      
    } catch (e) {
      _errorMessage = 'Failed to load profile: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> startWork() async {
    // TODO: Implement start work functionality
    // This could include:
    // - Recording punch-in time
    // - Updating attendance status
    // - Sending notification to manager
    // - Updating work status in database
    
    try {
      _isLoading = true;
      notifyListeners();
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 1));
      
      // TODO: Add actual start work logic here
      // Example:
      // await AttendanceService.punchIn(userId);
      
    } catch (e) {
      _errorMessage = 'Failed to start work: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfile({
    String? fullName,
    String? email,
    String? phone,
    String? designation,
    String? department,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      // TODO: Implement profile update logic
      // This could include:
      // - Updating user data in database
      // - Updating SharedPreferences
      // - Validating input data
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 1));
      
      // Update local profile data
      if (_userProfile != null) {
        _userProfile = _userProfile!.copyWith(
          fullName: fullName ?? _userProfile!.fullName,
          email: email ?? _userProfile!.email,
          phone: phone ?? _userProfile!.phone,
          designation: designation ?? _userProfile!.designation,
          department: department ?? _userProfile!.department,
        );
      }
      
    } catch (e) {
      _errorMessage = 'Failed to update profile: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
} 