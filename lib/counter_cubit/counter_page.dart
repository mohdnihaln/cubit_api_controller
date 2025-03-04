import 'package:cubic_api_controller/fetchApi/fetchApi_controller.dart';
import 'package:cubic_api_controller/fetchApi/fetchApi_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        title: Text('Fetch API Data'),
      ),
      body: Center(
        child: BlocBuilder<FetchCubit, List<Product>?>(
          builder: (context, data) {
            if (data == null) {
              return CircularProgressIndicator(); // Show loading indicator
            }
            if (data.isEmpty) {
              return Text(
                "No data available",
                style: TextStyle(fontSize: 18, color: Colors.red),
              );
            }
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];

                return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Card(
                    color: Colors.grey[200],
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.purple,
                        child: Text(
                          item.id.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(item.title ?? 'No title'),
                      subtitle: Text(
                        "\$${item.price?.toStringAsFixed(2) ?? 'N/A'}",
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(80, 80),
          backgroundColor: Colors.purple[300],
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.black,
        ),
        child: const Icon(Icons.cloud_download, size: 40, color: Colors.white),
        onPressed: () => context.read<FetchCubit>().fetchApi(),
      ),
    );
  }
}
