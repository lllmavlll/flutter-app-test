import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';

class FlutterQuillScreen extends StatefulWidget {
  const FlutterQuillScreen({super.key});

  @override
  State<FlutterQuillScreen> createState() => _FlutterQuillScreenState();
}

class _FlutterQuillScreenState extends State<FlutterQuillScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Timer? _timer;

  QuillController _controller = QuillController.basic();

  // Add a variable to track the selected menu item
  String _selectedMenuItem = 'Editor';

  @override
  void initState() {
    super.initState();

    // JSON data representing the document
    const String jsonData = '''
    {
      "document": [
        {"insert": "This is a sample document to help you get started.\\n\\n"},
        {"insert": "Key Features:\\n", "attributes": {"header": 2}},
        {"insert": "• Rich text formatting\\n"},
        {"insert": "• Support for lists and headings\\n"},
        {"insert": "• Custom toolbar options\\n\\n"},
        {"insert": "Getting Started\\n", "attributes": {"header": 2}},
        {"insert": "You can edit this text or delete it and start from scratch.\\n\\n"},
        {"insert": "Enjoy using Flutter Quill!\\n"}
      ]
    }
    ''';

    // Parse the JSON data
    final Map<String, dynamic> documentJson = jsonDecode(jsonData);

    // Create a Quill document from the JSON
    final quill.Document document =
        quill.Document.fromJson(documentJson['document']);

    // Initialize the QuillController with the document
    _controller = quill.QuillController(
      document: document,
      selection: const TextSelection.collapsed(offset: 0),
    );

    // Set up a timer to pull document content every 10 seconds
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      _pullDocumentContent();
    });
  }

  void _pullDocumentContent() {
    final delta = _controller.document.toDelta();
    // Don't try to cast it, just use it directly
    print('Document Delta: ${delta.toJson()}');
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Flutter Quill Editor'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: quill.QuillEditor.basic(
                controller: _controller,
                configurations: QuillEditorConfigurations(
                  placeholder: 'Type something...',
                  customStyles: DefaultStyles(
                    h1: const quill.DefaultTextBlockStyle(
                      TextStyle(
                        fontSize: 32,
                      ),
                      HorizontalSpacing(0, 0),
                      VerticalSpacing(0, 0),
                      VerticalSpacing(0, 0),
                      null
                    )
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade200)),
              ),
              child: QuillToolbar.simple(
                configurations: QuillSimpleToolbarConfigurations(
                  controller: _controller,
                  multiRowsDisplay: false,
                  showUndo: false,
                  showRedo: false,
                  showSubscript: false,
                  showSuperscript: false,
                  showClipboardCut: false,
                  showClipboardCopy: false,
                  showClipboardPaste: false,
                  showHeaderStyle: false, // Hide default header style
                  showFontFamily: false,
                  showFontSize: false,
                  showBoldButton: true,
                  showItalicButton: true,
                  showSmallButton: false,
                  showUnderLineButton: false,
                  showStrikeThrough: false,
                  showInlineCode: false,
                  showColorButton: false,
                  showBackgroundColorButton: false,
                  showClearFormat: false,
                  showAlignmentButtons: false,
                  showLeftAlignment: false,
                  showCenterAlignment: false,
                  showRightAlignment: false,
                  showJustifyAlignment: false,
                  showListNumbers: true,
                  showListBullets: true,
                  showListCheck: false,
                  showCodeBlock: false,
                  showQuote: false,
                  showIndent: false,
                  showLink: false,
                  showSearchButton: false,
                  customButtons: [
                    QuillToolbarCustomButtonOptions(
                      icon: const Icon(Icons.abc),
                      tooltip: 'Heading Styles',
                      onPressed: () {
                        // Show a custom dialog with H1-H6 options
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Select Heading'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: const Text('Normal',
                                      style: TextStyle(fontSize: 16)),
                                  onTap: () {
                                    // Remove header attribute
                                    _controller.formatSelection(null);
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  title: const Text('H1',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold)),
                                  onTap: () {
                                    // Apply H1 style
                                    _controller.formatSelection(
                                        HeaderAttribute(level: 1));
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  title: const Text('H2',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold)),
                                  onTap: () {
                                    // Apply H2 style
                                    _controller.formatSelection(
                                        HeaderAttribute(level: 2));
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  title: const Text('H3',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  onTap: () {
                                    // Apply H3 style
                                    _controller.formatSelection(
                                        HeaderAttribute(level: 3));
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: _buildDrawer(context),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDrawerHeader('Quill Editor'),
              _buildDrawerItem(
                icon: Icons.description,
                title: 'Editor',
                isSelected: _selectedMenuItem == 'Editor',
                onTap: () => _selectMenuItem('Editor'),
              ),
              _buildDrawerItem(
                icon: Icons.chat,
                title: 'Chat Demo',
                isSelected: _selectedMenuItem == 'Chat Demo',
                onTap: () => _selectMenuItem('Chat Demo'),
              ),
              const SizedBox(height: 24),
              _buildDrawerHeader('Features'),
              _buildDrawerItem(
                icon: Icons.format_bold,
                title: 'Text Formatting',
                isSelected: _selectedMenuItem == 'Text Formatting',
                onTap: () => _selectMenuItem('Text Formatting'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 4),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF444444),
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (isSelected) {
              return Colors.deepPurple.withOpacity(0.2);
            }
            if (states.contains(MaterialState.hovered)) {
              return Colors.grey.withOpacity(0.1);
            }
            return Colors.transparent;
          }),
          foregroundColor: MaterialStateProperty.resolveWith((states) =>
              isSelected ? Colors.deepPurple : const Color(0xFF666666)),
          elevation: MaterialStateProperty.resolveWith((states) => 0),
          padding: MaterialStateProperty.resolveWith(
              (states) => const EdgeInsets.all(16)),
        ),
        onPressed: onTap,
        child: Row(
          children: [
            const SizedBox(width: 8),
            Icon(icon),
            const SizedBox(width: 16),
            Expanded(
              child: Text(title),
            ),
          ],
        ),
      ),
    );
  }

  void _selectMenuItem(String item) {
    setState(() {
      _selectedMenuItem = item;
      Navigator.pop(context); // Close the drawer
    });

    // Handle different menu selections
    if (item == 'View Mode') {
      // Toggle read-only mode
      _controller = quill.QuillController(
        document: _controller.document,
        selection: _controller.selection,
      );
      setState(() {});
    }
  }
}
