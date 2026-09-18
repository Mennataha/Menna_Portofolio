/*import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AiSection extends StatefulWidget {
  const AiSection({super.key});

  @override
  State<AiSection> createState() => _AiSectionState();
}

class _AiSectionState extends State<AiSection> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  // IMPORTANT:
  // This API key is for development/testing only.
  // Do NOT use a real API key here when deploying Flutter Web.
  static const String _apiKey = 'my key';

  static const String _portfolioContext = '''
You are the AI Assistant for Menna Taha's Personal Portfolio Website.

Your role is to answer questions from recruiters and visitors about Menna's
professional background, education, skills, experience, projects,
technologies, and contact information.

Menna's Information:
Role: Flutter Developer
Education: Bachelor of Computers and Information at Egyptian E-Learning University (EELU). Expected graduation: 2027.
Experience: Flutter Mobile Application Developer Trainee at Digital Egypt Pioneers Initiative (DEPI).
Skills: Flutter, Dart, Firebase, UI/UX, Clean Architecture, OOP, Databases, Problem Solving, Software Architecture, Scalable Software Design.
Tools & Technologies: Git, GitHub, Figma, VS Code, Android Studio, Firebase.
AI: AI Integration, Prompt Engineering, Gemini API, Integrating AI features into Flutter applications.

Menna is interested in building modern, user-focused applications using Flutter and integrating AI-powered features when they add real value.

Instructions:
- Keep answers professional, concise, friendly, and direct.
- Always speak positively about Menna in the third person.
- Do not invent information.
- If information is not available in this context, politely say that the information is not available in the portfolio.
- Only answer questions related to Menna's professional background, education, skills, experience, projects, technologies, and portfolio.
''';

  late final GenerativeModel _model;
  late final ChatSession _chat;

  @override
  void initState() {
    super.initState();

    // استخدام موديل gemini-1.5-flash الأسرع
    _model = GenerativeModel(
      model: 'gemini-3.6-flash',
      apiKey: _apiKey,
      systemInstruction: Content.system(_portfolioContext),
    );

    _chat = _model.startChat();
  }

  // دالة الإرسال المعدلة لتدفق الرد لحظياً (Stream)
  Future<void> _sendMessage() async {
    final text = _controller.text.trim();

    if (text.isEmpty || _isLoading) {
      return;
    }

    setState(() {
      _messages.add({'sender': 'user', 'text': text});
      // إضافة عنصر فارغ للـ AI ليتم تحديثه كلمة بكلمة
      _messages.add({'sender': 'ai', 'text': ''});
      _isLoading = true;
    });

    _controller.clear();

    try {
      final responseStream = _chat.sendMessageStream(Content.text(text));

      await for (final chunk in responseStream) {
        if (chunk.text != null && chunk.text!.isNotEmpty) {
          setState(() {
            _messages.last['text'] =
                (_messages.last['text'] ?? '') + chunk.text!;
          });
        }
      }
    } catch (e) {
      debugPrint('Gemini Error: $e');

      setState(() {
        if (_messages.last['sender'] == 'ai' &&
            (_messages.last['text'] ?? '').isEmpty) {
          _messages.last['text'] =
              'Sorry, something went wrong. Please try again in a moment.';
        }
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _useSuggestedQuestion(String question) {
    _controller.text = question;
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: _controller.text.length),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 90),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 950),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TITLE SECTION
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 28,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'AI ASSISTANT',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Ask my AI assistant about my skills, experience, projects, or education.',
                style: TextStyle(
                  fontSize: 15,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 30),

              // CHAT CARD
              Container(
                height: 560,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF0D0B18).withValues(alpha: 0.85)
                      : Colors.white.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: theme.colorScheme.primary.withValues(alpha: 0.22),
                  ),
                ),
                child: Column(
                  children: [
                    // CHAT AREA
                    Expanded(
                      child: _messages.isEmpty
                          ? _buildWelcomeArea(context)
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 5,
                              ),
                              itemCount: _messages.length,
                              itemBuilder: (context, index) {
                                final message = _messages[index];
                                final isUser = message['sender'] == 'user';

                                return _buildMessage(
                                  context,
                                  message['text'] ?? '',
                                  isUser,
                                );
                              },
                            ),
                    ),

                    // LOADING
                    if (_isLoading)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: LinearProgressIndicator(
                          color: theme.colorScheme.primary,
                          backgroundColor: theme.colorScheme.primary.withValues(
                            alpha: 0.08,
                          ),
                        ),
                      ),

                    const SizedBox(height: 8),

                    // INPUT AREA
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            maxLength: 500,
                            decoration: InputDecoration(
                              counterText: '',
                              hintText: 'Ask about my skills, projects...',
                              filled: true,
                              fillColor: theme.colorScheme.surface.withValues(
                                alpha: 0.6,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 14,
                              ),
                            ),
                            onSubmitted: (_) {
                              _sendMessage();
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        IconButton.filled(
                          onPressed: _isLoading ? null : _sendMessage,
                          icon: const Icon(Icons.send_rounded),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeArea(BuildContext context) {
    final theme = Theme.of(context);

    final questions = [
      'What skills does Menna have?',
      'What is Menna\'s experience?',
      'What technologies does Menna use?',
      'Tell me about Menna\'s AI experience.',
    ];

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.primary.withValues(alpha: 0.12),
              ),
              child: Icon(
                Icons.auto_awesome,
                size: 30,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Hi! I\'m Menna\'s AI Assistant.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Ask me anything about Menna\'s professional background.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 25),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: questions.map((question) {
                return OutlinedButton(
                  onPressed: () {
                    _useSuggestedQuestion(question);
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: theme.colorScheme.primary.withValues(alpha: 0.35),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(question),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessage(BuildContext context, String text, bool isUser) {
    final theme = Theme.of(context);

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 650),
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isUser
              ? theme.colorScheme.primary
              : theme.colorScheme.primary.withValues(alpha: 0.10),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isUser ? 16 : 4),
            bottomRight: Radius.circular(isUser ? 4 : 16),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            height: 1.5,
            color: isUser ? Colors.white : theme.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}*/
