import 'package:flutter/material.dart';
import '../components/MainAppBar.dart';

class HomeScreen extends StatefulWidget {
  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onReset;

  const HomeScreen({
    super.key,
    required this.count,
    required this.onIncrement,
    required this.onReset,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isDrawerOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
      _isDrawerOpen ? _controller.forward() : _controller.reverse();
    });
  }

  // Helper function to determine text color based on count
  Color _getColorForCount(int count) {
    if (count < 5) return Colors.white;
    if (count < 11) return const Color.fromARGB(255, 228, 211, 53);
    if (count < 16) return Colors.orange;
    if (count < 21) return Colors.red;
    return const Color.fromARGB(255, 168, 23, 12);
  }

  @override
  Widget build(BuildContext context) {
    final Color textColor = _getColorForCount(widget.count);

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          // Right swipe
          if (!_isDrawerOpen) _toggleDrawer();
        } else if (details.primaryVelocity! < 0) {
          // Left swipe
          if (_isDrawerOpen) _toggleDrawer();
        }
      },
      child: Scaffold(
        appBar: const MainAppBar(),
        body: Stack(
          children: [
            // Background image
            Image.network(
              'https://i.pinimg.com/736x/c3/ec/ea/c3ecea947eb57e80ba317d2b917d762c.jpg',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            // Main content column
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Dr Brand',
                    style: TextStyle(
                      fontSize: 44,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Subtitle
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Astronaut',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Counter display
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    '${widget.count}',
                    style: TextStyle(
                      fontSize: 60,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Reset button - only shown when count > 0
                if (widget.count > 0)
                  TextButton(
                    onPressed: widget.onReset,
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        fontSize: 20,
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.solid,
                        decorationThickness: 1.5,
                        decorationColor: textColor,
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                // Add a button somewhere in your HomeScreen that navigates to the new route
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/flutter-quill');
                  },
                  child: Text('Open Flutter Quill Editor'),
                ),
              ],
            ),
            // Semi-transparent overlay when drawer is open
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Visibility(
                  visible: _controller.value > 0,
                  child: GestureDetector(
                    onTap: _toggleDrawer,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.black87,
                    ),
                  ),
                );
              },
            ),
            // Sliding drawer - now at the highest z-index
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(
                      -MediaQuery.of(context).size.width *
                          1 *
                          (1 - _controller.value),
                      0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: double.infinity,
                    color: Colors.black87,
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.list, color: Colors.white),
                          title: const Text('Form page',
                              style: TextStyle(color: Colors.white)),
                          onTap: () {
                            Navigator.pushNamed(context, '/page2');
                          },
                        ),
                        // const SizedBox(height: 60),
                        ListTile(
                          leading:
                              const Icon(Icons.settings, color: Colors.white),
                          title: const Text('Settings',
                              style: TextStyle(color: Colors.white)),
                          onTap: () {
                            Navigator.pushNamed(context, '/page3');
                            // Handle navigation
                          },
                        ),
                        // Add more ListTiles as needed
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        backgroundColor: Colors.blueGrey[50],
        // Increment button
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 15, 19, 20),
          onPressed: widget.onIncrement,
          child: const Icon(
            Icons.rocket,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}
