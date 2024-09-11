import 'package:flutter/material.dart';
import '../models/Country.dart';
import 'CountryDetailScreen.dart';
class CountryListScreen extends StatefulWidget {

  final String title;

  const CountryListScreen({super.key,required this.title});

  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  final List<Country> countries = [
    Country(1, 'United States'),
    Country(2, 'Canada'),
    Country(3, 'United Kingdom'),
    Country(4, 'Australia'),
    Country(5, 'Germany'),
    Country(5, 'India'),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country List'),
      ),
      body: ListView.builder(
        itemCount:countries.length,
        itemBuilder: (context, index){
          final country = countries[index];
          return InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context)=>CountryDetailScreen(country: country),
                ),
              );
            },
              child: ListTile(
                leading:CircleAvatar(
                  child: Text(country.id.toString()),
                ),
                title:Text(country.name),
              ),
          );
        },
      ),
    );
  }
}
