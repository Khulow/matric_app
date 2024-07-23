import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matric_app/common_widgets/quiz_content_instruction.dart';
import 'package:matric_app/common_widgets/circle_painter.dart';
import 'package:matric_app/features/core/Routes/routes.dart';
import 'package:matric_app/features/core/provider/quizprovider.dart';
import 'package:matric_app/features/core/screens/dashboard/quiz_instruction_screen.dart';
import 'package:matric_app/services/navigation_service.dart';
import 'package:matric_app/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();

    // Fetch question papers when the widget is first created
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    if (quizProvider.questionPapers.isEmpty) {
      quizProvider.fetchQuestionPapers();
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserService>(context);
    final username = authProvider.currentUser?.displayName ?? 'Guest';

    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 188, 75, 0.1),
      body: SafeArea(
        child: CustomPaint(
          painter: BackgroundPainter(),
          child: Consumer<QuizProvider>(
            builder: (context, quizProvider, child) {
              if (quizProvider.loading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (quizProvider.questionPapers.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Container(
                            padding:
                                const EdgeInsets.all(2), // Adjust padding size
                            decoration: BoxDecoration(
                              color: Colors.white, // Color for the border
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 20, // Adjust the size as needed
                              backgroundImage: AssetImage(
                                'assets/images/welcome_image.png', // Placeholder image URL
                              ),
                            ),
                          ),
                          const SizedBox(
                              width:
                                  10), // Space between the image and the text
                          Text(
                            'Hi, $username',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 16.0),
                      child: Text(
                        'what do you want to learn?',
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Popular Subjects',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              navigatorKey.currentState
                                  ?.pushNamed(RouteManager.quizListPage);
                            },
                            child: const Text(' All Subjects',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    decoration: TextDecoration.underline)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height:
                        250, // Set a fixed height for the horizontal list view
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: quizProvider.questionPapers.length,
                        itemBuilder: (context, index) {
                          var paper = quizProvider.questionPapers[index];
                          return Container(
                            
                            width: 160, // Set width for each card
                            child: Card(
                              
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              color: Colors.white,
                              //color: Colors.black12,
                              margin: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          QuizInstructionScreen(
                                              paperId: paper['id']),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (paper['image_url'] != null &&
                                          paper['image_url'].isNotEmpty)
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white
                                                , // Background color for the container
                                            borderRadius: BorderRadius.circular(
                                                10), // Rounded corners
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                                offset: const Offset(0,
                                                    3), // Changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: SvgPicture.asset(
                                            paper['image_url'],
                                            height:
                                                80, // Reduced height for the image
                                            width: 80,
                                            placeholderBuilder: (context) =>
                                                const CircularProgressIndicator(),
                                          ),
                                        ),
                                      const SizedBox(height: 10),
                                      Text(
                                        paper['title'] ?? 'Unknown Title',
                                        style: const TextStyle(
                                          color: Color.fromARGB(226, 0, 0, 0),
                                          fontSize: 14,
                                        ), // Reduced font size
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        paper['description'] ??
                                            'No description available',
                                        style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 14), // Reduced font size
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Questions: ${paper['questions_count'] ?? 0}',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors
                                                .black), // Reduced font size
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recent Activity',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: quizProvider.recentActivities.isNotEmpty ? Column(
                        children: quizProvider.recentActivities.map((paper) {
                          return Card(
                            margin: const EdgeInsets.all(10.0),
                            child: Container(
                              decoration :BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                
                                
                                gradient: const LinearGradient(
                                  colors: [
                                    Colors.amberAccent,
                                    Colors.white,
                                  ],
                                ),
                              ),
                              height: 280,
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      if (paper['image_url'] != null &&
                                          paper['image_url'].isNotEmpty)
                                        SvgPicture.asset(
                                          paper['image_url'],
                                          height: 150,
                                          width: 100,
                                          placeholderBuilder: (context) =>
                                              const CircularProgressIndicator(),
                                        ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            paper['title'] ?? 'Unknown Title',
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            paper['description'] ??
                                                'No description available',
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              QuizInstructionScreen(
                                                  paperId: paper['id']),
                                        ),
                                      );
                                    },
                                    child: const Text('Continue'),
                                  ),
                                  
                                ],
                                
                              ),
                            ),
                          );
                        }).toList(), // Convert Iterable<Card> to List<Widget>
                      ): Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: const Center(
                                child: Text(
                                  'You will see your recent activity here.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                    ),

                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
