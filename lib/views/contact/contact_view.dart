// lib/views/contact/contact_view.dart

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:robogenius/core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/fade_in_widget.dart';
import '../../widgets/common/glass_card.dart';
import '../../widgets/common/section_title.dart';
import '../../widgets/layout/footer.dart';
import '../../widgets/layout/scroll_scaffold.dart';

// ─── Page ─────────────────────────────────────────────────────────────────────

class ContactView extends StatelessWidget {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollScaffold(
      sections: [
        _ContactHero(),
        _ContactBody(),
        const Footer(),
      ],
    );
  }
}

// ─── Hero ─────────────────────────────────────────────────────────────────────

class _ContactHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 140,
        bottom: 80,
        left: Responsive.value(context, mobile: 24, desktop: 100),
        right: Responsive.value(context, mobile: 24, desktop: 100),
      ),
      decoration: BoxDecoration(gradient: dc.heroGradient),
      child: FadeInWidget(
        uniqueKey: 'contact_hero',
        child: const SectionTitle(
          badge: '📞 CONTACT US',
          title: 'Let\'s Automate\nYour Business Together',
          subtitle: 'Schedule a free consultation with our automation experts. '
              'We\'ll analyse your processes and show you exactly where automation can deliver the most impact.',
        ),
      ),
    );
  }
}

// ─── Body ─────────────────────────────────────────────────────────────────────

class _ContactBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);

    return Container(
      color: dc.background,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.value(context, mobile: 20, desktop: 100),
        vertical: 60,
      ),
      child: isMobile
          ? Column(children: [
              FadeInWidget(uniqueKey: 'contact_form', child: _ContactForm()),
              const SizedBox(height: 40),
              FadeInWidget(
                  uniqueKey: 'contact_info', child: _ContactInfo(dc: dc)),
            ])
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 5,
                    child: FadeInWidget(
                        uniqueKey: 'contact_form', child: _ContactForm())),
                const SizedBox(width: 40),
                Expanded(
                    flex: 3,
                    child: FadeInWidget(
                        uniqueKey: 'contact_info',
                        delay: const Duration(milliseconds: 200),
                        child: _ContactInfo(dc: dc))),
              ],
            ),
    );
  }
}

// ─── Contact Form ─────────────────────────────────────────────────────────────

enum _SubmitState { idle, loading, success, error }

class _ContactForm extends StatefulWidget {
  const _ContactForm();

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _mobileCtrl = TextEditingController();
  final _companyCtrl = TextEditingController();
  final _msgCtrl = TextEditingController();

  String _selectedService = 'Robotic Process Automation';
  _SubmitState _state = _SubmitState.idle;
  String _errorMessage = '';

  static const _services = [
    'Robotic Process Automation',
    'AI & Machine Learning',
    'Mobile App Development',
    'Web Development',
    'UI/UX Design',
  ];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _mobileCtrl.dispose();
    _companyCtrl.dispose();
    _msgCtrl.dispose();
    super.dispose();
  }

  // ── Validators ──────────────────────────────────────────────────────────────

  String? _validateName(String? v) {
    if (v == null || v.trim().isEmpty) return 'Full name is required';
    if (v.trim().length < 2) return 'Name must be at least 2 characters';
    return null;
  }

  String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email address is required';
    final regex = RegExp(r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$');
    if (!regex.hasMatch(v.trim())) return 'Enter a valid email address';
    return null;
  }

  String? _validateMobile(String? v) {
    if (v == null || v.trim().isEmpty) return 'Mobile number is required';
    final digits = v.trim().replaceAll(RegExp(r'\D'), '');
    if (digits.length != 10) return 'Mobile number must be exactly 10 digits';
    if (RegExp(r'^[0-5]').hasMatch(digits)) {
      return 'Enter a valid Indian mobile number';
    }
    return null;
  }

  String? _validateCompany(String? v) {
    if (v == null || v.trim().isEmpty) return 'Company name is required';
    if (v.trim().length < 2) return 'Enter a valid company name';
    return null;
  }

  // ── Submit ───────────────────────────────────────────────────────────────────

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _state = _SubmitState.loading;
      _errorMessage = '';
    });

    try {
      // Determine the API endpoint based on platform
      String apiUrl;
      http.Client client;

      // Check if we're running on web (production) or native
      if (Uri.base.scheme == 'http' || Uri.base.scheme == 'https') {
        // Running on web - use Netlify function for production
        // or direct API for local development
        if (Uri.base.host.contains('netlify.app') ||
            Uri.base.host.contains('localhost') && Uri.base.port != 8080) {
          apiUrl = '/.netlify/functions/contact';
        } else {
          // Local development with web-server
          apiUrl = 'https://reliwave.relitrade.in:9010/contact';
        }
        client = http.Client();
      } else {
        // Running on native platform (iOS/Android/Desktop)
        apiUrl = 'https://reliwave.relitrade.in:9010/contact';
        try {
          final httpClient = HttpClient()
            ..badCertificateCallback =
                (X509Certificate cert, String host, int port) => true;
          client = IOClient(httpClient);
        } catch (e) {
          client = http.Client();
        }
      }

      final response = await client
          .post(
            Uri.parse(apiUrl),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode({
              'full_name': _nameCtrl.text.trim(),
              'email': _emailCtrl.text.trim(),
              'mobile': _mobileCtrl.text.trim().replaceAll(RegExp(r'\D'), ''),
              'company': _companyCtrl.text.trim(),
              'message': _msgCtrl.text.trim().isEmpty
                  ? 'No message provided'
                  : _msgCtrl.text.trim(),
            }),
          )
          .timeout(const Duration(seconds: 15));

      // Close the client
      client.close();

      if (!mounted) return;

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() => _state = _SubmitState.success);
      } else {
        // Try to parse error message from response body
        String msg = _parseErrorMessage(response);
        setState(() {
          _state = _SubmitState.error;
          _errorMessage = msg;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _state = _SubmitState.error;
        _errorMessage = _friendlyError(e);
      });
      // Debug: Print error to console
      print('Contact form error: $e');
    }
  }

  String _parseErrorMessage(http.Response response) {
    try {
      final body = jsonDecode(response.body);
      if (body is Map) {
        return body['message']?.toString() ??
            body['error']?.toString() ??
            'Server error (${response.statusCode}). Please try again.';
      }
    } catch (_) {}
    switch (response.statusCode) {
      case 400:
        return 'Invalid form data. Please check your details and try again.';
      case 422:
        return 'Validation failed on the server. Please review your inputs.';
      case 429:
        return 'Too many requests. Please wait a moment and try again.';
      case 500:
      case 502:
      case 503:
        return 'Our server is temporarily unavailable. Please try again shortly.';
      default:
        return 'Unexpected error (${response.statusCode}). Please try again.';
    }
  }

  String _friendlyError(dynamic e) {
    final msg = e.toString().toLowerCase();
    if (msg.contains('timeout'))
      return 'Request timed out. Please check your connection and try again.';
    if (msg.contains('failed to fetch') || msg.contains('clientexception'))
      return 'Connection blocked by browser security (CORS/SSL). For testing: Run ./run_chrome_dev.sh and flutter run -d web-server';
    if (msg.contains('socketexception') ||
        msg.contains('failed host lookup') ||
        msg.contains('network') ||
        msg.contains('connection'))
      return 'No internet connection. Please check your network and try again.';
    if (msg.contains('handshake') ||
        msg.contains('certificate') ||
        msg.contains('tlsexception'))
      return 'Secure connection failed. Please try again.';
    if (msg.contains('xmlhttprequest'))
      return 'Browser blocked the request. Please check CORS settings or try using the mobile app.';
    return 'Something went wrong. Please try again. Error: ${e.toString()}';
  }

  void _resetForm() {
    setState(() {
      _state = _SubmitState.idle;
      _errorMessage = '';
    });
  }

  // ── Build ────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);

    return GlassCard(
      padding: const EdgeInsets.all(36),
      borderRadius: 20,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: _state == _SubmitState.success
            ? _SuccessState(dc: dc)
            : _FormBody(dc: dc),
      ),
    );
  }

  // ── Success state ────────────────────────────────────────────────────────────

  Widget _SuccessState({required DynamicColors dc}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
                gradient: AppColors.buttonGradient, shape: BoxShape.circle),
            child:
                const Icon(Icons.check_rounded, color: Colors.white, size: 40),
          ),
          const SizedBox(height: 24),
          Text('Message Sent!',
              style: TextStyle(
                  color: dc.textPrimary,
                  fontSize: 28,
                  fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          Text(
            'Our automation experts will reach out within 24 hours with a personalised assessment.',
            textAlign: TextAlign.center,
            style:
                TextStyle(color: dc.textSecondary, fontSize: 15, height: 1.6),
          ),
          const SizedBox(height: 32),
          TextButton.icon(
            onPressed: _resetForm,
            icon: Icon(Icons.refresh, color: dc.neonBlue, size: 18),
            label: Text('Send another message',
                style: TextStyle(color: dc.neonBlue, fontSize: 14)),
          ),
        ],
      ),
    );
  }

  // ── Form body ─────────────────────────────────────────────────────────────────

  Widget _FormBody({required DynamicColors dc}) {
    return Builder(builder: (context) {
      return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Get Your Free Automation Assessment',
                style: TextStyle(
                    color: dc.textPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            Text('Fill out the form and we\'ll respond within 24 hours.',
                style: TextStyle(color: dc.textSecondary, fontSize: 14)),
            const SizedBox(height: 28),

            // Row 1: Full Name + Email
            _buildResponsiveRow(context, [
              _FormField(
                ctrl: _nameCtrl,
                label: 'Full Name',
                icon: Icons.person_outline,
                validator: _validateName,
                dc: dc,
              ),
              _FormField(
                ctrl: _emailCtrl,
                label: 'Email Address',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
                dc: dc,
              ),
            ]),
            const SizedBox(height: 16),

            // Row 2: Mobile + Company
            _buildResponsiveRow(context, [
              _FormField(
                ctrl: _mobileCtrl,
                label: 'Mobile Number',
                icon: Icons.phone_outlined,
                hint: '10-digit mobile number',
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                validator: _validateMobile,
                dc: dc,
              ),
              _FormField(
                ctrl: _companyCtrl,
                label: 'Company Name',
                icon: Icons.business_outlined,
                validator: _validateCompany,
                dc: dc,
              ),
            ]),
            const SizedBox(height: 16),

            // Service dropdown
            _ServiceDropdown(
              value: _selectedService,
              services: _services,
              onChanged: (v) => setState(() => _selectedService = v!),
              dc: dc,
            ),
            const SizedBox(height: 16),

            // Message
            _FormField(
              ctrl: _msgCtrl,
              label: 'Message',
              icon: Icons.message_outlined,
              hint: 'Tell us about your automation needs...',
              maxLines: 4,
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'Message is required';
                }
                if (v.trim().length < 10) {
                  return 'Message must be at least 10 characters';
                }
                return null;
              },
              dc: dc,
            ),
            const SizedBox(height: 24),

            // Error banner
            if (_state == _SubmitState.error) ...[
              _ErrorBanner(message: _errorMessage, dc: dc),
              const SizedBox(height: 16),
            ],

            // Submit button
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                label: 'Send Message & Get Assessment',
                onTap: _submit,
                loading: _state == _SubmitState.loading,
                icon: Icons.send_outlined,
              ),
            ),

            const SizedBox(height: 12),
            Center(
              child: Text(
                'All fields are required',
                style: TextStyle(color: dc.textMuted, fontSize: 12),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildResponsiveRow(BuildContext context, List<Widget> children) {
    if (Responsive.isMobile(context)) {
      return Column(
        children:
            children.expand((w) => [w, const SizedBox(height: 16)]).toList()
              ..removeLast(),
      );
    }
    return Row(
      children: children
          .expand((w) => [Expanded(child: w), const SizedBox(width: 16)])
          .toList()
        ..removeLast(),
    );
  }
}

// ─── Reusable form field ──────────────────────────────────────────────────────

class _FormField extends StatefulWidget {
  final TextEditingController ctrl;
  final String label;
  final String? hint;
  final IconData icon;
  final int maxLines;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final DynamicColors dc;

  const _FormField({
    required this.ctrl,
    required this.label,
    required this.icon,
    required this.dc,
    this.hint,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.validator,
  });

  @override
  State<_FormField> createState() => _FormFieldState();
}

class _FormFieldState extends State<_FormField> {
  bool _focused = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    final dc = widget.dc;
    final hasError = _error != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: dc.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: hasError
                  ? Colors.red.shade400
                  : _focused
                      ? dc.neonBlue.withOpacity(0.7)
                      : dc.border,
              width: _focused || hasError ? 1.5 : 1,
            ),
            boxShadow: _focused && !hasError
                ? [
                    BoxShadow(
                        color: dc.neonBlue.withOpacity(0.1), blurRadius: 12)
                  ]
                : hasError
                    ? [
                        BoxShadow(
                            color: Colors.red.withOpacity(0.08), blurRadius: 8)
                      ]
                    : [],
          ),
          child: Focus(
            onFocusChange: (v) {
              setState(() {
                _focused = v;
                // validate on blur
                if (!v && widget.validator != null) {
                  _error = widget.validator!(widget.ctrl.text);
                }
              });
            },
            child: TextFormField(
              controller: widget.ctrl,
              maxLines: widget.maxLines,
              keyboardType: widget.keyboardType,
              inputFormatters: widget.inputFormatters,
              validator: (v) {
                final err = widget.validator?.call(v);
                setState(() => _error = err);
                return err;
              },
              style: TextStyle(color: dc.textPrimary, fontSize: 14),
              decoration: InputDecoration(
                hintText: widget.hint ?? widget.label,
                hintStyle: TextStyle(color: dc.textMuted, fontSize: 14),
                prefixIcon: Icon(widget.icon,
                    color: hasError
                        ? Colors.red.shade400
                        : _focused
                            ? dc.neonBlue
                            : dc.textMuted,
                    size: 18),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                errorStyle: const TextStyle(height: 0, fontSize: 0),
              ),
            ),
          ),
        ),
        // inline error text below the field
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          child: _error != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 5, left: 4),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline,
                          size: 13, color: Colors.red.shade400),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(_error!,
                            style: TextStyle(
                                color: Colors.red.shade400,
                                fontSize: 12,
                                height: 1.3)),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

// ─── Service dropdown ─────────────────────────────────────────────────────────

class _ServiceDropdown extends StatelessWidget {
  final String value;
  final List<String> services;
  final ValueChanged<String?> onChanged;
  final DynamicColors dc;

  const _ServiceDropdown({
    required this.value,
    required this.services,
    required this.onChanged,
    required this.dc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: dc.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: dc.border),
      ),
      child: Row(
        children: [
          Icon(Icons.settings_suggest_outlined, color: dc.textMuted, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                dropdownColor: dc.surface,
                style: TextStyle(color: dc.textPrimary, fontSize: 14),
                icon: Icon(Icons.keyboard_arrow_down, color: dc.textMuted),
                items: services
                    .map((s) => DropdownMenuItem(
                        value: s,
                        child:
                            Text(s, style: TextStyle(color: dc.textPrimary))))
                    .toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Error banner ─────────────────────────────────────────────────────────────

class _ErrorBanner extends StatelessWidget {
  final String message;
  final DynamicColors dc;

  const _ErrorBanner({required this.message, required this.dc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.red.shade900.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.red.shade400.withOpacity(0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade400, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Submission Failed',
                    style: TextStyle(
                        color: Colors.red.shade300,
                        fontWeight: FontWeight.w700,
                        fontSize: 14)),
                const SizedBox(height: 4),
                Text(message,
                    style: TextStyle(
                        color: Colors.red.shade300, fontSize: 13, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Contact Info ─────────────────────────────────────────────────────────────

class _ContactInfo extends StatelessWidget {
  final DynamicColors dc;
  const _ContactInfo({required this.dc});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _InfoCard(
            icon: Icons.email_outlined,
            title: 'Email Us',
            value: 'info@robogeniustech.co.in',
            color: dc.neonBlue,
            dc: dc),
        const SizedBox(height: 16),
        _InfoCard(
            icon: Icons.support_agent_outlined,
            title: 'For Support',
            value: 'support@robogeniustech.co.in',
            color: dc.neonBlue,
            dc: dc),
        const SizedBox(height: 16),
        _InfoCard(
            icon: Icons.phone_outlined,
            title: 'Call Us',
            value: AppConstants.phone,
            color: dc.neonPurple,
            dc: dc),
        const SizedBox(height: 16),
        _InfoCard(
            icon: Icons.location_on_outlined,
            title: 'Our Office',
            value: 'Mumbai, Maharashtra\nIndia',
            color: dc.neonCyan,
            dc: dc),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              dc.neonBlue.withOpacity(0.08),
              dc.neonPurple.withOpacity(0.05),
            ]),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: dc.neonBlue.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        color: dc.neonCyan, shape: BoxShape.circle)),
                const SizedBox(width: 8),
                Text('Response Time',
                    style: TextStyle(
                        color: dc.neonBlue,
                        fontSize: 12,
                        fontWeight: FontWeight.w600)),
              ]),
              const SizedBox(height: 10),
              Text(
                'We typically respond within 4 business hours.',
                style: TextStyle(
                    color: dc.textSecondary, fontSize: 13, height: 1.5),
              ),
              const SizedBox(height: 12),
              Text(
                'Free automation assessment\nincluded with every enquiry.',
                style: TextStyle(
                    color: dc.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1.5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;
  final DynamicColors dc;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
    required this.dc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: dc.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: dc.border),
      ),
      child: Row(children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                    color: dc.textMuted,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1)),
            const SizedBox(height: 4),
            Text(value,
                style: TextStyle(
                    color: dc.textPrimary, fontSize: 14, height: 1.4)),
          ],
        ),
      ]),
    );
  }
}
