import 'package:flutter/material.dart';

import '../api_services/api_services.dart';
import '../model/user_model.dart';

class BoysInformationScreen extends StatefulWidget {
  final Boy userModel;

  const BoysInformationScreen({Key? key, required this.userModel})
      : super(key: key);

  @override
  State<BoysInformationScreen> createState() => _BoysInformationScreenState();
}

class _BoysInformationScreenState extends State<BoysInformationScreen> {
  late Future<UserModel> userModel;
  bool imageLoadError = false;
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
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_image.jpg'),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Icon(Icons.arrow_back_outlined),
                    onTap: () => Navigator.pop(context),
                  ),
                  Text(
                    "Boys Screen",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(),
                ],
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

                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.network(
                      widget.userModel.image.toString(),
                      height: height / 2,
                      errorBuilder: (context, error, stackTrace) {
                        imageLoadError = true;
                        return Icon(
                          Icons.error_outline,
                          size: height / 9,
                        ); // Show error icon on image load failure
                      },
                    ),
                    if (imageLoadError) SizedBox(height: height / 2.5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        widget.userModel.name.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        widget.userModel.description.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height / 4.5,
                      width: double.infinity,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 20)
                            .copyWith(top: height * 0.02),
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 10,
                        ),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.userModel.asset!.length,
                        itemBuilder: (context, index) {
                          final asset = widget.userModel.asset![index];

                          return Container(
                            height: height * 4.5,
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
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    asset.name.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                Image.network(
                                  asset.image.toString(),
                                  fit: BoxFit.cover,
                                  height: height * 0.1,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.error_outline,
                                      size: height * 0.07,
                                    ); // Show error icon on image load failure
                                  },
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    asset.type.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
