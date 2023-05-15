import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopper/widgets/cart_icon.dart';

import '../../providers/dark_theme_provider.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    Color theme = context.watch<DarkThemeProvider>().darkTheme
        ? Colors.white
        : Colors.black;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
          child: Column(
            children: [
              Row(
                children: [
                  Text('My Cart',
                      style: TextStyle(
                          color: theme,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Icon(CarbonIcons.delete, color: theme, size: 20),
                ],
              ),
              const Divider(thickness: 1),
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: const NetworkImage(
                        'https://static.generated.photos/vue-static/face-generator/landing/wall/14.jpg'),
                  ),
                  const Spacer(),
                  Text('John Doe',
                      style: TextStyle(
                          color: theme,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                ],
              ),
              const Divider(thickness: 1),
              // swipe to delete list tile
              Expanded(
                child: ListView.builder( 
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(index.toString()),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                        ),
                      ),
                      onDismissed: (direction) {
                        // remove item from list
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.grey[300],
                          backgroundImage: NetworkImage(
                              'https://static.generated.photos/vue-static/face-generator/landing/wall/14.jpg'),
                        ),
                        title: Text('Product Name',
                            style: TextStyle(
                                color: theme,
                                fontSize: 16,
                                fontWeight: FontWeight.w500)),
                        subtitle: Text('Product Description',
                            style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 12,
                                fontWeight: FontWeight.w400)),
                        trailing: Text('\$ 100',
                            style: TextStyle(
                                color: theme,
                                fontSize: 16,
                                fontWeight: FontWeight.w500)),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
