import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  final String patientName;
  final String dateTime;
  final String status;
  final String? doctorComment;
  final String? responseTime;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;
  final VoidCallback? onWritePrescription;
  final VoidCallback? onTap;

  AppointmentCard({
    required this.patientName,
    required this.dateTime,
    required this.status,
    this.doctorComment,
    this.responseTime,
    this.onAccept,
    this.onReject,
    this.onWritePrescription,
    this.onTap,
  });

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'accepted':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.teal.shade100,
              blurRadius: 8,
              offset: Offset(2, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    patientName,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade900,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: getStatusColor(status).withOpacity(0.15),
                      border: Border.all(color: getStatusColor(status)),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Text(
                      status.toUpperCase(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: getStatusColor(status),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Time Info Boxes
              Row(
                children: [
                  _buildInfoBox(
                    icon: Icons.access_time,
                    label: 'Appointment',
                    value: dateTime,
                    color: Colors.teal.shade100,
                  ),
                  if (responseTime != null && responseTime!.isNotEmpty)
                    SizedBox(width: 12),
                  if (responseTime != null && responseTime!.isNotEmpty)
                    _buildInfoBox(
                      icon: Icons.schedule,
                      label: 'Responded',
                      value: responseTime!,
                      color: Colors.orange.shade100,
                    ),
                ],
              ),
              SizedBox(height: 12),

              // Comment
              if (doctorComment != null && doctorComment!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    '💬 Comment: $doctorComment',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
                  ),
                ),

              // Action Buttons
              if (status == 'pending' || status == 'accepted') ...[
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (status == 'pending') ...[
                      _buildActionButton(
                        icon: Icons.check,
                        color: Colors.green,
                        onPressed: onAccept,
                      ),
                      SizedBox(width: 12),
                      _buildActionButton(
                        icon: Icons.close,
                        color: Colors.red,
                        onPressed: onReject,
                      ),
                    ],
                    if (status == 'accepted')
                      _buildActionButton(
                        icon: Icons.medical_services,
                        color: Colors.blue,
                        onPressed: onWritePrescription,
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    VoidCallback? onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
          border: Border.all(color: color),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }

  Widget _buildInfoBox({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: 4),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: Colors.teal.shade900),
            SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade900,
                    ),
                  ),
                  Text(
                    value,
                    style: TextStyle(fontSize: 13, color: Colors.teal.shade800),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
