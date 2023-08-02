import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(UserHome());
}

class UserHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Antiques Marketplace',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Post> _posts = [];

  void _addPost(Post post) {
    setState(() {
      _posts.add(post);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Antiques Marketplace'),
      ),
      body: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          final post = _posts[index];
          return ListTile(
            leading: Image.file(post.image),
            title: Text('Item: ${post.name}'),
            subtitle: Text(
                'Price: ${post.price}\nQuality: ${post.quality}\nStatus: ${post.status}\nDetails: ${post.details}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final post = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPostScreen()),
          );
          if (post != null) {
            _addPost(post);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddPostScreen extends StatefulWidget {
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  File? _image;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  String _selectedQuality = 'New'; // Default quality state
  String _selectedStatus = 'Ready to Sell'; // Default status state

  final List<String> _qualityOptions = ['New', 'Used', 'Very Old'];
  final List<String> _statusOptions = ['Ready to Sell', 'Requested'];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  void _addPost(BuildContext context) {
    final name = _nameController.text;
    final priceText = _priceController.text;
    final details = _detailsController.text;

    if (name.isEmpty || priceText.isEmpty || details.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Incomplete Details'),
          content: Text('Please fill in all fields.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(priceText)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Invalid Price'),
          content: Text('Please enter a valid integer for the price.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    final price = int.parse(priceText);
    final post = Post(
      image: _image!,
      name: name,
      price: price,
      quality: _selectedQuality,
      status: _selectedStatus,
      details: details,
    );
    Navigator.pop(context, post);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Select Image'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Item Name',
              ),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: 'Price',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            Text('Select Quality:'),
            DropdownButton<String>(
              value: _selectedQuality,
              items: _qualityOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedQuality = newValue!;
                });
              },
            ),
            SizedBox(height: 16.0),
            Text('Select Status:'),
            DropdownButton<String>(
              value: _selectedStatus,
              items: _statusOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedStatus = newValue!;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _detailsController,
              decoration: InputDecoration(
                labelText: 'Details',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _image != null ? () => _addPost(context) : null,
              child: Text('Post'),
            ),
          ],
        ),
      ),
    );
  }
}

class Post {
  final File image;
  final String name;
  final int price;
  final String quality;
  final String status;
  final String details;

  Post({
    required this.image,
    required this.name,
    required this.price,
    required this.quality,
    required this.status,
    required this.details,
  });
}
