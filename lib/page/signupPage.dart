import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _selectedGender;

  // Define the API URL for signup (replace with your actual backend URL)
  final String apiUrl = 'http://192.168.1.10:3000/signup';

  // Dispose controllers
  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _birthDateController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Function to handle the signup
  Future<void> _signup() async {
    if (_selectedGender != null) {
      final Map<String, String> userData = {
        'name': _nameController.text,
        'phone': _phoneController.text,
        'birthDate': _birthDateController.text,
        'password': _passwordController.text,
        'gender': _selectedGender!,
      };

      try {
        // Make the POST request to the backend API
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode(userData),
        );

        // Handle the response
        if (response.statusCode == 201) {
          // Successfully registered
          final data = json.decode(response.body);

          // Check the correct key in the response (adjust 'message' if needed)
          if (data.containsKey('message')) {
            _showDialog('Бүртгүүлсэн', data['message']);
          } else {
            // If there's no message, you can show a default success message
            _showDialog('Бүртгүүлсэн', 'Амжилттай бүртгэгдлээ!');
          }

          Future.delayed(const Duration(seconds: 1), () {
            Navigator.pop(context,
                '/login'); // Pop the signup page off the stack (go back to the login page)
          });
        } else {
          // Show error message from the API
          final errorData = json.decode(response.body);
          _showDialog(
              'Алдаа', errorData['message'] ?? 'Бүртгэл хийхэд алдаа гарлаа.');
        }
      } catch (error) {
        _showDialog('Алдаа', 'Серверт алдаа гарлаа. Дахин оролдоно уу!');
      }
    } else {
      // Show an error if gender is not selected
      _showDialog('Алдаа', 'Та хүйсээ сонгоно уу!');
    }
  }

  // Function to show a dialog
  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0E21),
        elevation: 0,
        leading: IconButton(
          icon: Image.asset('assets/arrow_back.png', width: 30, height: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Бүртгүүлэх',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              _buildTextField('Нэр', 'Нэрээ оруулна уу',
                  controller: _nameController),
              const SizedBox(height: 15),
              _buildTextField('Утасны Дугаар', 'Утасны дугаараа оруулна уу',
                  controller: _phoneController),
              const SizedBox(height: 15),
              _buildDateField(context),
              const SizedBox(height: 15),
              _buildTextField('Нууц Үг', 'Нууц үгээ оруулна уу',
                  controller: _passwordController, isPassword: true),
              const SizedBox(height: 15),
              _buildTextField(
                  'Нууц Үг Баталгаажуулах', 'Нууц үгээ дахин оруулна уу',
                  controller: _passwordController, isPassword: true),
              const SizedBox(height: 15),
              const Text(
                'Хүйсээ сонгоно уу',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              const SizedBox(height: 8),
              _buildGenderSelection(),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF101136),
                  side: const BorderSide(color: Color(0xFFF8B9FF), width: 2),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: _signup,
                child: const Text(
                  'Бүртгүүлэх',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint,
      {bool isPassword = false, TextEditingController? controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPassword,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white54),
            filled: true,
            fillColor: Colors.transparent,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Color(0xFFF8B9FF)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Color(0xFFF8B9FF)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Төрсөн Он Сар Өдөр',
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            _selectDate(context);
          },
          child: AbsorbPointer(
            child: TextField(
              controller: _birthDateController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Төрсөн огноо оруулна уу',
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.transparent,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Color(0xFFF8B9FF)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Color(0xFFF8B9FF)),
                ),
                suffixIcon: Image.asset(
                  'assets/quill_calendar.png',
                  color: Colors.white54,
                  width: 20,
                  height: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _birthDateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Widget _buildGenderSelection() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedGender = 'Male';
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            decoration: BoxDecoration(
              color: _selectedGender == 'Male'
                  ? Color(0xFFDBA2DF)
                  : Colors.transparent,
              border: Border.all(color: Color(0xFFDBA2DF)),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Эрэгтэй',
                    style: TextStyle(
                      color: _selectedGender == 'Male'
                          ? Color(0xFF0A0E21)
                          : Colors.white,
                      fontSize: 18,
                      fontWeight: _selectedGender == 'Male'
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedGender = 'Female';
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            decoration: BoxDecoration(
              color: _selectedGender == 'Female'
                  ? Color(0xFFDBA2DF)
                  : Colors.transparent,
              border: Border.all(color: Color(0xFFDBA2DF)),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Эмэгтэй',
                    style: TextStyle(
                      color: _selectedGender == 'Female'
                          ? Color(0xFF0A0E21)
                          : Colors.white,
                      fontSize: 18,
                      fontWeight: _selectedGender == 'Female'
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
