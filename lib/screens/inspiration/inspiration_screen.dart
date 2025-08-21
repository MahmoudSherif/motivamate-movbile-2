import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/historical_figure.dart';

class InspirationScreen extends StatefulWidget {
  const InspirationScreen({super.key});

  @override
  State<InspirationScreen> createState() => _InspirationScreenState();
}

class _InspirationScreenState extends State<InspirationScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<HistoricalFigure> _figures = [
    HistoricalFigure(
      name: 'Nelson Mandela',
      title: 'Anti-Apartheid Revolutionary & Former President of South Africa',
      achievement: 'Led the fight against apartheid and became the first Black president of South Africa',
      quote: 'The greatest glory in living lies not in never falling, but in rising every time we fall.',
      description: 'Nelson Mandela spent 27 years in prison for his fight against apartheid. After his release, he led South Africa\'s transition to democracy and became its first Black president. He is known for his commitment to reconciliation and peace.',
      keyLessons: [
        'Perseverance in the face of adversity',
        'The power of forgiveness and reconciliation',
        'Leading by example',
        'Never giving up on your principles',
      ],
      imageUrl: 'https://via.placeholder.com/300x300?text=Nelson+Mandela',
      birthYear: 1918,
      deathYear: 2013,
      nationality: 'South African',
    ),
    HistoricalFigure(
      name: 'Marie Curie',
      title: 'Physicist and Chemist',
      achievement: 'First woman to win a Nobel Prize and first person to win Nobel Prizes in two different sciences',
      quote: 'Life is not easy for any of us. But what of that? We must have perseverance and above all confidence in ourselves.',
      description: 'Marie Curie was a pioneering scientist who conducted groundbreaking research on radioactivity. She was the first woman to win a Nobel Prize and remains the only person to win Nobel Prizes in two different scientific fields.',
      keyLessons: [
        'Breaking barriers in male-dominated fields',
        'The importance of scientific curiosity',
        'Dedication to knowledge and discovery',
        'Perseverance despite discrimination',
      ],
      imageUrl: 'https://via.placeholder.com/300x300?text=Marie+Curie',
      birthYear: 1867,
      deathYear: 1934,
      nationality: 'Polish-French',
    ),
    HistoricalFigure(
      name: 'Mahatma Gandhi',
      title: 'Leader of Indian Independence Movement',
      achievement: 'Led India to independence through non-violent civil disobedience',
      quote: 'Be the change that you wish to see in the world.',
      description: 'Mahatma Gandhi led India\'s struggle for independence from British rule through non-violent resistance. His philosophy of peaceful protest inspired civil rights movements around the world.',
      keyLessons: [
        'The power of non-violent resistance',
        'Leading through moral authority',
        'Simplicity and self-discipline',
        'Fighting injustice through peaceful means',
      ],
      imageUrl: 'https://via.placeholder.com/300x300?text=Mahatma+Gandhi',
      birthYear: 1869,
      deathYear: 1948,
      nationality: 'Indian',
    ),
    HistoricalFigure(
      name: 'Albert Einstein',
      title: 'Theoretical Physicist',
      achievement: 'Developed the theory of relativity and won Nobel Prize in Physics',
      quote: 'Imagination is more important than knowledge. Knowledge is limited, but imagination embraces the entire world.',
      description: 'Albert Einstein revolutionized physics with his theories of special and general relativity. His work laid the foundation for modern physics and our understanding of space, time, and gravity.',
      keyLessons: [
        'The power of curiosity and questioning',
        'Thinking outside conventional boundaries',
        'Persistence in solving complex problems',
        'The importance of imagination in discovery',
      ],
      imageUrl: 'https://via.placeholder.com/300x300?text=Albert+Einstein',
      birthYear: 1879,
      deathYear: 1955,
      nationality: 'German-American',
    ),
    HistoricalFigure(
      name: 'Martin Luther King Jr.',
      title: 'Civil Rights Leader',
      achievement: 'Led the American civil rights movement and received Nobel Peace Prize',
      quote: 'Darkness cannot drive out darkness; only light can do that. Hate cannot drive out hate; only love can do that.',
      description: 'Martin Luther King Jr. was a leader in the American civil rights movement. He advocated for racial equality through non-violent protest and delivered the famous "I Have a Dream" speech.',
      keyLessons: [
        'Fighting for justice through peaceful means',
        'The power of inspiring speech and vision',
        'Standing up for what is right',
        'Building bridges between communities',
      ],
      imageUrl: 'https://via.placeholder.com/300x300?text=MLK+Jr',
      birthYear: 1929,
      deathYear: 1968,
      nationality: 'American',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Inspiration'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Header
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.cardBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.glassBorder),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.auto_stories,
                  size: 48,
                  color: AppTheme.primaryTeal,
                ),
                const SizedBox(height: 12),
                Text(
                  'Learn from History\'s Greatest',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Discover inspiring stories of people who changed the world',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Figure Cards
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: _figures.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildFigureCard(_figures[index]),
                );
              },
            ),
          ),

          // Page Indicator
          Container(
            margin: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _figures.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: index == _currentIndex
                        ? AppTheme.primaryTeal
                        : Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFigureCard(HistoricalFigure figure) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.glassBorder),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Image
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppTheme.primaryTeal.withOpacity(0.2),
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.primaryTeal, width: 2),
              ),
              child: const Icon(
                Icons.person,
                size: 60,
                color: AppTheme.primaryTeal,
              ),
            ),
            const SizedBox(height: 16),

            // Name and Title
            Text(
              figure.name,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              figure.title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.primaryTeal,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              '${figure.birthYear} - ${figure.deathYear ?? "Present"} • ${figure.nationality}',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Quote
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.primaryTeal.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.format_quote,
                    color: AppTheme.primaryTeal,
                    size: 24,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    figure.quote,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Achievement
            _buildSection(
              'Major Achievement',
              figure.achievement,
              Icons.emoji_events,
            ),
            const SizedBox(height: 16),

            // Description
            _buildSection(
              'Story',
              figure.description,
              Icons.auto_stories,
            ),
            const SizedBox(height: 16),

            // Key Lessons
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.lightbulb,
                        color: AppTheme.warmOrange,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Key Lessons',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontSize: 16,
                          color: AppTheme.warmOrange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...figure.keyLessons.map((lesson) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '• ',
                              style: TextStyle(
                                color: AppTheme.primaryTeal,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                lesson,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: AppTheme.primaryTeal,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontSize: 16,
                  color: AppTheme.primaryTeal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}