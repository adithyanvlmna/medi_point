import 'package:flutter/material.dart';

class TreatmentCard extends StatelessWidget {
  final String title;
  final int maleCount;
  final int femaleCount;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TreatmentCard({
    super.key,
    required this.title,
    required this.maleCount,
    required this.femaleCount,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(8),
      color: const Color.fromARGB(255, 238, 237, 237),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLabelValue("Male", maleCount),
                      const SizedBox(width: 30),
                      _buildLabelValue("Female", femaleCount),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.red),
                  onPressed: onDelete,
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.green),
                  onPressed: onEdit,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLabelValue(String label, int value) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w500,
            fontSize: 16
          ),
        ),
        const SizedBox(width: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            value.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
 
}
