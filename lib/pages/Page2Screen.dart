import 'package:flutter/material.dart';
import '../components/MainAppBar.dart';

class Page2Screen extends StatefulWidget {
  const Page2Screen({super.key});

  @override
  State<Page2Screen> createState() => _Page2ScreenState();
}

class _Page2ScreenState extends State<Page2Screen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final genderController = TextEditingController();
  String _status = 'Active';
  bool _isChecked = false;
  double sliderValue = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      print(!args.isNotEmpty);
      if (args.isNotEmpty) {
        setState(() {
          nameController.text = args['name'];
          emailController.text = args['email'];
          phoneController.text = args['phone'];
          passwordController.text = args['password'];
          genderController.text = args['gender'];
          _status = args['status'];
          _isChecked = args['isChecked'];
          sliderValue = args['sliderValue'];
        });
      }
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    genderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final props = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      appBar: const MainAppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://i.pinimg.com/736x/20/e7/e0/20e7e0051bdf8f04a8e9a0aed0b26355.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Submit the form ASAP',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: Column(
                    spacing: 10,
                    children: [
                      TextField(
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: 'name',
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                        controller: nameController,
                      ),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'email',
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                        controller: emailController,
                      ),
                      TextField(
                        maxLength: 10,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'phone number',
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                        controller: phoneController,
                      ),
                      TextField(
                        obscureText: true,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: 'password',
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                        controller: passwordController,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Gender'),
                            const SizedBox(height: 5),
                            DropdownMenu(
                              menuStyle: MenuStyle(
                                backgroundColor:
                                    WidgetStateProperty.all(Colors.grey[200]),
                              ),
                              width: double.infinity,
                              hintText: 'Select your gender',
                              controller: genderController,
                              dropdownMenuEntries: [
                                DropdownMenuEntry(value: 'Male', label: 'Male'),
                                DropdownMenuEntry(
                                    value: 'Female', label: 'Female'),
                              ],
                            ),
                          ]),
                      Row(
                        children: [
                          Radio(
                              value: 'Active',
                              groupValue: _status,
                              onChanged: (value) {
                                setState(() {
                                  _status = value as String;
                                });
                              }),
                          const Text('Active'),
                          Radio(
                              value: 'Inactive',
                              groupValue: _status,
                              onChanged: (value) {
                                setState(() {
                                  _status = value as String;
                                });
                              }),
                          const Text('Inactive'),
                        ],
                      ),
                      Row(children: [
                        Checkbox(
                            semanticLabel: 'Checkbox for terms and conditions',
                            value: _isChecked,
                            onChanged: (value) {
                              setState(() {
                                _isChecked = value ?? false;
                              });
                            }),
                        Text('I agree to the terms and conditions'),
                      ]),
                      Row(children: [
                        Switch(
                            value: _isChecked,
                            onChanged: (value) {
                              setState(() {
                                _isChecked = value;
                              });
                            }),
                        Text(
                            'Send me emails regarding the status of my account'),
                      ]),
                      Slider(
                        value: sliderValue,
                        onChanged: (value) {
                          setState(() {
                            sliderValue = value;
                          });
                        },
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          print(props);
                          print({
                            'name': nameController.text,
                            'email': emailController.text,
                            'password': passwordController.text,
                            'gender': genderController.text,
                            'status': _status,
                            'isChecked': _isChecked,
                            'sliderValue': sliderValue,
                            'phone': phoneController.text,
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 15, 36, 53),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text('Click here'),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
