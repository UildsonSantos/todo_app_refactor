import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider_refactor/pages/todos_pages.dart';
import 'package:todo_provider_refactor/providers/providers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TodoFilter>(
          create: (context) => TodoFilter(),
        ),
        ChangeNotifierProvider<TodoSearch>(
          create: (context) => TodoSearch(),
        ),
        ChangeNotifierProvider<TodoList>(
          create: (context) => TodoList(),
        ),
        ProxyProvider<TodoList, ActiveTodoCount>(
            update: (
          BuildContext context,
          TodoList todoList,
          ActiveTodoCount? _,
        ) =>
                ActiveTodoCount(todoList: todoList)),
        ProxyProvider3<TodoFilter, TodoSearch, TodoList, FilteredTodos>(
          update: (
            BuildContext context,
            TodoFilter todoFilter,
            TodoSearch todoSearch,
            TodoList todoList,
            FilteredTodos? _,
          ) =>
              FilteredTodos(
            todoFilter: todoFilter,
            todoSearch: todoSearch,
            todoList: todoList,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'TODOS',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const TodosPage(),
      ),
    );
  }
}
