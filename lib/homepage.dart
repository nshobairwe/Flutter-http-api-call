import 'package:apiget/detailpage.dart';
import 'package:apiget/userservice.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Future<List<User>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = UserService().getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('People')),
      body: RefreshIndicator(
        onRefresh: () async{
          var users = await UserService().getUser();
          setState(() {
            futureUsers = Future.value(users);
          });
      },
        child: Center(
          child: FutureBuilder<List<User>>(
            future: futureUsers,
            builder: (context, AsyncSnapshot<List<User>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return ListView.separated(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    User user = snapshot.data![index];
                    return ListTile(
                      title: Text(user.email),
                      subtitle: Text(user.name?.first ?? 'No name available'), // Safe access with fallback
                      trailing: const Icon(Icons.chevron_right_outlined),
                      onTap: () => openPage(context, user),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(color: Colors.black26);
                  },
                );
              } else {
                return const Text('No users found.');
              }
            },
          ),
        ),
      ),
    );
  }

  openPage(BuildContext context, User user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Detailpage(user: user),
      ),
    );
  }
}
