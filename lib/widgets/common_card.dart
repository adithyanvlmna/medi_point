import 'package:flutter/material.dart';



class CommonCardWidget extends StatelessWidget {
  final int index;
  final String name;
  final String package;
  final String date;
  final String staffName;
  final VoidCallback onViewDetailsTap;

  const CommonCardWidget({
    super.key,
    required this.index,
    required this.name,
    required this.package,
    required this.date,
    required this.staffName,
    required this.onViewDetailsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: const Color.fromARGB(255, 238, 237, 237),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            Text(
              '$index. $name',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 4),

           
            Text(
              package,
              style: const TextStyle(
                color: Colors.green,
                fontSize: 16,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 8),

            
            Row(
              children: [
                const Icon(Icons.calendar_month, color: Colors.red, size: 18),
                const SizedBox(width: 4),
                Text(date),
                const SizedBox(width: 16),
                const Icon(Icons.people, color: Colors.red, size: 18),
                const SizedBox(width: 4),
                Text(staffName),
              ],
            ),

            const Divider(height: 20),

            
            InkWell(
              onTap: onViewDetailsTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "View Booking details",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
