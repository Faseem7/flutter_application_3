import 'package:flutter/material.dart';
import 'package:flutter_application_3/models/category.dart';
import 'package:flutter_application_3/models/diet_model.dart';
import 'package:flutter_application_3/models/podular_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<DietModel> diet = [];
  List<CategoryModel> categories = [];
  List<PopularDietsModel> popularDiets = [];

  void _getInitialInfo() {
    categories = CategoryModel.getCategories();
    diet = DietModel.getDiets();
    popularDiets = PopularDietsModel.getPopularDiets();
  }

  @override
  Widget build(BuildContext context) {
    _getInitialInfo();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: ListView(
        children: [
          _searchField(),
          const SizedBox(
            height: 37,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Column(
              children: [
                Text(
                  'Category',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          category_items(),
          const SizedBox(
            height: 30,
          ),
          _dietModel(),
          const SizedBox(
            height: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Popular',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30),
              ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 110,
                        decoration: BoxDecoration(
                            color:popularDiets[index].boxIsSelected ? Colors.white:Colors.transparent,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow:popularDiets[index].boxIsSelected ? [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  offset: const Offset(0, 10),
                                  blurRadius: 40,
                                  spreadRadius: 0)
                            ] : []),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(
                              popularDiets[index].iconPath,
                              width: 65,
                              height: 65,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  popularDiets[index].name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontSize: 16),
                                ),
                                Text(
                                  '${popularDiets[index].level} | ${popularDiets[index].duration} | ${popularDiets[index].calorie}',
                                  style: const TextStyle(
                                      color: Color(0xff7B6F72),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                ),
                                
                              ],
                            ),
                            GestureDetector(
                                  onTap: () {},
                                  child: SvgPicture.asset(
                                    'assets/icons/button.svg',
                                    width: 30,
                                    height: 30,
                                  ),
                                )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 25),
                  itemCount: popularDiets.length)
            ],
          ),
          const SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }

  Column _dietModel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            'Reccomentation \nFor Diet',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        SizedBox(
          height: 200,
          child: ListView.separated(
            itemCount: diet.length,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(width: 25);
            },
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: 210,
                decoration: BoxDecoration(
                    color: diet[index].boxColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(diet[index].iconPath),
                    Text(
                      diet[index].name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 18),
                    ),
                    Text(
                      '${diet[index].level} | ${diet[index].duration} | ${diet[index].calorie}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 95, 93, 93),
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    Container(
                      height: 45,
                      width: 130,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            diet[index].viewIsSelected
                                ? const Color.fromARGB(255, 105, 187, 255)
                                : Colors.transparent,
                            diet[index].viewIsSelected
                                ? const Color.fromARGB(255, 13, 121, 139)
                                : Colors.transparent
                          ]),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          'view',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: diet[index].viewIsSelected
                                ? Colors.white
                                : const Color.fromARGB(255, 95, 93, 93),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            padding: const EdgeInsets.only(left: 20, right: 20),
          ),
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  SizedBox category_items() {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 20, right: 20),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 100,
            decoration: BoxDecoration(
                color: categories[index].boxColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(categories[index].iconPath),
                  ),
                ),
                Text(
                  categories[index].name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black),
                )
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          width: 20,
        ),
      ),
    );
  }

  Container _searchField() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.11),
              blurRadius: 20,
              spreadRadius: 0)
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SvgPicture.asset('assets/icons/Search.svg'),
            ),
            suffixIcon: SizedBox(
              width: 100,
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const VerticalDivider(
                      color: Colors.black,
                      thickness: 0.3,
                      indent: 5,
                      endIndent: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset('assets/icons/Filter.svg'),
                    ),
                  ],
                ),
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none),
            hintText: 'search for cupcake',
            hintStyle: const TextStyle(
              color: Color.fromARGB(255, 150, 149, 149),
              fontSize: 14,
            )),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        'Breakfast',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            'assets/icons/Arrow - Left 2.svg',
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                'assets/icons/dots.svg',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
