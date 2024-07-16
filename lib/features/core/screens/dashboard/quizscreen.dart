import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:matric_app/common_widgets/LottieProgressIndicator.dart';
import 'package:matric_app/common_widgets/circle_painter.dart';
import 'package:matric_app/features/core/Routes/routes.dart';
import 'package:matric_app/features/core/provider/quizprovider.dart';
import 'package:provider/provider.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {

  double _opacity = 0.0; 
   @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        _opacity = 1.0; // Step 3: Change opacity to 1.0 to start the animation
      });
    });
  }
  
  // Start fully visible
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF05192D),
        appBar: AppBar(
          title: const Text("Quiz"),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 250, 250, 250), // Dark blue
                Color.fromARGB(255, 231, 229, 229), // Slightly lighter blue
              ],
            ),
          ),
          child: CustomPaint(
            painter: BackgroundPainter(),
            child: Consumer<QuizProvider>(
              builder: (context, quizProvider, child) {
                if (quizProvider.loading) {
                  return Center(
                      child: Container(
                    padding: const EdgeInsets.all(
                        20), // Add padding around the animation
                    decoration: const BoxDecoration(
                      color: Colors.white, // Light background with some opacity
                      // Optional: adds rounded corners
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LottieProgressIndicator(
                          animationPath: 'assets/animations/loading.json',
                        ),
                        SizedBox(height: 10), // Space between animation and text
          Text(
            "Loading data...",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            )),
                      ],
                    ),
                  ));
                }

                if (quizProvider.questions.isEmpty) {
                  return const Center(child: Text("No questions available."));
                }

                int currentIndex = quizProvider.currentQuestionIndex;
                var currentQuestion = quizProvider.questions[currentIndex];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(
                                quizProvider.questions.length,
                                (index) => Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: index <= currentIndex
                                        ? Colors.blue
                                        : Colors.grey[300],
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                        color: index <= currentIndex
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            //column for question and answers options
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AnimatedOpacity(
                                    duration: const Duration(milliseconds: 500),
                                    opacity: _opacity, // Step 4: Use the opacity value
                                    child: Text(
                                      currentQuestion.question,
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Select the best answer from the options below:",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors
                                          .redAccent, // Choose a color that fits your app theme
                                      fontStyle: FontStyle
                                          /// Sets the text style of the selected widget to italic.
                                          /// This is an optional feature to differentiate the selected widget from the question.
                                          .italic, // Optional: Make it italic to differentiate from the question
                                    ),
                                  ),
                                  ...currentQuestion.answers.map((answer) {
                                    return AnimatedOpacity(
                                      duration: const Duration(milliseconds: 500),
                                      opacity: _opacity, // Step 4: Use the opacity value
                                      child: RadioListTile<String>(
                                        title: Text(
                                          answer.answer,
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        value: answer.identifier,
                                        groupValue: quizProvider
                                            .selectedAnswers[currentQuestion.id],
                                        onChanged: quizProvider.isSubmitted
                                            ? null
                                            : (value) {
                                                quizProvider.selectAnswer(
                                                    currentQuestion.id, value!);
                                              },
                                      ),
                                    );
                                  }).toList(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (currentIndex > 0)
                            ElevatedButton(
                              onPressed: () => quizProvider.previousQuestion(),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0,
                                  vertical: 12.0,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                              ),
                              child: const Text('Previous'),
                            ),
                          if (currentIndex < quizProvider.questions.length - 1)
                            ElevatedButton(
                              onPressed: () => quizProvider.nextQuestion(),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0,
                                  vertical: 12.0,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                              ),
                              child: const Text('Next'),
                            ),
                          if (currentIndex ==
                                  quizProvider.questions.length - 1 &&
                              !quizProvider.isSubmitted)
                            ElevatedButton(
                              onPressed: () {
                                quizProvider.submitQuiz();
                                Navigator.of(context).popAndPushNamed(
                                    RouteManager.quizResultPage);
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0,
                                  vertical: 12.0,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                              ),
                              child: const Text('Submit'),
                            ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ));
  }
}


