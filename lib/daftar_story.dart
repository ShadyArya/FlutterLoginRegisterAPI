import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login_story.dart';

class DaftarStory extends StatefulWidget {
  const DaftarStory({super.key});

  @override
  State<DaftarStory> createState() => _DaftarStoryState();
}

class _DaftarStoryState extends State<DaftarStory> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> daftar(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('https://story-api.dicoding.dev/v1/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        print('Daftar Berhasil');
        // Menampilkan alert sebelum berpindah halaman
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Pendaftaran Berhasil'),
              content: const Text('Anda telah berhasil mendaftar.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Navigasi ke halaman login setelah menutup dialog
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginStory()),
                    );
                  },
                ),
              ],
            );
          },
        );
      } else {
        print('Daftar gagal: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
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
            
            Text('DAFTAR ', style: TextStyle(fontSize: 18, color: Colors.blueGrey,
                fontWeight: FontWeight.bold)),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: TextField(
                controller: nameController,
                decoration:  InputDecoration(
                  hintText: 'Name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: TextField(
                controller: emailController,
                decoration:  InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: TextField(
                controller: passwordController,
                decoration:  InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                daftar(
                  nameController.text.trim(),
                  emailController.text.trim(),
                  passwordController.text.trim(),
                );
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
                    'Daftar',
                    style: TextStyle(color: Colors.white, fontSize: 18),
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
