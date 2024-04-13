import 'package:flutter/material.dart';
import 'package:projects/model/user_model.dart';

import '../api_services/api_services.dart';
import 'boys_information_screen.dart';

class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({super.key});

  @override
  State<HomeScreen1> createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  late Future<UserModel> userModel;

  @override
  void initState() {
    super.initState();
    userModel = ApiService().fetchUserModel();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/background_image.jpg'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          shrinkWrap: true,
          primary: true,
          physics: AlwaysScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                "Home Screen",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder<UserModel>(
              future: userModel,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return const Center(child: Text('No data available'));
                }

                final user = snapshot.data!;

                return Container(
                  height: height,
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1,
                    ),
                    itemCount: user.boys!.length,
                    itemBuilder: (context, index) {
                      final item = user.boys![index];

                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BoysInformationScreen(
                              userModel: item,
                            ),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 30),
                              height: height * 0.2,
                              width: width * 0.4,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.4),
                                    blurRadius:
                                        3, // changes the spread of the shadow
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                    spreadRadius:
                                        0, // changes how "thick" the shadow is
                                  ),
                                ],
                                color: Colors.white,
                                //  border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Text(
                                          item.name ?? 'No Name',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (item.image != null && item.image!.isNotEmpty)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      item.image!,
                                      fit: BoxFit.cover,
                                      height: height *
                                          0.15, // Adjust height as needed
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 35, vertical: 30),
                                          child: Icon(
                                            Icons.error_outline,
                                            size: height * 0.06,
                                          ),
                                        ); // Show error icon if image fails to load
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            if (item.image == null || item.image!.isEmpty)
                              const Text(
                                  "No Image"), // Show text if image URL is empty or null
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
