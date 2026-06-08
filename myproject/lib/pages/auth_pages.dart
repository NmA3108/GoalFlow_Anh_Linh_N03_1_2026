import 'package:flutter/material.dart';

import '../MyHomePage.dart';
import '../theme/app_design.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(12, 52, 12, 32),
        children: [
          const Center(
            child: Text(
              'Login',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(height: 78),
          const _FieldLabel('Enter your mobile number'),
          const _PhoneField(number: '1712345678'),
          const SizedBox(height: 22),
          const _FieldLabel('Enter your password'),
          const _AuthField(text: '*************', trailing: Icons.visibility),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ForgotPasswordPage()),
              ),
              child: const Text(
                'forgot password?',
                style: TextStyle(color: Color(0xFF211B43)),
              ),
            ),
          ),
          _DarkButton(
            label: 'Login',
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MyHomePage()),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don’t have an account? ",
                style: TextStyle(color: Colors.white),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterPage()),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const _Or(),
          const _SocialButton(icon: 'G', label: 'Continue with Google'),
          const SizedBox(height: 16),
          const _SocialButton(icon: '', label: 'Continue with Apple'),
          const _Or(),
          Center(
            child: TextButton(
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const MyHomePage()),
              ),
              child: const Text(
                'Continue as Guest',
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 32),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            ),
          ),
          const Center(
            child: Text(
              'Register',
              style: TextStyle(
                color: Color(0xFF22212D),
                fontSize: 28,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const _FieldLabel('Enter your mobile number', dark: true),
          const _PhoneField(number: '1712345678'),
          const SizedBox(height: 22),
          const _FieldLabel('Enter your email', dark: true),
          const _AuthField(text: 'abc12@gmail.com'),
          const SizedBox(height: 14),
          const _FieldLabel('Enter your password', dark: true),
          const _AuthField(text: '*************', trailing: Icons.visibility),
          const SizedBox(height: 14),
          const _FieldLabel('Re-Enter your password', dark: true),
          const _AuthField(text: '*************', trailing: Icons.visibility),
          const SizedBox(height: 28),
          _DarkButton(
            label: 'Sign Up',
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MyHomePage()),
            ),
          ),
          const _Or(),
          const _SocialButton(icon: 'G', label: 'Continue with Google'),
          const SizedBox(height: 16),
          const _SocialButton(icon: '', label: 'Continue with Apple'),
        ],
      ),
    );
  }
}

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(15, 14, 15, 28),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            ),
          ),
          const Center(
            child: Text(
              'Forgot',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(height: 48),
          const _HeroIllustration(icon: Icons.lock_reset),
          const SizedBox(height: 70),
          const Center(
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Don’t worry! it happens. Please enter phone\nnumber associated with your account',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, height: 1.5),
          ),
          const SizedBox(height: 28),
          const _FieldLabel('Enter your mobile number'),
          const _PhoneField(number: '458-465-6466'),
          const SizedBox(height: 26),
          _DarkButton(
            label: 'Get OTP',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const VerifyOtpPage()),
            ),
          ),
        ],
      ),
    );
  }
}

class VerifyOtpPage extends StatelessWidget {
  const VerifyOtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(12, 14, 12, 28),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            ),
          ),
          const Center(
            child: Text(
              'Verify',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(height: 34),
          const _HeroIllustration(icon: Icons.verified_user),
          const SizedBox(height: 72),
          const Center(
            child: Text(
              'Enter OTP',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'An 4 digit OTP has been sent to',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 8),
          const Text(
            '458-465-6466',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              4,
              (_) => Container(
                width: 65,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
            ),
          ),
          const SizedBox(height: 34),
          _DarkButton(
            label: 'Verify',
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MyHomePage()),
            ),
          ),
          const SizedBox(height: 8),
          const Center(
            child: Text(
              'Resend OTP (00:12)',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text, {this.dark = false});

  final String text;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: TextStyle(
          color: dark ? const Color(0xFF211B43) : Colors.white,
          fontSize: 16,
          letterSpacing: .5,
        ),
      ),
    );
  }
}

class _PhoneField extends StatelessWidget {
  const _PhoneField({required this.number});

  final String number;

  @override
  Widget build(BuildContext context) {
    return _AuthShell(
      child: Row(
        children: [
          const Text(
            '+91',
            style: TextStyle(color: Color(0xFF1F1F1F), fontSize: 16),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.keyboard_arrow_down, color: Color(0xFF1F1F1F)),
          const SizedBox(width: 12),
          Text(
            number,
            style: const TextStyle(color: Color(0xFF707070), fontSize: 16),
          ),
          const Spacer(),
          const Icon(Icons.check_circle, color: Color(0xFF1F1F1F), size: 18),
        ],
      ),
    );
  }
}

class _AuthField extends StatelessWidget {
  const _AuthField({required this.text, this.trailing});

  final String text;
  final IconData? trailing;

  @override
  Widget build(BuildContext context) {
    return _AuthShell(
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF707070),
              fontSize: 18,
              letterSpacing: 2,
            ),
          ),
          const Spacer(),
          if (trailing != null) Icon(trailing, color: Colors.black26),
        ],
      ),
    );
  }
}

class _AuthShell extends StatelessWidget {
  const _AuthShell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(child: child),
    );
  }
}

class _DarkButton extends StatelessWidget {
  const _DarkButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF151515),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({required this.icon, required this.label});

  final String icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            icon,
            style: TextStyle(
              fontSize: icon == 'G' ? 25 : 28,
              fontWeight: FontWeight.w900,
              color: icon == 'G' ? Colors.blue : Colors.black,
            ),
          ),
          const SizedBox(width: 14),
          Text(
            label,
            style: const TextStyle(color: Color(0xFF222222), fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _Or extends StatelessWidget {
  const _Or();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Text(
          'or',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}

class _HeroIllustration extends StatelessWidget {
  const _HeroIllustration({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 220,
        height: 210,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.9),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: const Color(0xFF465866), size: 92),
      ),
    );
  }
}
