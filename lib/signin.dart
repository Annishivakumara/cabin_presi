import 'package:flutter/material.dart';
import 'homepage.dart'; // Importing the home page
import 'signup.dart'; // Importing the sign-up page

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF003F63), // Setting background color
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),

                // Sign-In Icon
                Image.asset(
                  'assets/magic.jpg', // Replace with your image asset path
                  width: 100, // Set the width to 100
                  height: 100, // Set the height to 100 for a square shape
                  fit: BoxFit.cover, // Use BoxFit.cover to maintain the aspect ratio
                ),

                const SizedBox(height: 20),

                // Email Field
                TextFormField(
                  style: const TextStyle(color: Colors.black), // Set text color to black
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email, color: Colors.black),
                    labelText: 'Email',
                    labelStyle: const TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white, // Solid white fill color
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30), // Rounded borders
                    ),
                    hintText: 'Enter your email', // Placeholder text
                    hintStyle: const TextStyle(color: Colors.black54), // Hint text color
                  ),
                  keyboardType: TextInputType.emailAddress, // Email input type
                ),
                const SizedBox(height: 20),

                // Password Field
                TextFormField(
                  obscureText: true, // Hide the text (password)
                  style: const TextStyle(color: Colors.black), // Set text color to black
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock, color: Colors.black),
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white, // Solid white fill color
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30), // Rounded borders
                    ),
                    hintText: 'Enter your password', // Placeholder text
                    hintStyle: const TextStyle(color: Colors.black54), // Hint text color
                  ),
                ),
                const SizedBox(height: 30),

                // Sign In Button
                ElevatedButton(
                  onPressed: () {
                    // For testing purposes, hardcoded email to check admin logic
                    final email = 'test@gmail.com'; // replace with actual email logic
                    bool isAdmin = email.contains('@teacher');
                    
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(isAdmin: isAdmin), // Pass the isAdmin value
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Rounded button
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),

                // Don't have an account? Sign Up
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUpPage()),
                    );
                  },
                  child: const Text(
                    "Don't have an account? Sign Up",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}






//firebase
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'homepage.dart'; // Importing the home page
// import 'signup.dart'; // Importing the sign-up page

// class SignInPage extends StatefulWidget {
//   const SignInPage({Key? key}) : super(key: key);

//   @override
//   _SignInPageState createState() => _SignInPageState();
// }

// class _SignInPageState extends State<SignInPage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   void _signIn() async {
//     try {
//       await _auth.signInWithEmailAndPassword(
//         email: _emailController.text.trim(),
//         password: _passwordController.text.trim(),
//       );
      
//       bool isAdmin = _emailController.text.contains('@teacher');
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => HomePage(isAdmin: isAdmin)),
//       );
//     } catch (e) {
//       print('Error: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to sign in: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF003F63),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   'Sign In',
//                   style: TextStyle(
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 Image.asset(
//                   'assets/magic.jpg',
//                   width: 100,
//                   height: 100,
//                   fit: BoxFit.cover,
//                 ),
//                 const SizedBox(height: 20),
//                 TextFormField(
//                   controller: _emailController,
//                   decoration: InputDecoration(
//                     hintText: 'Email',
//                     prefixIcon: const Icon(Icons.email, color: Colors.black),
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                   keyboardType: TextInputType.emailAddress,
//                 ),
//                 const SizedBox(height: 20),
//                 TextFormField(
//                   controller: _passwordController,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     hintText: 'Password',
//                     prefixIcon: const Icon(Icons.lock, color: Colors.black),
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 ElevatedButton(
//                   onPressed: _signIn,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                   child: const Text(
//                     'Sign In',
//                     style: TextStyle(fontSize: 18, color: Colors.white),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(builder: (context) => const SignUpPage()),
//                     );
//                   },
//                   child: const Text(
//                     "Don't have an account? Sign Up",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
