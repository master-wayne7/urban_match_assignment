import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_match/src/features/home/bloc/home_bloc.dart';
import 'package:urban_match/src/features/home/widgets/repository_list.dart';

// A HomePage widget that displays a GitHub user's repositories
class HomePage extends StatelessWidget {
  // Controller for the username input field
  final TextEditingController _usernameController = TextEditingController();

  // Constructor for the HomePage widget
  HomePage({super.key});

  @override
  // Build the HomePage widget
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with a GitHub title and a scrolled under elevation
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text('GitHub'),
      ),
      // Body of the HomePage with a Padding widget for spacing
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 11.0),
        child: Column(
          children: [
            // Row with a username input field and a Fetch button
            SizedBox(
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .65,
                    height: 40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: TextField(
                        scrollPadding: EdgeInsets.zero,
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Color.fromARGB(255, 242, 242, 242),
                          hintText: 'Enter GitHub Username',
                        ),
                      ),
                    ),
                  ),
                  // Text button that triggers fetching the repositories
                  TextButton(
                    onPressed: () {
                      String username = _usernameController.text.trim();
                      if (username.isNotEmpty) {
                        context.read<HomeBloc>().add(HomeFetchRepositry(userName: username));
                      }
                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 33, 198, 243),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width * .22,
                        child: const Center(
                          child: Text(
                            'Fetch',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Sized box for vertical spacing
            const SizedBox(height: 10),
            // Expanded RepositoryList widget that displays the repositories
            const Expanded(child: RepositoryList()),
          ],
        ),
      ),
    );
  }
}
