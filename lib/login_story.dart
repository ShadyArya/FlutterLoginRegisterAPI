import 'package:flutter/material.dart';
import 'package:http/http.dart';

class LoginStory extends StatefulWidget {
  const LoginStory({super.key});

  @override
  State<LoginStory> createState() => _LoginStoryState();
}

class _LoginStoryState extends State<LoginStory> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login(String email, String password) async {
    try {
      Response response = await post(
        Uri.parse('https://story-api.dicoding.dev/v1/login'),
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        print('Login Berhasil');
        // Menampilkan alert login berhasil
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Login Berhasil'),
              content: const Text('Anda telah berhasil login.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Lakukan tindakan setelah login berhasil
                  },
                ),
              ],
            );
          },
        );
      } else {
        print('Login gagal');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'LOGIN',
              style: TextStyle(
                fontSize: 18,
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                login(emailController.text.trim(), passwordController.text.trim());
              },
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

