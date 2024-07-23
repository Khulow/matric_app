import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matric_app/features/core/controllers/question_controller.dart';
import 'package:matric_app/features/core/model/question_model.dart';

class QuizProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final QuestionController _questionController = QuestionController();
  List<Map<String, dynamic>> questionPapers = [];
  List<Map<String, dynamic>> visibleQuestionPapers = [];
  List<String> recentlyOpenedPaperIds = [];

  String paperTitle = 'Unknown Paper Title';
  List<Question> questions = [];
  Map<String, String> selectedAnswers = {};
  bool isSubmitted = false;
  int score = 0;
  int currentQuestionIndex = 0;
  bool loading = false;
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  int _correctAnswersCount = 0;
  int get correctAnswersCount => _correctAnswersCount;

    List<Map<String, dynamic>> recentActivities = [];

  //List<RecentlyOpenedCard> recentlyOpenedCards = [];

  Future<void> fetchQuestionPapers() async {
    try {
      QuerySnapshot paperSnapshot =
          await _firestore.collection('questionsPapers').get();
      questionPapers = paperSnapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return {'id': doc.id, ...data};
      }).toList();
      visibleQuestionPapers =
          List.from(questionPapers); // Initialize visible papers
      notifyListeners();
    } catch (e) {
      print('Error fetching question papers: $e');
    }
  }

  Future<void> fetchQuizData(String paperId) async {
    try {
      loading = true;
      notifyListeners();

      DocumentSnapshot paperSnapshot =
          await _firestore.collection('questionsPapers').doc(paperId).get();
      if (paperSnapshot.exists && paperSnapshot.data() != null) {
        var data = paperSnapshot.data() as Map<String, dynamic>;
        paperTitle = data['title'] ?? 'Unknown Paper Title';
       var paper =
            questionPapers.firstWhere((paper) => paper['id'] == paperId);
        recentActivities.insert(0, paper);
        if (recentActivities.length > 1) {
          recentActivities =
              recentActivities.sublist(0, 1); // Keep only last 10 activities
        }
      } else {
        paperTitle = 'Unknown Paper Title';
      }

      questions = await _questionController.fetchQuestions(paperId);
      loading = false;
      notifyListeners();
    } catch (e) {
      print('Error fetching quiz data: $e');
      loading = false;
      notifyListeners();
    }
  }

  void selectAnswer(String questionId, String answerId) {
    selectedAnswers[questionId] = answerId;
    notifyListeners();
  }

  void submitQuiz() {
    isSubmitted = true;
    _correctAnswersCount = 0;

    for (var question in questions) {
      if (question.correctAnswer == selectedAnswers[question.id]) {
        _correctAnswersCount++;
      }
    }
    selectedAnswers.clear();
    notifyListeners();
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex > 0) {
      currentQuestionIndex--;
      notifyListeners();
    }
  }

  void updateVisiblePapers(Map<String, bool> selectedPapers) {
    visibleQuestionPapers = questionPapers
        .where((paper) => selectedPapers[paper['id']] == true)
        .toList();
    notifyListeners();
  }

  void addPaperToVisibleList(Map<String, dynamic> paper) {
    visibleQuestionPapers = List.from(visibleQuestionPapers)..add(paper);
    notifyListeners();
  }

  void removePaperFromVisibleList(Map<String, dynamic> paper) {
    visibleQuestionPapers = List.from(visibleQuestionPapers)..remove(paper);
    notifyListeners();
  }

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void resetQuiz() {
    selectedAnswers.clear();
    currentQuestionIndex = 0;
    isSubmitted = false;
    _correctAnswersCount = 0;
    notifyListeners();
  }

  /* void openQuestionPaper(String paperId) {
    // Remove the paperId if it's already in the list to avoid duplicates
    recentlyOpenedPaperIds.remove(paperId);
    // Add the paperId at the beginning of the list
    recentlyOpenedPaperIds.insert(0, paperId);
    // Optionally, limit the number of recent papers stored
    if (recentlyOpenedPaperIds.length > 2) {
      recentlyOpenedPaperIds.removeLast();
    }
    notifyListeners();
  }

  void removeRecentlyOpenedCard(String cardId) {
    recentlyOpenedCards.removeWhere((card) => card.id == cardId);
    notifyListeners();
  } */
}
