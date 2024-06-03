class Question {
  final String id;
  final String question;
  final String correctAnswer;
  final String imageUrl; // Added imageUrl field
  final List<Answer> answers;

  Question({
    required this.id,
    required this.question,
    required this.correctAnswer,
    required this.imageUrl,
    required this.answers,
  });

 factory Question.fromFirestore(Map<String, dynamic> data, String id) {
    return Question(
      id: id,
      question: data['question'] ?? '',
      correctAnswer: data['correct_answer'] ?? '',
      imageUrl: data['image_url'] ?? '',
      answers: [], // Initialize with an empty list
    );
  }

}

class Answer {
  final String identifier;
  final String answer;

  Answer({
    required this.identifier,
    required this.answer,
  });

  factory Answer.fromFirestore(Map<String, dynamic> data) {
    return Answer(
      identifier: data['identifier'] ?? '',
      answer: data['answer'] ?? '',
    );
  }
}
