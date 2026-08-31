import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinScreen extends StatefulWidget {
  final String? savedPin;
  final ValueNotifier<int> recitationCount;

  const PinScreen({super.key, required this.savedPin, required this.recitationCount});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  String _enteredPin = '';
  String _confirmPin = '';
  bool _isConfirming = false;
  String _errorMessage = '';

  late bool _isSetupMode;

  @override
  void initState() {
    super.initState();
    _isSetupMode = widget.savedPin == null;
  }

  void _onDigitPressed(String digit) {
    setState(() {
      _errorMessage = '';
      if (_enteredPin.length < 4) {
        _enteredPin += digit;
      }

      if (_enteredPin.length == 4) {
        if (_isSetupMode) {
          if (!_isConfirming) {
            _confirmPin = _enteredPin;
            _enteredPin = '';
            _isConfirming = true;
          } else {
            if (_enteredPin == _confirmPin) {
              _savePinAndContinue();
            } else {
              _errorMessage = 'Mã PIN không khớp, vui lòng thử lại';
              _enteredPin = '';
              _isConfirming = false;
            }
          }
        } else {
          // Verify mode
          if (_enteredPin == widget.savedPin) {
            _continueToApp();
          } else {
            _errorMessage = 'Mã PIN không đúng';
            _enteredPin = '';
          }
        }
      }
    });
  }

  void _onBackspacePressed() {
    setState(() {
      _errorMessage = '';
      if (_enteredPin.isNotEmpty) {
        _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1);
      }
    });
  }

  Future<void> _savePinAndContinue() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_pin', _enteredPin);
    _continueToApp();
  }

  void _continueToApp() {
    // Navigate to MainScaffold
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    String title = _isSetupMode
        ? (_isConfirming ? 'Xác nhận mã PIN' : 'Tạo mã PIN mới')
        : 'Nhập mã PIN để mở app';

    return Scaffold(
      backgroundColor: const Color(0xFF1A0D08),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const Icon(Icons.lock_outline, color: Color(0xFFD4AF37), size: 48),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: const TextStyle(color: Colors.redAccent, fontSize: 14),
              ),
            const SizedBox(height: 32),
            // PIN Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index < _enteredPin.length ? const Color(0xFFD4AF37) : const Color(0x33D4AF37),
                    border: Border.all(color: const Color(0xFFD4AF37), width: 2),
                  ),
                );
              }),
            ),
            const SizedBox(height: 64),
            // Keypad
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 1.5,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  for (int i = 1; i <= 9; i++) _buildKeypadButton(i.toString()),
                  const SizedBox.shrink(),
                  _buildKeypadButton('0'),
                  _buildBackspaceButton(),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
        ),
      ),
    );
  }

  Widget _buildKeypadButton(String digit) {
    return InkWell(
      onTap: () => _onDigitPressed(digit),
      borderRadius: BorderRadius.circular(40),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF2D1A11),
          border: Border.all(color: const Color(0x1AD4AF37)),
        ),
        child: Text(
          digit,
          style: const TextStyle(color: Color(0xFFFDF5E6), fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildBackspaceButton() {
    return InkWell(
      onTap: _onBackspacePressed,
      borderRadius: BorderRadius.circular(40),
      child: Container(
        alignment: Alignment.center,
        child: const Icon(Icons.backspace_outlined, color: Color(0xFFD1BFAE), size: 28),
      ),
    );
  }
}
