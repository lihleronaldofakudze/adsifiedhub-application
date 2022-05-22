import 'dart:io';

import 'package:adsifiedhub/models/Advertiser.dart';
import 'package:adsifiedhub/models/Category.dart';
import 'package:adsifiedhub/models/CurrentUser.dart';
import 'package:adsifiedhub/models/Package.dart';
import 'package:adsifiedhub/models/SubCategory.dart';
import 'package:adsifiedhub/screens/login_screen.dart';
import 'package:adsifiedhub/screens/register_screen.dart';
import 'package:adsifiedhub/services/database_service.dart';
import 'package:adsifiedhub/services/storage.dart';
import 'package:adsifiedhub/widgets/loading_widget.dart';
import 'package:adsifiedhub/widgets/ok_dialog_widget.dart';
import 'package:adsifiedhub/widgets/picked_images_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAdScreen extends StatefulWidget {
  const AddAdScreen({Key? key}) : super(key: key);

  @override
  _AddAdScreenState createState() => _AddAdScreenState();
}

class _AddAdScreenState extends State<AddAdScreen> {
  List<String> subCategories = [];
  List<String> subSubCategories = [];
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  bool _isLoading = false;

  getSubCategories(String category) {
    for (int i = 0; i < categories.length; i++) {
      if (categories[i].main == category) {
        setState(() {
          subCategories = categories[i].subs;
        });
      }
      ;
    }
  }

  List<File> _images = [];
  String _errorImages = 'Please select images';
  int _selectedCategory = 0;
  int _selectedPackage = 0;
  int _selectedCondition = 0;
  int _selectedNeg = 0;

  String _category = 'Property';
  String _subCategory = 'Houses for Sales';
  String _subSubCategory = '';

  getSubSubCategories(String subCategory) {
    for (int i = 0; i < sub_categories.length; i++) {
      if (sub_categories[i].main == subCategory) {
        setState(() {
          subSubCategories = sub_categories[i].sub;
          this._subSubCategory = sub_categories[i].sub[0];
        });
      }
      ;
    }
  }

  final _conditions = ['Used', 'New'];
  String _condition = 'Used';

  final _negs = ['Negotiable', 'Not Negotiable'];
  String _neg = 'Negotiable';
  String _subscription = 'Free';

  _pickImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true, type: FileType.image, allowCompression: true);

    if (result!.files.length == 0) {
      setState(() {
        _errorImages = 'Please select images';
        _images = [];
      });
    } else {
      setState(() {
        _images = result.paths.map((path) => File(path!)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<CurrentUser?>(context);

    if (currentUser == null) {
      return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Grant Yourself Access'),
              bottom: TabBar(tabs: [
                Tab(
                  text: 'Login',
                ),
                Tab(
                  text: 'Register',
                ),
              ]),
            ),
            body: TabBarView(children: [LoginScreen(), RegisterScreen()]),
          ));
    } else {
      return _isLoading
          ? LoadingWidget()
          : StreamBuilder<Advertiser>(
              stream: DatabaseService(uid: currentUser.uid).advertiser,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Advertiser? advertiser = snapshot.data;
                  return Scaffold(
                    appBar: AppBar(
                      title: Text('Post New Advert'),
                    ),
                    body: SingleChildScrollView(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          _images.length == 0
                              ? Container(
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        _errorImages,
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ),
                                )
                              : PickedImagesWidget(
                                  images: _images,
                                ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 45,
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: _images.length == 0
                                        ? Colors.black
                                        : Colors.red),
                                onPressed: () => _pickImages(),
                                child: Text(
                                  _images.length == 0
                                      ? 'Choose Pictures'
                                      : 'Change Pictures',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            decoration: InputDecoration(
                                labelText: 'Advert Title',
                                border: OutlineInputBorder()),
                            keyboardType: TextInputType.text,
                            controller: _titleController,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            decoration: InputDecoration(
                                labelText: 'Advert Description',
                                border: OutlineInputBorder()),
                            maxLines: 5,
                            textAlignVertical: TextAlignVertical.top,
                            keyboardType: TextInputType.text,
                            controller: _descriptionController,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Select Advert Category',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          Wrap(
                            children: categories
                                .asMap()
                                .entries
                                .map((cat) => Row(
                                      children: [
                                        Radio(
                                          value: cat.key,
                                          onChanged: (value) {
                                            setState(() {
                                              this._subCategory = '';
                                              this.subCategories = [];
                                              this._selectedCategory =
                                                  int.parse(value.toString());
                                              this._category = cat.value.main;
                                              this._subCategory =
                                                  cat.value.subs[0];
                                              this.subSubCategories = [];
                                            });
                                            getSubCategories(_category);
                                          },
                                          groupValue: _selectedCategory,
                                        ),
                                        Text(cat.value.main,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ))
                                .toList(),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          DropdownButtonFormField(
                            value: _subCategory,
                            decoration: InputDecoration(
                                labelText: 'Select Sub Category',
                                border: OutlineInputBorder()),
                            items: subCategories.map((e) {
                              return DropdownMenuItem(value: e, child: Text(e));
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                this.subSubCategories = [];
                                this._subSubCategory = '';
                                _subCategory = value.toString();
                              });
                              getSubSubCategories(_subCategory);
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          DropdownButtonFormField(
                            value: _subSubCategory,
                            decoration: InputDecoration(
                                labelText: 'Select Sub Sub Category',
                                border: OutlineInputBorder()),
                            items: subSubCategories.map((e) {
                              return DropdownMenuItem(value: e, child: Text(e));
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _subSubCategory = value.toString();
                              });
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Select Advert Condition',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          Wrap(
                            children: _conditions
                                .asMap()
                                .entries
                                .map((cat) => Row(
                                      children: [
                                        Radio(
                                          value: cat.key,
                                          onChanged: (value) {
                                            setState(() {
                                              this._selectedCondition =
                                                  int.parse(value.toString());
                                              this._condition = cat.value;
                                            });
                                          },
                                          groupValue: _selectedCondition,
                                        ),
                                        Text(
                                          cat.value,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ))
                                .toList(),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Is Price Negotiable',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          Wrap(
                            children: _negs
                                .asMap()
                                .entries
                                .map((cat) => Row(
                                      children: [
                                        Radio(
                                          value: cat.key,
                                          onChanged: (value) {
                                            setState(() {
                                              this._selectedNeg =
                                                  int.parse(value.toString());
                                              this._neg = cat.value;
                                            });
                                          },
                                          groupValue: _selectedNeg,
                                        ),
                                        Text(
                                          cat.value,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ))
                                .toList(),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                                labelText: 'Advert Price',
                                border: OutlineInputBorder()),
                            controller: _priceController,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Select Advert Price Plan',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          Wrap(
                            children: packages
                                .asMap()
                                .entries
                                .map((cat) => Row(
                                      children: [
                                        Radio(
                                          value: cat.key,
                                          onChanged: (value) {
                                            setState(() {
                                              this._selectedPackage =
                                                  int.parse(value.toString());
                                              this._subscription =
                                                  cat.value.name;
                                            });
                                          },
                                          groupValue: _selectedPackage,
                                        ),
                                        Text(
                                          '${cat.value.name} - E ${cat.value.amount}0/${cat.value.duration}',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ))
                                .toList(),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            height: 45,
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  if (advertiser!.numberOfFreeAds <= 5) {
                                    if (_images.length != 0 &&
                                        _titleController.text.isNotEmpty &&
                                        _descriptionController
                                            .text.isNotEmpty &&
                                        _category.isNotEmpty &&
                                        _subCategory.isNotEmpty &&
                                        _subSubCategory.isNotEmpty &&
                                        _condition.isNotEmpty &&
                                        _subscription.isNotEmpty) {
                                      await uploadFiles(_images)
                                          .then((value) async {
                                        await DatabaseService(
                                                uid: currentUser.uid)
                                            .addAdvert(
                                                images: value,
                                                title: _titleController.text,
                                                description:
                                                    _descriptionController.text,
                                                firstCategory: _category,
                                                secondCategory: _subCategory,
                                                thirdCategory: _subSubCategory,
                                                condition: _condition,
                                                negotiable: _neg,
                                                price: double.parse(
                                                    _priceController.text),
                                                subscription: _subscription)
                                            .then((value) {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                          Navigator.pushNamed(
                                              context, '/add_ad');
                                        });
                                      }).catchError((onError) {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        showDialog(
                                            context: context,
                                            builder: (_) => okDialogWidget(
                                                context: context,
                                                message: onError.toString()));
                                      });
                                    } else {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      showDialog(
                                          context: context,
                                          builder: (_) => okDialogWidget(
                                              context: context,
                                              message:
                                                  'Please enter all required details.'));
                                    }
                                  } else {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    showDialog(
                                        context: context,
                                        builder: (_) => okDialogWidget(
                                            context: context,
                                            message:
                                                'You have reach your limit of FREE Adverts.'));
                                  }
                                },
                                child: Text(
                                  'Post Your Ad',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                )),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return LoadingWidget();
                }
              });
    }
  }
}
