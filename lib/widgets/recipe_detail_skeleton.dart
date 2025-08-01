import 'package:flutter/material.dart';

class RecipeDetailSkeleton extends StatelessWidget {
  const RecipeDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero image skeleton
                     Container(
             width: double.infinity,
             height: 300,
             color: Theme.of(context).colorScheme.surfaceVariant,
            child: const Center(
              child: SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                ),
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title skeleton
                                 Container(
                   height: 32,
                   width: double.infinity,
                   decoration: BoxDecoration(
                     color: Theme.of(context).colorScheme.surfaceVariant,
                     borderRadius: BorderRadius.circular(4),
                   ),
                 ),
                
                const SizedBox(height: 16),
                
                // Category chips skeleton
                Row(
                  children: [
                                         Container(
                       height: 32,
                       width: 80,
                       decoration: BoxDecoration(
                         color: Theme.of(context).colorScheme.surfaceVariant,
                         borderRadius: BorderRadius.circular(16),
                       ),
                     ),
                    const SizedBox(width: 8),
                                         Container(
                       height: 32,
                       width: 60,
                       decoration: BoxDecoration(
                         color: Theme.of(context).colorScheme.surfaceVariant,
                         borderRadius: BorderRadius.circular(16),
                       ),
                     ),
                  ],
                ),
                
                const SizedBox(height: 32),
                
                // Ingredients section skeleton
                                 Container(
                   height: 24,
                   width: 120,
                   decoration: BoxDecoration(
                     color: Theme.of(context).colorScheme.surfaceVariant,
                     borderRadius: BorderRadius.circular(4),
                   ),
                 ),
                const SizedBox(height: 16),
                
                // Ingredients list skeleton
                ...List.generate(6, (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                                             Container(
                         width: 8,
                         height: 8,
                         margin: const EdgeInsets.only(right: 12),
                         decoration: BoxDecoration(
                           color: Theme.of(context).colorScheme.surfaceVariant,
                           shape: BoxShape.circle,
                         ),
                       ),
                      Expanded(
                                                 child: Container(
                           height: 16,
                           decoration: BoxDecoration(
                             color: Theme.of(context).colorScheme.surfaceVariant,
                             borderRadius: BorderRadius.circular(4),
                           ),
                         ),
                      ),
                    ],
                  ),
                )),
                
                const SizedBox(height: 32),
                
                // Instructions section skeleton
                                 Container(
                   height: 24,
                   width: 100,
                   decoration: BoxDecoration(
                     color: Theme.of(context).colorScheme.surfaceVariant,
                     borderRadius: BorderRadius.circular(4),
                   ),
                 ),
                const SizedBox(height: 16),
                
                // Instructions text skeleton
                ...List.generate(8, (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                                     child: Container(
                     height: 16,
                     width: double.infinity,
                     decoration: BoxDecoration(
                       color: Theme.of(context).colorScheme.surfaceVariant,
                       borderRadius: BorderRadius.circular(4),
                     ),
                   ),
                )),
                
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 