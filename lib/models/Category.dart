import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Category {
  final String main;
  final Widget icon;
  final List<String> subs;

  Category({required this.main, required this.icon, required this.subs});
}

final List<Category> categories = [
  Category(main: 'Property', icon: FaIcon(FontAwesomeIcons.houseUser), subs: [
    "Houses for Sale",
    "Land for Sale",
    "Commercial Property for Sale",
    "Flats & Apartments for Sale",
    "Houses to Rent",
    "Commercial Property to Rent",
    "Rooms for Rent",
    "Flats & Apartments for Rent",
    "Land to Rent",
  ]),
  Category(main: 'Electronics', icon: FaIcon(FontAwesomeIcons.phone), subs: [
    "Cellphones",
    "Computer Accessories",
    "Laptops",
    "Printer Consumables",
    "TV & Decoders",
    "Printers & Scanners",
    "Desktops",
    "Cellphone Accessories",
    "Audio & Video Equipment",
    "Other Electronics",
    "Tablets",
    "Cameras",
    "Software",
    "Video Games & Consoles",
    "Monitors, Projectors",
  ]),
  Category(
      main: 'Building Supplies',
      icon: FaIcon(FontAwesomeIcons.tools),
      subs: [
        "Building Materials",
        "Boreholes & Plumbing Products",
        "Security Products",
        "Solar Panels & Batteries",
        "Floors, Walls & Ceilings",
        "Windows & Doors",
        "Lighting & Electrical",
        "Bathroom",
        "Building Tools",
        "Kitchen",
      ]),
  Category(
      main: 'Services',
      icon: FaIcon(FontAwesomeIcons.servicestack),
      subs: [
        "Building & Trade Services",
        "Security Services",
        "Car Rentals & Hire",
        "Advertising, Marketing & Printing",
        "Fitness, Beauty & Health Services",
        "Education, Tuition & Training",
        "Business Consultants",
        "Cleaning & Domestic Services",
        "Auto Services",
        "Other Services",
        "Landscaping & Gardening Services",
        "Computer & IT Services",
        "Moving, Transport & Storage",
        "Events, Wedding & Catering",
        "Funeral Services",
      ]),
  Category(
      main: 'Commercial Supplies',
      icon: FaIcon(FontAwesomeIcons.businessTime),
      subs: [
        "Office Furniture & Supplies",
        "Farming & Agriculture",
        "Store & Catering Equipment",
        "Protective Clothing & Uniforms",
        "Manufacturing & Engineering",
        "Generators",
        "Mining Equipment & Supplies",
        "Other Commercial Supplies",
        "Containers",
        "Businesses for Sale",
      ]),
  Category(
      main: 'Home & Garden',
      icon: FaIcon(FontAwesomeIcons.wineBottle),
      subs: [
        "Health, Medical & Beauty",
        "Home & Kitchen Appliances",
        "Furniture",
        "Baby & Kids Products",
        "Home Decor & Bedding",
        "Garden, Patio & Pools",
        "Pets",
        "Clothes & Shoes",
        "Energy, Batteries, Solar, Gas",
        "Sports & Fitness Gear",
        "Books",
        "Cutlery, Crockery & Glassware",
        "Fixtures, Fittings",
        "Musical Instruments",
      ]),
  Category(main: 'Cars', icon: FaIcon(FontAwesomeIcons.car), subs: [
    "Cars",
    "Car Parts",
    "Trucks & Trailers",
    "Boats & Leisure",
    "Vans & Buses",
    "Tractors & Heavy Equipment",
    "Motorbikes",
    "Other Vehicles",
  ]),
  Category(
      main: 'Dating & Friends',
      icon: FaIcon(FontAwesomeIcons.userFriends),
      subs: ["Women", "Massage", "Men", "Friends Only"])
];

const cities = [
  "Manzini",
  "Mbabane",
  "Big Bend",
  "Malkerns",
  "Nhlangano",
  "Mhlume",
  "Hluti",
  "Simunye",
  "Siteki",
  "Piggs Peak",
  "Lobamba",
  "Ngomane",
  "Vuvulane",
  "Mpaka",
  "Kwaluseni",
  "Bhunya",
  "Mhlambanyatsi",
  "Mondi",
  "Tabankulu",
  "Hlatikulu",
  "Bulembu",
  "Kubuta",
  "Tjaneni",
  "Sidvokodvo",
  "Lavumisa",
  "Ngwenya",
  "Nsoko",
  "Mankayane",
];
