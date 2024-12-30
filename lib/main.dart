import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'pages/login_screen/screen/login_screen.dart';
import 'pages/splash_screen.dart';

/// Entrypoint of the application.


// void main() {
//   runApp(const MyApp());
// }
//
// /// [Widget] building the [MaterialApp].
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Dock(
//             items: const [
//               Icons.person,
//               Icons.message,
//               Icons.call,
//               Icons.camera,
//               Icons.photo,
//             ],
//             builder: (e) {
//               return Container(
//                 constraints: const BoxConstraints(minWidth: 48),
//                 height: 48,
//                 margin: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                   color: Colors.primaries[e.hashCode % Colors.primaries.length],
//                 ),
//                 child: Center(child: Icon(e, color: Colors.white)),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// /// Dock of the reorderable [items].
// class Dock<T extends Object> extends StatefulWidget {
//   const Dock({
//     super.key,
//     this.items = const [],
//     required this.builder,
//   });
//
//   /// Initial [T] items to put in this [Dock].
//   final List<T> items;
//
//   /// Builder building the provided [T] item.
//   final Widget Function(T) builder;
//
//   @override
//   State<Dock<T>> createState() => _DockState<T>();
// }
//
// /// State of the [Dock] used to manipulate the [_items].
// class _DockState<T extends Object> extends State<Dock<T>> {
//   /// [T] items being manipulated.
//   late final List<T> _items = widget.items.toList();
//
//   T? _draggingItem;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         color: Colors.black12,
//       ),
//       padding: const EdgeInsets.all(4),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: List.generate(_items.length, (index) {
//           final item = _items[index];
//           return DragTarget<T>(
//             onWillAccept: (draggedItem) {
//               if (draggedItem == null || draggedItem == item) return false;
//               setState(() {
//                 _items.remove(draggedItem);
//                 _items.insert(index, draggedItem);
//               });
//               return true;
//             },
//             onAccept: (_) {},
//             builder: (context, candidateData, rejectedData) {
//               return AnimatedSwitcher(
//                 duration: const Duration(milliseconds: 300),
//                 transitionBuilder: (child, animation) => ScaleTransition(
//                   scale: animation,
//                   child: child,
//                 ),
//                 child: _draggingItem == item
//                     ? const SizedBox(width: 48, height: 48)
//                     : Draggable<T>(
//                         key: ValueKey(item),
//                         data: item,
//                         feedback: Material(
//                           color: Colors.transparent,
//                           child: widget.builder(item),
//                         ),
//                         onDragStarted: () {
//                           setState(() {
//                             _draggingItem = item;
//                           });
//                         },
//                         onDragEnd: (_) {
//                           setState(() {
//                             _draggingItem = null;
//                           });
//                         },
//                         child: widget.builder(item),
//                       ),
//               );
//             },
//           );
//         }),
//       ),
//     );
//   }
// }

/// Entrypoint of the application.
// void main() {
//   runApp(const MyApp());
// }
//
// /// [Widget] building the [MaterialApp].
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Dock(
//             items: const [
//               Icons.person,
//               Icons.message,
//               Icons.call,
//               Icons.camera,
//               Icons.photo,
//             ],
//             builder: (e) {
//               return Container(
//                 constraints: const BoxConstraints(minWidth: 48),
//                 height: 48,
//                 margin: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                   color: Colors.primaries[e.hashCode % Colors.primaries.length],
//                 ),
//                 child: Center(child: Icon(e, color: Colors.white)),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// /// Dock of the reorderable [items].
// class Dock<T extends Object> extends StatefulWidget {
//   const Dock({
//     super.key,
//     this.items = const [],
//     required this.builder,
//   });
//
//   /// Initial [T] items to put in this [Dock].
//   final List<T> items;
//
//   /// Builder building the provided [T] item.
//   final Widget Function(T) builder;
//
//   @override
//   State<Dock<T>> createState() => _DockState<T>();
// }
//
// /// State of the [Dock] used to manipulate the [_items].
// class _DockState<T extends Object> extends State<Dock<T>> {
//   /// [T] items being manipulated.
//   late final List<T> _items = widget.items.toList();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         color: Colors.black12,
//       ),
//       padding: const EdgeInsets.all(4),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: _items.map((item) {
//           return Draggable<T>(
//             data: item,
//             feedback: Material(
//               color: Colors.transparent,
//               child: widget.builder(item),
//             ),
//             childWhenDragging: Opacity(
//               opacity: 0.5,
//               child: widget.builder(item),
//             ),
//             onDragCompleted: () {},
//             child: DragTarget<T>(
//               onWillAccept: (data) => true,
//               onAccept: (receivedItem) {
//                 setState(() {
//                   int oldIndex = _items.indexOf(receivedItem);
//                   int newIndex = _items.indexOf(item);
//                   _items.removeAt(oldIndex);
//                   _items.insert(newIndex, receivedItem);
//                 });
//               },
//               builder: (context, candidateData, rejectedData) {
//                 return widget.builder(item);
//               },
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

// ________
Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter binding is initialized
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(393, 852));


    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // Main Color

      routes: {
        // SplashScreen.routeName: (context) => const SplashScreen(),
        LoginScreen.routeName: (context) => SplashScreen(),
        //CreateAccountScreen.routeName: (context) => const CreateAccountScreen(),
        //SignUpPage.routeName: (context) => const SignUpPage(),
        //ForgetPasswordScreen.routeName: (context) => const ForgetPasswordScreen(),
        //HomeScreen.routeName: (context) => const HomeScreen(),
      },
    );
  }
}

//______
// return ScreenUtilInit(
//   designSize: const Size(393, 852),
//   minTextAdapt: true,
//   splitScreenMode: true,
//
//   child: MaterialApp(
//     debugShowCheckedModeBanner: false,
//     // Main Color
//
//     routes: {
//       // SplashScreen.routeName: (context) => const SplashScreen(),
//       LoginScreen.routeName: (context) => const LoginScreen(),
//       //CreateAccountScreen.routeName: (context) => const CreateAccountScreen(),
//       //SignUpPage.routeName: (context) => const SignUpPage(),
//       //ForgetPasswordScreen.routeName: (context) => const ForgetPasswordScreen(),
//       //HomeScreen.routeName: (context) => const HomeScreen(),
//     },
//   ),
// );
// import 'package:bima_gyaan/pages/splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// Future<void> main() async {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return const ScreenUtilInit(
//       designSize: Size(393, 852),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: SplashScreen(),
//       ),
//     );
//   }
// }
