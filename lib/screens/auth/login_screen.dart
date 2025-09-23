import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../models/user_model.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_card.dart';
import '../../utils/app_theme.dart';
import '../tourist/tourist_dashboard.dart';
import '../provider/provider_dashboard.dart';
import '../feature_showcase_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  bool _isLoginMode = true;
  bool _obscurePassword = true;
  UserRole _selectedRole = UserRole.tourist;

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.heroGradient,
        ),
        child: SafeArea(
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
            child: Column(
              children: [
                        const SizedBox(height: 40),
                        
                        // Header
                        _buildHeader(),
                        
                        const SizedBox(height: 40),
                        
                        // Login/Register Form
                        _buildForm(),
                        
                        const SizedBox(height: 30),
                        
                        // Demo accounts
                        _buildDemoAccounts(),
                        
                        const SizedBox(height: 20),
                        
                        // Guest mode option
                        _buildGuestModeOption(),
                        
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
                    children: [
        // App Logo
                      Container(
          width: 100,
          height: 100,
                        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
                        ),
                        child: Icon(
                          Icons.explore,
            size: 50,
            color: AppTheme.primaryColor,
          ),
        ),
        
        const SizedBox(height: 24),
        
        // App Name
        const Text(
          'ExploreEase',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        
        const SizedBox(height: 8),
        
        // Tagline
        Text(
          'Your Smart Travel Companion',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.9),
            fontSize: 16,
            letterSpacing: 0.5,
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Mode indicator
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            _isLoginMode ? 'Welcome Back!' : 'Join Our Community',
            style: const TextStyle(
                          color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return CustomCard(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mode toggle
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _isLoginMode = true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _isLoginMode 
                            ? AppTheme.primaryColor 
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Sign In',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _isLoginMode ? Colors.white : Colors.grey[600],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _isLoginMode = false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: !_isLoginMode 
                            ? AppTheme.primaryColor 
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Sign Up',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: !_isLoginMode ? Colors.white : Colors.grey[600],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Name field (for sign up)
            if (!_isLoginMode) ...[
              TextFormField(
                    controller: _nameController,
                decoration: const InputDecoration(
                    labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
                ),
                    validator: (value) {
                  if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
            ],
            
            // Email field
            TextFormField(
                  controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
                  validator: (value) {
                if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 16),
                
            // Password field
            TextFormField(
                  controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                  labelText: 'Password',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                
            const SizedBox(height: 16),
            
            // Role selection (for sign up)
            if (!_isLoginMode) ...[
              const Text(
                'Account Type',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedRole = UserRole.tourist),
                      child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                          color: _selectedRole == UserRole.tourist 
                              ? AppTheme.primaryColor.withValues(alpha: 0.1)
                              : Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _selectedRole == UserRole.tourist 
                                ? AppTheme.primaryColor
                                : Colors.grey[300]!,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.explore,
                              color: _selectedRole == UserRole.tourist 
                                  ? AppTheme.primaryColor
                                  : Colors.grey[600],
                              size: 32,
                        ),
                        const SizedBox(height: 8),
                        Text(
                              'Tourist',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: _selectedRole == UserRole.tourist 
                                    ? AppTheme.primaryColor
                                    : Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Explore destinations',
                          style: TextStyle(
                            fontSize: 12,
                                color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedRole = UserRole.provider),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _selectedRole == UserRole.provider 
                              ? AppTheme.primaryColor.withValues(alpha: 0.1)
                              : Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _selectedRole == UserRole.provider 
                                ? AppTheme.primaryColor
                                : Colors.grey[300]!,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.business,
                              color: _selectedRole == UserRole.provider 
                                  ? AppTheme.primaryColor
                                  : Colors.grey[600],
                              size: 32,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Provider',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: _selectedRole == UserRole.provider 
                                    ? AppTheme.primaryColor
                                    : Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Manage services',
                        style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
            ],
                
            // Submit button
                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                return CustomButton(
                  onPressed: authProvider.isLoading ? null : _handleSubmit,
                  isLoading: authProvider.isLoading,
                      width: double.infinity,
                  child: Text(_isLoginMode ? 'Sign In' : 'Create Account'),
                );
              },
            ),
            
            // Error message
            Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                if (authProvider.error != null) {
                  return Container(
                    margin: const EdgeInsets.only(top: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                            borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red[200]!),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error, color: Colors.red[600], size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            authProvider.error!,
                            style: TextStyle(color: Colors.red[600]),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDemoAccounts() {
    return CustomCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Demo Accounts',
                                style: TextStyle(
                                  fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          _buildDemoAccountCard(
            'Tourist Account',
            'tourist@example.com',
            'password',
            Icons.explore,
            Colors.blue,
          ),
          
          const SizedBox(height: 8),
          
          _buildDemoAccountCard(
            'Provider Account',
            'provider@example.com',
            'password',
            Icons.business,
            Colors.green,
          ),
          
          const SizedBox(height: 8),
          
          _buildDemoAccountCard(
            'Your Account',
            'saadgidin2@gmail.com',
            'Ibrahim09871',
            Icons.person,
            Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildDemoAccountCard(String title, String email, String password, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        _emailController.text = email;
        _passwordController.text = password;
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                  Text(
                    email,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                ),
              ],
            ),
          ),
            Icon(
              Icons.touch_app,
              color: color,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuestModeOption() {
    return CustomCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Icon(
            Icons.person_outline,
            size: 32,
            color: Colors.grey[600],
          ),
          const SizedBox(height: 12),
          const Text(
            'Just want to explore?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Continue as a guest to browse destinations without creating an account',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          CustomOutlinedButton(
            onPressed: () async {
              final authProvider = context.read<AuthProvider>();
              await authProvider.enterGuestMode();
              if (mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TouristDashboard(),
                  ),
                );
              }
            },
            child: const Text('Continue as Guest'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = context.read<AuthProvider>();
    
    bool success;
    if (_isLoginMode) {
      success = await authProvider.signIn(
        _emailController.text.trim(),
        _passwordController.text,
      );
    } else {
      success = await authProvider.signUp(
        _emailController.text.trim(),
        _passwordController.text,
        _nameController.text.trim(),
        _selectedRole,
      );
    }

    if (success && mounted) {
      final user = authProvider.currentUser!;
      if (user.role == UserRole.tourist) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const TouristDashboard()),
        );
      } else if (user.role == UserRole.provider) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ProviderDashboard()),
        );
      }
    }
  }
}