import 'package:apiget/userservice.dart';
import 'package:flutter/material.dart';

class Detailpage extends StatefulWidget {
  final User user;
  const Detailpage({super.key, required this.user});

  @override
  State<Detailpage> createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          widget.user.name != null
              ? '${widget.user.name!.first} ${widget.user.name!.last}'
              : 'Name not available',
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            widget.user.picture != null
                ? Image.network(widget.user.picture!.large)
                : const Text('No picture available'),
            const SizedBox(height: 30),
            Text(widget.user.email),
          ],
        ),
      ),
    );
  }
}
