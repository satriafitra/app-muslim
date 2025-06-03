import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:muslim_app/view/page/jadwal_page.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),

          // Shimmer untuk Greeting Section
          Shimmer.fromColors(
            baseColor: const Color.fromARGB(92, 66, 66, 66)!,
            highlightColor: Colors.grey[600]!,
            child: Container(
              width: 150,
              height: 20,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Shimmer.fromColors(
            baseColor: const Color.fromARGB(102, 66, 66, 66)!,
            highlightColor: Colors.grey[600]!,
            child: Container(
              width: 200,
              height: 30,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),

          // Shimmer untuk Prayer Time Container
          Shimmer.fromColors(
            baseColor: const Color.fromARGB(97, 66, 66, 66)!,
            highlightColor: Colors.grey[600]!,
            child: Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
          const SizedBox(height: 40),

          // Shimmer untuk Read Quran Container
          Shimmer.fromColors(
            baseColor: const Color.fromARGB(93, 66, 66, 66)!,
            highlightColor: Colors.grey[600]!,
            child: Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
          const SizedBox(height: 40),

          // Shimmer untuk Prayer Time List
          for (int i = 0; i < 6; i++) ...[
            Shimmer.fromColors(
              baseColor: const Color.fromARGB(96, 66, 66, 66)!,
              highlightColor: Colors.grey[600]!,
              child: Container(
                height: 40,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
