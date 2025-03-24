import 'dart:convert';
import 'package:flutter/material.dart';
import '../components/MainAppBar.dart';
import 'package:http/http.dart' as http;

class Page3Screen extends StatefulWidget {
  const Page3Screen({super.key});
  @override
  State<Page3Screen> createState() => _Page3ScreenState();
}

class _Page3ScreenState extends State<Page3Screen> {
  List<dynamic>? apiData;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await Future.delayed(Duration(seconds: 1));
    try {
      final res = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      if (res.statusCode == 200) {
        setState(() {
          apiData = jsonDecode(res.body);
        });
        print(res.body);
        loading = false;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching Data $e');
      apiData = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://i.pinimg.com/736x/12/62/c1/1262c1c5fa1e3dd638f67766906fc400.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: loading
            ? Center(child: CircularProgressIndicator(color: Colors.white70))
            : Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                        child: const Text(
                          'Docking Station Crew',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.all(0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: apiData
                                        ?.map((item) => Container(
                                              margin: EdgeInsets.all(6),
                                              padding: EdgeInsets.all(10),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  color: Colors.white70,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Name: ${item['name']} (${item['username']})',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                      'Email: ${item['email']}',
                                                      style: TextStyle(
                                                          fontSize: 17)),
                                                  SizedBox(height: 5),
                                                  Row(children: [
                                                    Icon(Icons.phone, size: 18),
                                                    SizedBox(width: 5),
                                                    Text('${item['phone']}',
                                                        style: TextStyle(
                                                            fontSize: 15)),
                                                  ]),
                                                  Row(children: [
                                                    Icon(Icons.launch,
                                                        size: 18),
                                                    SizedBox(width: 5),
                                                    InkWell(
                                                      onTap: () {
                                                        print(
                                                            'https://${item['website']}');
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          content: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Company Details',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                              SizedBox(
                                                                  height: 8),
                                                              Text(
                                                                'Company name: ${item['company']['name']}',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white70),
                                                              ),
                                                              Text(
                                                                'Catchphrase: ${item['company']['catchPhrase']}',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white70),
                                                              ),
                                                              Text(
                                                                'BS: ${item['company']['bs']}',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white70),
                                                              ),
                                                            ],
                                                          ),
                                                          duration: Duration(
                                                              seconds: 4),
                                                          backgroundColor:
                                                              Colors.black87,
                                                          behavior:
                                                              SnackBarBehavior
                                                                  .floating,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          margin:
                                                              EdgeInsets.all(
                                                                  10),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      20,
                                                                  vertical: 10),
                                                          action:
                                                              SnackBarAction(
                                                            label: 'Close',
                                                            textColor:
                                                                Colors.blue,
                                                            onPressed: () {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .hideCurrentSnackBar();
                                                            },
                                                          ),
                                                        ));
                                                      },
                                                      child: Text(
                                                        item['website'],
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: const Color
                                                              .fromARGB(
                                                              255, 9, 108, 189),
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          decorationColor:
                                                              const Color
                                                                  .fromARGB(255,
                                                                  9, 108, 189),
                                                        ),
                                                      ),
                                                    )
                                                  ]),
                                                ],
                                              ),
                                            ))
                                        .toList() ??
                                    []),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
      ),
    );
  }
}
