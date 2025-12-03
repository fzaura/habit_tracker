import 'package:intl/intl.dart';

class DateFormatter {
  // Basic date formats
  static String formatDateTime(
    DateTime date, {
    String pattern = 'MMM dd, yyyy',
  }) {
    return DateFormat(pattern).format(date);
  }

  static String formatTime(DateTime date, {String pattern = 'hh:mm a'}) {
    return DateFormat(pattern).format(date);
  }

  // Common preset formats
  static String fullDate(DateTime date) =>
      formatDateTime(date, pattern: 'EEEE, MMMM d, yyyy');
  static String shortDate(DateTime date) =>
      formatDateTime(date, pattern: 'MM/dd/yy');
  static String monthDay(DateTime date) =>
      formatDateTime(date, pattern: 'MMMM d');

  // Relative time formats
  static String todayYesterday(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final input = DateTime(date.year, date.month, date.day);

    if (input == today) return 'Today';
    if (input == today.subtract(const Duration(days: 1))) return 'Yesterday';

    return formatDateTime(date, pattern: 'MMM dd');
  }

  static String timeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) return 'Just now';
    if (difference.inMinutes < 60) return '${difference.inMinutes}m ago';
    if (difference.inHours < 24) return '${difference.inHours}h ago';
    if (difference.inDays < 7) return '${difference.inDays}d ago';

    return formatDateTime(date, pattern: 'MMM dd');
  }

  // Habit-specific formats
  static String habitLastCompleted(DateTime date) {
    return 'Last: ${todayYesterday(date)}';
  }

  static String streakDateRange(DateTime start, DateTime end) {
    return '${formatDateTime(start, pattern: 'MMM dd')} - ${formatDateTime(end, pattern: 'MMM dd')}';
  }
}
