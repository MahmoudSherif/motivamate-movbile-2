import 'package:flutter/material.dart';
import 'dart:async';
import '../../theme/app_theme.dart';

class AchieveScreen extends StatefulWidget {
  const AchieveScreen({super.key});

  @override
  State<AchieveScreen> createState() => _AchieveScreenState();
}

class _AchieveScreenState extends State<AchieveScreen>
    with TickerProviderStateMixin {
  Timer? _timer;
  int _seconds = 0;
  int _minutes = 25; // Default Pomodoro time
  bool _isRunning = false;
  bool _isPaused = false;
  
  late AnimationController _progressController;
  late AnimationController _pulseController;
  
  final List<int> _presetTimes = [15, 25, 45, 60]; // in minutes

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: Duration(minutes: _minutes),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _progressController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Achieve'),
        actions: [
          IconButton(
            icon: const Icon(Icons.emoji_events),
            onPressed: _showGoalsDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Focus Timer Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.cardBackground,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.glassBorder),
              ),
              child: Column(
                children: [
                  Text(
                    'Focus Timer',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 24),
                  
                  // Circular Timer
                  AnimatedBuilder(
                    animation: _progressController,
                    builder: (context, child) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                            height: 200,
                            child: AnimatedBuilder(
                              animation: _pulseController,
                              builder: (context, child) {
                                return Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: _isRunning
                                        ? [
                                            BoxShadow(
                                              color: AppTheme.primaryTeal.withOpacity(
                                                  0.3 * _pulseController.value),
                                              blurRadius: 20 + (10 * _pulseController.value),
                                              spreadRadius: 5 + (5 * _pulseController.value),
                                            ),
                                          ]
                                        : [],
                                  ),
                                  child: CircularProgressIndicator(
                                    value: _progressController.value,
                                    strokeWidth: 8,
                                    backgroundColor: Colors.white.withOpacity(0.2),
                                    valueColor: const AlwaysStoppedAnimation<Color>(
                                        AppTheme.primaryTeal),
                                  ),
                                );
                              },
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _formatTime(),
                                style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                _isRunning
                                    ? (_isPaused ? 'Paused' : 'Focusing')
                                    : 'Ready to focus',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                  
                  // Timer Controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: _isRunning ? null : _decreaseTime,
                        icon: const Icon(Icons.remove),
                        iconSize: 32,
                        color: Colors.white70,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: _isRunning
                              ? (_isPaused ? AppTheme.primaryTeal : Colors.red)
                              : AppTheme.primaryTeal,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: _toggleTimer,
                          icon: Icon(
                            _isRunning
                                ? (_isPaused ? Icons.play_arrow : Icons.pause)
                                : Icons.play_arrow,
                          ),
                          iconSize: 32,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: _isRunning ? _stopTimer : _increaseTime,
                        icon: Icon(_isRunning ? Icons.stop : Icons.add),
                        iconSize: 32,
                        color: _isRunning ? Colors.red : Colors.white70,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Preset Times
                  if (!_isRunning) ...[
                    const Text(
                      'Quick Start',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: _presetTimes.map((time) {
                        return OutlinedButton(
                          onPressed: () => _setPresetTime(time),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: _minutes == time
                                  ? AppTheme.primaryTeal
                                  : Colors.white38,
                            ),
                          ),
                          child: Text('${time}m'),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Quick Goals Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.cardBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.glassBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Today\'s Goals',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      IconButton(
                        onPressed: _showAddGoalDialog,
                        icon: const Icon(Icons.add, color: AppTheme.primaryTeal),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildGoalsList(),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Quick Stats Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.cardBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.glassBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today\'s Progress',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatItem('Focus Sessions', '0', Icons.timer),
                      ),
                      Expanded(
                        child: _buildStatItem('Time Focused', '0m', Icons.access_time),
                      ),
                      Expanded(
                        child: _buildStatItem('Goals Met', '0/0', Icons.emoji_events),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalsList() {
    // Mock goals for demonstration
    final mockGoals = [
      {'title': 'Complete 3 focus sessions', 'progress': 0.33, 'completed': false},
      {'title': 'Read for 30 minutes', 'progress': 0.0, 'completed': false},
      {'title': 'Review notes', 'progress': 1.0, 'completed': true},
    ];

    if (mockGoals.isEmpty) {
      return const Center(
        child: Text(
          'No goals set for today.\nTap + to add your first goal!',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Column(
      children: mockGoals.map((goal) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: goal['completed'] as bool ? Colors.green : AppTheme.primaryTeal,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    goal['completed'] as bool ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: goal['completed'] as bool ? Colors.green : Colors.white70,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      goal['title'] as String,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        decoration: goal['completed'] as bool
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
              if (!(goal['completed'] as bool)) ...[
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: goal['progress'] as double,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryTeal),
                ),
              ],
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppTheme.primaryTeal, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  String _formatTime() {
    final totalSeconds = (_minutes * 60) - ((_progressController.value * _minutes * 60).round());
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _toggleTimer() {
    if (_isRunning) {
      if (_isPaused) {
        _resumeTimer();
      } else {
        _pauseTimer();
      }
    } else {
      _startTimer();
    }
  }

  void _startTimer() {
    setState(() {
      _isRunning = true;
      _isPaused = false;
    });

    _progressController.duration = Duration(minutes: _minutes);
    _progressController.forward();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });

      if (_progressController.isCompleted) {
        _completeTimer();
      }
    });
  }

  void _pauseTimer() {
    setState(() {
      _isPaused = true;
    });
    _timer?.cancel();
    _progressController.stop();
  }

  void _resumeTimer() {
    setState(() {
      _isPaused = false;
    });
    _progressController.forward();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });

      if (_progressController.isCompleted) {
        _completeTimer();
      }
    });
  }

  void _stopTimer() {
    setState(() {
      _isRunning = false;
      _isPaused = false;
      _seconds = 0;
    });
    _timer?.cancel();
    _progressController.reset();
  }

  void _completeTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _isPaused = false;
      _seconds = 0;
    });
    _progressController.reset();

    // Show completion dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppTheme.cardBackground,
          title: const Text('🎉 Session Complete!', style: TextStyle(color: Colors.white)),
          content: Text(
            'Great job! You focused for $_minutes minutes.',
            style: const TextStyle(color: Colors.white70),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Nice!'),
            ),
          ],
        );
      },
    );
  }

  void _increaseTime() {
    if (_minutes < 90) {
      setState(() {
        _minutes += 5;
      });
    }
  }

  void _decreaseTime() {
    if (_minutes > 5) {
      setState(() {
        _minutes -= 5;
      });
    }
  }

  void _setPresetTime(int minutes) {
    setState(() {
      _minutes = minutes;
    });
  }

  void _showGoalsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppTheme.cardBackground,
          title: const Text('Goals Management', style: TextStyle(color: Colors.white)),
          content: const Text(
            'Goals management feature coming soon!\nSet and track your personal achievement goals.',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showAddGoalDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppTheme.cardBackground,
          title: const Text('Add Goal', style: TextStyle(color: Colors.white)),
          content: const Text(
            'Goal creation feature coming soon!',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}