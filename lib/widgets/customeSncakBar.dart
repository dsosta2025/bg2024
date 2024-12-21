import 'package:flutter/material.dart';

class CustomSnackbarr {
  static bool _isSnackbarShowing = false;

  // Show Snackbar with debounce functionality
  static void show(
      BuildContext context,
      String title,
      String message, {
        bool isError = false,
      }) {
    // If a snackbar is already showing, don't show another
    if (_isSnackbarShowing) return;

    _isSnackbarShowing = true;

    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            isError ? Icons.error_outline : Icons.check_circle_outline,
            color: isError ? Colors.redAccent : Colors.green,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isError ? Colors.redAccent : Colors.green,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black87,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      duration: const Duration(seconds: 3),
    );

    // Show the snackbar
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    // Set a delay before allowing another snackbar to show
    Future.delayed(snackBar.duration!, () {
      _isSnackbarShowing = false;
    });
  }
}
