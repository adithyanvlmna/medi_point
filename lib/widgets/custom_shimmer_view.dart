import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class DashBoardShimmer extends StatelessWidget {
  const DashBoardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Shimmer(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Shimmer(
                  child: Container(
                    height: 50,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  const Text("Sort by : ", style: TextStyle(fontSize: 16)),
                 Spacer(),
                  Shimmer(
                    child: Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.separated(
                itemCount: 4,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  return Shimmer(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 15,
                            width: 100,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 8),
                          Container(height: 12, width: 80, color: Colors.white),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(Icons.calendar_month, color: Colors.white),
                              const SizedBox(width: 6),
                              Container(
                                height: 10,
                                width: 80,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 16),
                              Icon(Icons.group, color: Colors.white),
                              const SizedBox(width: 6),
                              Container(
                                height: 10,
                                width: 80,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 14,
                                width: 120,
                                color: Colors.white,
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // const SizedBox(height: 10),
            // Shimmer(
            //   child: Container(
            //     height: 55,
            //     width: double.infinity,
            //     decoration: BoxDecoration(
            //       color: Colors.grey.shade300,
            //       borderRadius: BorderRadius.circular(14),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
