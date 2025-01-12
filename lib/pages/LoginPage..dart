import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('账号和密码不能为空')),
      );
      return;
    }

    // 创建 Dio 实例
    var dio = Dio();

    // 请求登录接口
    var url = 'https://example.com/login';
    try {
      var response = await dio.post(url, data: {
        'username': username,
        'password': password,
      });

      if (response.statusCode == 200) {
        // 登录成功
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('登录成功')),
        );
        // 可以在这里进行页面跳转等操作
      } else {
        // 登录失败
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('登录失败')),
        );
      }
    } catch (e) {
      // 请求异常处理
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('请求异常: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: '账号',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: '密码',
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _login,
              child: Text('登录'),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                // 跳转到注册页面
                Navigator.pushNamed(context, 'home');
              },
              child: Text('注册'),
            ),
          ],
        ),
      ),
    );
  }
}
