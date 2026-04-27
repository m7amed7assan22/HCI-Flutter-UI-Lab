import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

void main() {
  runApp(const IPhone13Frame());
}

// ─────────────────────────────────────────
// IPHONE 13 DEVICE FRAME WRAPPER
// iPhone 13 logical screen: 390 × 844 pt
// ─────────────────────────────────────────

class IPhone13Frame extends StatelessWidget {
  const IPhone13Frame({super.key});

  @override
  Widget build(BuildContext context) {
    const double screenW = 390;
    const double screenH = 844;
    const double bezel = 12;
    const double cornerRadius = 54.0;
    const double notchW = 126;
    const double notchH = 34;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF1C1C1E),
        body: Center(
          child: SizedBox(
            width: screenW + bezel * 2,
            height: screenH + bezel * 2,
            child: Stack(
              children: [
                // Device shell
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(cornerRadius + bezel),
                    border: Border.all(
                      color: const Color(0xFF3A3A3C),
                      width: 1.5,
                    ),
                  ),
                ),
                // Screen area
                Positioned(
                  left: bezel,
                  top: bezel,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(cornerRadius),
                    child: SizedBox(
                      width: screenW,
                      height: screenH,
                      child: Stack(
                        children: [
                          // The actual app
                          const MyApp(),
                          // Notch overlay
                          Positioned(
                            top: 0,
                            left: (screenW - notchW) / 2,
                            child: Container(
                              width: notchW,
                              height: notchH,
                              decoration: const BoxDecoration(
                                color: Color(0xFF1A1A1A),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                              ),
                            ),
                          ),
                          // Home indicator
                          Positioned(
                            bottom: 8,
                            left: (screenW - 134) / 2,
                            child: Container(
                              width: 134,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Side buttons (volume up)
                Positioned(
                  left: -4,
                  top: 120,
                  child: Container(
                    width: 4,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C2C2E),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Positioned(
                  left: -4,
                  top: 164,
                  child: Container(
                    width: 4,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C2C2E),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                // Side button (power)
                Positioned(
                  right: -4,
                  top: 140,
                  child: Container(
                    width: 4,
                    height: 64,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C2C2E),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF2F2F7),
      ),
      home: const LoginPage(),
    );
  }
}

// ─────────────────────────────────────────
// SHARED WIDGETS
// ─────────────────────────────────────────

class BackCircleButton extends StatelessWidget {
  const BackCircleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.maybePop(context),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(Icons.arrow_back, size: 18, color: Colors.black87),
      ),
    );
  }
}

class PurpleButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const PurpleButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF9B6DFF), Color(0xFF7C4DFF)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF7C4DFF).withOpacity(0.35),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}

class UnderlineField extends StatefulWidget {
  final String label;
  final String initialValue;
  final bool obscure;
  final bool showStrength;
  final bool showCheck;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const UnderlineField({
    super.key,
    required this.label,
    this.initialValue = '',
    this.obscure = false,
    this.showStrength = false,
    this.showCheck = false,
    this.controller,
    this.onChanged,
  });

  @override
  State<UnderlineField> createState() => _UnderlineFieldState();
}

class _UnderlineFieldState extends State<UnderlineField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscure;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF9E9E9E),
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: widget.controller,
                obscureText: _obscure,
                onChanged: widget.onChanged,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.only(bottom: 8),
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFE0E0E0)),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFE0E0E0)),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF7C4DFF), width: 1.5),
                  ),
                  suffixIcon: widget.showStrength
                      ? const Padding(
                          padding: EdgeInsets.only(bottom: 4),
                          child: Text(
                            'Strong',
                            style: TextStyle(
                              color: Color(0xFF4CAF50),
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        )
                      : widget.showCheck
                          ? const Icon(Icons.check, color: Color(0xFF4CAF50), size: 20)
                          : widget.obscure
                              ? GestureDetector(
                                  onTap: () => setState(() => _obscure = !_obscure),
                                  child: Icon(
                                    _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                )
                              : null,
                  suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────
// LOGIN PAGE
// ─────────────────────────────────────────

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _rememberMe = true;
  final _usernameController = TextEditingController(text: 'Mohamed Hassan');
  final _passwordController = TextEditingController(text: 'HJ@#9783kja');

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const BackCircleButton(),
              const SizedBox(height: 28),
              const Center(
                child: Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              const Center(
                child: Text(
                  'Please enter your data to continue',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF9E9E9E),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              UnderlineField(
                label: 'Username',
                controller: _usernameController,
                showCheck: true,
              ),
              const SizedBox(height: 28),
              UnderlineField(
                label: 'Password',
                controller: _passwordController,
                obscure: true,
                showStrength: true,
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ForgotPasswordPage()),
                  ),
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Color(0xFFE53935),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Text(
                    'Remember me',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  Switch(
                    value: _rememberMe,
                    onChanged: (v) => setState(() => _rememberMe = v),
                    activeColor: Colors.white,
                    activeTrackColor: const Color(0xFF4CAF50),
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: const Color(0xFFBDBDBD),
                  ),
                ],
              ),
              const Spacer(),
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF9E9E9E),
                    ),
                    children: [
                      const TextSpan(text: 'By connecting your account confirm that you agree\nwith our '),
                      TextSpan(
                        text: 'Term and Condition',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              PurpleButton(
                label: 'Login',
                onTap: () {},
              ),
              const SizedBox(height: 16),
              Center(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                    children: [
                      const TextSpan(text: "Don't have an account? "),
                      TextSpan(
                        text: 'Sign Up',
                        style: const TextStyle(
                          color: Color(0xFF7C4DFF),
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const SignUpPage()),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
// SIGN UP PAGE
// ─────────────────────────────────────────

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _agreedToTerms = true;
  final _usernameController = TextEditingController(text: 'Mohamed Hassan');
  final _emailController = TextEditingController(text: 'm7amed7assan22@gmail.com');
  final _passwordController = TextEditingController(text: 'HJ@#9783kja');
  final _confirmController = TextEditingController(text: '***********');

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const BackCircleButton(),
              const SizedBox(height: 28),
              const Center(
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              UnderlineField(
                label: 'Username',
                controller: _usernameController,
                showCheck: true,
              ),
              const SizedBox(height: 28),
              UnderlineField(
                label: 'Email Address',
                controller: _emailController,
                showCheck: true,
              ),
              const SizedBox(height: 28),
              UnderlineField(
                label: 'Password',
                controller: _passwordController,
                obscure: true,
                showStrength: true,
              ),
              const SizedBox(height: 28),
              UnderlineField(
                label: 'Confirm Password',
                controller: _confirmController,
                obscure: true,
                showCheck: true,
              ),
              const SizedBox(height: 8),
              const Text(
                'Passwords match',
                style: TextStyle(
                  color: Color(0xFF7C4DFF),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: _agreedToTerms,
                    onChanged: (v) => setState(() => _agreedToTerms = v ?? false),
                    activeColor: const Color(0xFF7C4DFF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 14, color: Colors.black87),
                      children: [
                        const TextSpan(text: 'I agree to '),
                        TextSpan(
                          text: 'Terms & Conditions',
                          style: const TextStyle(
                            color: Color(0xFF7C4DFF),
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Center(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                    children: [
                      const TextSpan(text: 'Already have an account? '),
                      TextSpan(
                        text: 'Login',
                        style: const TextStyle(
                          color: Color(0xFF7C4DFF),
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => const LoginPage()),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              PurpleButton(
                label: 'Sign Up',
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                ),
              ),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
// FORGOT PASSWORD PAGE
// ─────────────────────────────────────────

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController(text: 'm7amed7assan22@gmail.com');

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const BackCircleButton(),
              const SizedBox(height: 24),
              const Center(
                child: Text(
                  'Forgot Password',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 36),
              // Cloud + Lock illustration
              Center(
                child: SizedBox(
                  width: 180,
                  height: 150,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Back cloud
                      Positioned(
                        left: 10,
                        top: 30,
                        child: Container(
                          width: 110,
                          height: 80,
                          decoration: BoxDecoration(
                            color: const Color(0xFFB39DDB),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      // Front cloud body
                      Positioned(
                        left: 30,
                        top: 50,
                        child: Container(
                          width: 130,
                          height: 75,
                          decoration: BoxDecoration(
                            color: const Color(0xFF9575CD),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      // Cloud bump left
                      Positioned(
                        left: 30,
                        top: 30,
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: const BoxDecoration(
                            color: Color(0xFF9575CD),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      // Cloud bump right
                      Positioned(
                        left: 80,
                        top: 15,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            color: Color(0xFF7E57C2),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      // Lock body (yellow)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 54,
                          height: 46,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFC107),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 8,
                                offset: const Offset(2, 4),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Lock shackle
                      Positioned(
                        right: 12,
                        bottom: 38,
                        child: Container(
                          width: 30,
                          height: 28,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF5D4037), width: 5),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                      // Lock keyhole
                      Positioned(
                        right: 22,
                        bottom: 14,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE65100),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 36),
              UnderlineField(
                label: 'Email Address',
                controller: _emailController,
              ),
              const Spacer(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Text(
                    'Please write your email to receive a\nconfirmation code to set a new password.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
              ),
              PurpleButton(
                label: 'Sign Up',
                onTap: () {},
              ),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}