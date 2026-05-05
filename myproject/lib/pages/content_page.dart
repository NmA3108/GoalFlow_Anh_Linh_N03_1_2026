import 'package:flutter/material.dart';

class ContentPage extends StatelessWidget {
  const ContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Content"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // 🔥 HEADER
              const Text(
                "Title",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const Text("Subtitle"),
              const SizedBox(height: 20),

              // 🔥 BANNER (có ảnh)
              Row(
                children: [
                  Expanded(child: _buildBanner(1)),
                  const SizedBox(width: 10),
                  Expanded(child: _buildBanner(2)),
                ],
              ),

              const SizedBox(height: 30),

              // 🔥 SECTION 1
              const Text("Heading",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const Text("Subheading"),
              const SizedBox(height: 10),

              Column(
                children: List.generate(3, (index) {
                  return _buildListItem(index);
                }),
              ),

              const SizedBox(height: 30),

              // 🔥 SECTION 2
              const Text("Heading",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const Text("Subheading"),
              const SizedBox(height: 10),

              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: List.generate(6, (index) {
                  return _buildGridItem(index);
                }),
              ),

              const SizedBox(height: 30),

              const Center(
                child: Text("© 2026 Your Team"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Banner (ảnh thật)
  Widget _buildBanner(int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        "https://picsum.photos/300/200?random=$index",
        height: 120,
        fit: BoxFit.cover,
      ),
    );
  }

  // 🔹 List item (có ảnh)
  Widget _buildListItem(int index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            "https://picsum.photos/100?random=$index",
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text("Title ${index + 1}"),
        subtitle: const Text(
          "Body text for whatever you'd like to say.",
        ),
        trailing: ElevatedButton(
          onPressed: () {},
          child: const Text("View"),
        ),
      ),
    );
  }

  // 🔹 Grid item (có ảnh)
  Widget _buildGridItem(int index) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.network(
                "https://picsum.photos/200?random=$index",
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            "Item ${index + 1}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}