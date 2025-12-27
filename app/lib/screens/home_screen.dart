import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:share_plus/share_plus.dart';
import '../models/phrase.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  Phrase? _currentPhrase;
  bool _isLoading = true;
  int _animationKey = 0;

  @override
  void initState() {
    super.initState();
    _loadPhrase();
  }

  Future<void> _loadPhrase() async {
    setState(() {
      _isLoading = true;
    });

    final phrase = await _apiService.getRandomPhrase();

    setState(() {
      _currentPhrase = phrase;
      _isLoading = false;
      _animationKey++;
    });
  }

  void _copyToClipboard() {
    if (_currentPhrase != null) {
      Clipboard.setData(ClipboardData(text: _currentPhrase!.content));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Phrase copiée ! ✨'),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _sharePhrase() {
    if (_currentPhrase != null) {
      Share.share(
        '${_currentPhrase!.content}\n\n— Un truc que personne ne m\'a jamais dit',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              // Header
              Text(
                'Un truc que personne\nne m\'a jamais dit',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.white.withOpacity(0.5),
                  letterSpacing: 1.2,
                ),
              ),
              // Zone de la phrase
              Expanded(
                child: Center(
                  child: _isLoading
                      ? _buildLoadingIndicator()
                      : _buildPhraseCard(),
                ),
              ),
              // Boutons d'action
              _buildActionButtons(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const CircularProgressIndicator(
      strokeWidth: 2,
      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE8B4B8)),
    );
  }

  Widget _buildPhraseCard() {
    return GestureDetector(
          onDoubleTap: _copyToClipboard,
          child: Container(
            key: ValueKey(_animationKey),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.white.withOpacity(0.05),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFE8B4B8).withOpacity(0.05),
                  blurRadius: 40,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Text(
              _currentPhrase?.content ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Colors.white,
                height: 1.6,
                letterSpacing: 0.3,
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms, curve: Curves.easeOut)
        .slideY(begin: 0.1, end: 0, duration: 600.ms, curve: Curves.easeOut);
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        // Bouton principal - Nouvelle phrase
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _loadPhrase,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE8B4B8),
              foregroundColor: const Color(0xFF0D0D0D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Une autre',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Boutons secondaires
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSecondaryButton(
              icon: Icons.copy_rounded,
              label: 'Copier',
              onTap: _copyToClipboard,
            ),
            const SizedBox(width: 24),
            _buildSecondaryButton(
              icon: Icons.share_rounded,
              label: 'Partager',
              onTap: _sharePhrase,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSecondaryButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.white.withOpacity(0.7)),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
