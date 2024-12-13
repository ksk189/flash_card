import 'package:flashcard/widgets/flash_card.dart';
import 'package:flutter/material.dart';
import '../models/flashcard_model.dart';
import 'add_flashcard_screen.dart';
import 'edit_flashcard_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Flashcard> flashcards = [];
  int? expandedCardIndex; // Track the currently expanded card index

  void addFlashcard(Flashcard flashcard) {
    setState(() {
      flashcards.insert(0, flashcard); // Add the new flashcard at the top
    });
  }

  void editFlashcard(int index, Flashcard updatedFlashcard) {
    setState(() {
      flashcards[index] = updatedFlashcard;
    });
  }

  void deleteFlashcard(int index) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                color: Colors.red,
                size: 50,
              ),
              const SizedBox(height: 16),
              const Text(
                "Delete Flashcard",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Are you sure you want to delete this flashcard? This action cannot be undone.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Cancel Button
                  ElevatedButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 24,
                      ),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Delete Button
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        flashcards.removeAt(index);
                      });
                      Navigator.of(ctx).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 24,
                      ),
                    ),
                    child: const Text(
                      "Delete",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void toggleCard(int index) {
    setState(() {
      // If the same card is clicked again, collapse it
      if (expandedCardIndex == index) {
        expandedCardIndex = null;
      } else {
        expandedCardIndex = index; // Expand the newly clicked card
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main Content
          Container(
            color: Colors.white, // White background
            padding: const EdgeInsets.only(top: 80), // Padding to make space for the title
            child: flashcards.isEmpty
                ? Center(
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      color: const Color(0xFFEEF7FF), // Light blue card
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 32.0,
                          horizontal: 16.0,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.library_books,
                              size: 50,
                              color: Colors.blue,
                            ),
                            SizedBox(height: 16),
                            Text(
                              "No Flashcards Added Yet",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Tap the '+' button below to add your first flashcard!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: flashcards.length,
                    itemBuilder: (ctx, index) {
                      return FlashcardCard(
                        flashcard: flashcards[index],
                        index: index,
                        isExpanded: expandedCardIndex == index, // Check if this card is expanded
                        onToggle: () => toggleCard(index), // Pass the toggle function
                        onEdit: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => EditFlashcardScreen(
                                flashcard: flashcards[index],
                                onSave: (updatedFlashcard) {
                                  editFlashcard(index, updatedFlashcard);
                                },
                              ),
                            ),
                          );
                        },
                        onDelete: () => deleteFlashcard(index),
                      );
                    },
                  ),
          ),

          // Title
          Positioned(
            top: 30, // Offset of 30 from the top
            left: 16, // Positioned to the left
            child: const Text(
              "Flashcards",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue, // Floating button in blue
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AddFlashcardScreen(onSave: addFlashcard),
            ),
          );
        },
      ),
    );
  }
}