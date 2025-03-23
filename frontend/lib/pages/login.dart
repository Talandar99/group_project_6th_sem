import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 56,
            left: 24,
            right: 24,
            bottom: 24,
          ),
          child: Column(
              children: [

                //Logo
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.android,
                      size: 100,
                    ),
                    Text(
                      'Witaj ponownie!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Zaloguj się na swoje konto, aby móc w pełni korzystać z aplikacji.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                      ),
                    ),

                    //Form
                    Form(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Column(
                        children: [
                        
                          //Email
                          TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                        
                          //Password
                          TextFormField(
                            decoration: InputDecoration(
                              // prefixIcon: SvgPicture.asset('assets/icons/button.svg'),
                              prefixIcon: Icon(Icons.lock),
                              labelText: 'Hasło',
                              suffixIcon: Icon(Icons.visibility),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                        
                          //Forgot password + Remember me
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //Remember me
                              Row(
                                children: [
                                  Checkbox(value: false, onChanged: (value) {}),
                                  Text('Zapamiętaj mnie'),
                                ],
                              ),
                        
                              //Forgot password
                              TextButton(
                                onPressed: () {},
                                child: Text('Zapomniałeś hasła?'),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                        
                          //Sign in button
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text('Zaloguj się'),
                            ),
                          ),
                          SizedBox(height: 16),
                        
                          //Create account
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: OutlinedButton(
                              onPressed: () {},
                              child: Text('Załóż konto'),
                            ),
                          ),
                        
                          SizedBox(height: 16),
                        ],
                        ),
                      ))
                  ],
                )
              ],
            )
        ),
      ),
    );
  }
}