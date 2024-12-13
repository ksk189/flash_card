import 'package:flutter/material.dart';
import '../models/flashcard_model.dart';

class FlashcardCard extends StatelessWidget {
  final Flashcard flashcard;
  final int index;
  final bool isExpanded; // To indicate if the card is expanded
  final VoidCallback onToggle; // Callback for toggling
  final VoidCallback onEdit;
  final VoidCallback onDelete;

   FlashcardCard({
    super.key,
    required this.flashcard,
    required this.index,
    required this.isExpanded,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  // List of gradients for different cards
  final List<List<Color>> gradients = [
    [Colors.blueAccent, Colors.deepPurple],
    [Colors.greenAccent, Colors.teal],
    [Colors.orangeAccent, Colors.redAccent],
    [Colors.pinkAccent, Colors.deepOrange],
    [Colors.cyanAccent, Colors.indigo],
    [Colors.yellowAccent, Colors.amber],
  ];

  @override
  Widget build(BuildContext context) {
    // Cycle through the gradient list using the index
    final gradientColors = gradients[index % gradients.length];

    return GestureDetector(
      onTap: onToggle, // Toggle the card on tap
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                flashcard.question,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
              if (isExpanded)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    flashcard.answer,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                      height: 1.4,
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white),
                    onPressed: onEdit,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.white),
                    onPressed: onDelete,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}