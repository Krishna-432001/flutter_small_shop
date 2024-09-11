import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_small_shop/screens/product/ProductFilterByCategoryScreen.dart';
import 'package:http/http.dart' as http;
import '../models/Category.dart';
import '../utils/Constants.dart';
// import 'product/ProductFilterByCategoryScrren.dart';

class CategoryScreen extends StatefulWidget {
  final String title;
  const CategoryScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late List<Category> categories = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(Constants.BASE_URL + Constants.CATEGORY_ROUTE));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        setState(() {
          categories = data.map((category) => Category.fromJson(category)).toList();
        });
      } else {
        throw Exception('Failed to load categories: ' + Constants.BASE_URL + Constants.CATEGORY_ROUTE);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> onRefresh() async {
    await fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              fetchData();
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: categories.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return ListTile(
              // leading: Image.network(
              //   categories[index].image_path,
              //   height: 80,
              //   width: 80,
              //   fit: BoxFit.cover,
              // ),
              title: Text('ID: ${categories[index].id}'),
              subtitle: Text('Name: ${categories[index].name}'),
            );
          },
        ),
      ),
    );
  }
}

// class CategoryScreen extends StatefulWidget {
//   final String title;
//   const CategoryScreen({super.key, required this.title});
//
//   @override
//   State<CategoryScreen> createState() => _CategoryScreenState();
// }
//
// class _CategoryScreenState extends State<CategoryScreen> {
//   late List<Category> categories = [];
//
//   @override
//   void initState(){
//     super.initState();
//     fetchData();
//   }
//   Future<void> fetchData() async {
//     try{
//       final response = await http.get(Uri.parse(Constants.BASE_URL+Constants.CATEGORY_ROUTE));
//       if(response.statusCode==200){
//         final List<dynamic> data = json.decode(response.body)['data'];
//         setState(() {
//           categories = data.map((category) =>Category.fromJson(category)).toList();
//         });
//       }
//       else{
//         throw Exception('Failed to load categories'+Constants.BASE_URL+Constants.CATEGORY_ROUTE);
//       }
//     }
//     catch(e){
//       print('Error:$e');
//     }
//   }
//   void navigateToProductScreen(Category selectedCategory){
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context)=>ProductFilterByCategoryScreen(title:selectedCategory.name, category:selectedCategory),
//       ),
//     );
//   }
//   Future<void>onRefresh()async{
//     await fetchData();
//   }
//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       appBar: AppBar(
//         title:Text(widget.title),
//         actions:[
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed:(){
//               fetchData();
//             },
//           ),
//         ],
//       ),
//       body:RefreshIndicator(
//         onRefresh: onRefresh,
//         child: categories.isEmpty
//           ?Center(child:CircularProgressIndicator())
//             :ListView.builder(
//           itemCount: categories.length,
//           itemBuilder: (context,index){
//             return ListTile(
//               title:Text(categories[index].name),
//               onTap: (){
//                 navigateToProductScreen(categories[index]);
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
