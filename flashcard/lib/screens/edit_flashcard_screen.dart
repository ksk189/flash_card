import 'package:flutter/material.dart';
import '../models/flashcard_model.dart';

class EditFlashcardScreen extends StatelessWidget {
  final Flashcard flashcard;
  final Function(Flashcard) onSave;

  EditFlashcardScreen({required this.flashcard, required this.onSave});

  final TextEditingController questionController = TextEditingController();
  final TextEditingController answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    questionController.text = flashcard.question;
    answerController.text = flashcard.answer;

    return Scaffold(
      appBar: AppBar(title: Text("Edit Flashcard")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: questionController,
              decoration: InputDecoration(labelText: "Question"),
            ),
            TextField(
              controller: answerController,
              decoration: InputDecoration(labelText: "Answer"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (questionController.text.isNotEmpty &&
                    answerController.text.isNotEmpty) {
                  onSave(
                    Flashcard(
                      question: questionController.text,
                      answer: answerController.text,
                    ),
                  );
                  Navigator.of(context).pop();
                }
              },
              child: Text("Update Flashcard"),
            ),
          ],
        ),
      ),
    );
  }
}