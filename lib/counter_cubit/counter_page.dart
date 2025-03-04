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
        title: Text('Products'),
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
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two items per row
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75, // Adjusted to remove extra space
                ),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final item = data[index];

                  // Handle image (if it's not a valid URL, use placeholder)
                  String imageUrl =
                      item.image is String
                          ? item.image!
                          : "https://via.placeholder.com/150";

                  return Card(
                    elevation: 0.5, // for background shadow
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Image (Expanded to remove space)
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                            child: Image.network(
                              imageUrl,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (context, error, stackTrace) =>
                                      Icon(Icons.broken_image, size: 50),
                            ),
                          ),
                        ),
                        // Product Details (No extra space)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 5,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Product Title
                              Text(
                                item.title ?? 'No title',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              // Price, Old Price, and Discount
                              Row(
                                children: [
                                  Text(
                                    "₹${item.price?.toStringAsFixed(0) ?? 'N/A'}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "₹${(item.price! * 1.5).toStringAsFixed(0)}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "-${((1 - (item.price! / (item.price! * 1.5))) * 100).toStringAsFixed(0)}%",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 3),
                              // Purchase Info
                              Text(
                                "100+ bought in past month",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(50, 80),
          backgroundColor: Colors.purple[300],
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.black,
        ),
        child: const Icon(Icons.cloud_download, size: 30, color: Colors.white),
        onPressed: () => context.read<FetchCubit>().fetchApi(),
      ),
    );
  }
}
