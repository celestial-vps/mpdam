import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../providers/auth_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _email = TextEditingController(text: 'weslyaioria@gmail.com');
  final _password = TextEditingController(text: 'serverh5n');
  bool isLoading = false;

  Future<void> _submit() async {
    setState(() => isLoading = true);
    try {
      if (_email.text.isEmpty || _password.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email dan password tidak boleh kosong.'),
          ),
        );
        setState(() => isLoading = false);
        return;
      }

      await ref
          .read(authProvider.notifier)
          .login(_email.text.trim(), _password.text);
      if (!mounted) return;
      context.go('/home'); // ⬅️ Navigasi ke home setelah login sukses
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Login gagal: $e')));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 600, // Atur minimum tinggi agar muat semua widget
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome Back',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 32),

                  // Email Field
                  TextField(
                    controller: _email,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),

                  // Password Field
                  TextField(
                    controller: _password,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 12),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        context.push('/forgot-password');
                      },
                      child: const Text('Forgot password?'),
                    ),
                  ),

                  const SizedBox(height: 16),

                  isLoading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _submit,
                            child: const Text('Login'),
                          ),
                        ),

                  const Spacer(), // mendorong register ke bawah
                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      TextButton(
                        onPressed: () {
                          context.push('/register');
                        },
                        child: const Text('Register'),
                      ),
                    ],
                  ),

                  TextButton(
                    onPressed: () {
                      context.push('/forgot-password'); // ke forgot password
                    },
                    child: const Text('Forgot password?'),
                  ),

                  TextButton(
                    onPressed: () {
                      context.push('/register'); // ke register
                    },
                    child: const Text('Register'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.push('/home'); // ke register
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
