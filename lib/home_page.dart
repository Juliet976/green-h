import 'package:flutter/material.dart';
import 'package:green_thumb/model.dart';
import 'plant_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Plant> plants = [
    Plant(
      'Bitter Leaf',
      'assets/bitter_leaf.jpg',
      'Bitter leaf is a popular plant in Nigeria known for its medicinal properties. It has a distinct bitter taste and is commonly used in cooking and traditional medicine.',
      'To cultivate bitter leaf, plant stems in well-drained soil. Water regularly and ensure they receive plenty of sunlight. Prune leaves to encourage new growth.',
      'Origin: Native to tropical Africa, widely cultivated in Nigeria and other parts of West Africa.',
      'Challenges: Susceptible to pests like aphids and whiteflies. Ensure proper pest control measures are in place. Also, overwatering can lead to root rot.',
    ),
    Plant(
      'Pawpaw',
      'assets/pawpaw.jpg',
      'Pawpaw, also known as papaya, is a tropical fruit known for its sweet flavor and numerous health benefits. It is rich in vitamins and enzymes.',
      'Pawpaw requires full sun and well-drained, sandy soil. Water regularly and apply fertilizers to promote good fruit production.',
      'Origin: Native to southern Mexico and Central America, it is now cultivated in many tropical and subtropical regions worldwide.',
      'Challenges: Susceptible to diseases like powdery mildew and fruit flies. Regular monitoring and preventive measures are essential for healthy growth.',
    ),
    Plant(
      'Okra',
      'assets/okraw.jpg',
      'Okra is a flowering plant known for its edible green seed pods. It is a common ingredient in many Nigerian dishes, especially soups.',
      'Plant okra in well-drained soil with full sunlight. Water regularly and control weeds to promote healthy growth.',
      'Origin: Okra is believed to have originated in Africa and is widely grown in warm climates around the world.',
      'Challenges: Prone to pests like aphids and caterpillars. It’s important to monitor for signs of pests and apply organic pesticides if necessary.',
    ),
    Plant(
      'Cassava',
      'assets/casava.jpg',
      'Cassava is a woody shrub native to South America. The tuberous roots are a major source of carbohydrates in many tropical countries.',
      'Plant cuttings in loose, well-drained soil. Water regularly until established, and ensure they are in a warm climate.',
      'Origin: Native to South America, it is now a staple food in many parts of Africa.',
      'Challenges: Susceptible to diseases like cassava mosaic disease and pests such as mealybugs. Crop rotation and resistant varieties can help mitigate these issues.',
    ),
    Plant(
      'Pepper',
      'assets/pepper.jpg',
      'Pepper is a spice known for its heat and flavor, used widely in Nigerian cuisine. It comes in various varieties, including bell peppers and chili peppers.',
      'Peppers thrive in warm weather. Plant seeds in rich soil, water regularly, and apply fertilizers for optimal yield.',
      'Origin: Native to Central and South America, it is now cultivated worldwide.',
      'Challenges: Susceptible to diseases such as blossom end rot and fungal infections. Proper watering practices and disease-resistant varieties are recommended.',
    ),
  ];
  List<Plant> filteredPlants = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredPlants = plants; // Initialize filteredPlants with all plants
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      filteredPlants = plants
          .where(
              (plant) => plant.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.green.shade50,
        title: const Text(
          'Green Thumb',
          style: TextStyle(
            color: Colors.green,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
            child: TextField(
              onChanged: updateSearchQuery,
              decoration: InputDecoration(
                hintText: 'Search for a plant...',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.green),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 10),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Popular plant",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                childAspectRatio: 0.8, // Aspect ratio for each grid item
              ),
              itemCount: filteredPlants.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PlantPage(plant: filteredPlants[index]),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              filteredPlants[index].imagePath,
                              width: double
                                  .infinity, // Fill the width of the container
                              height: 150, // Fixed height for consistency
                              fit: BoxFit.cover, // Cover the entire area
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          filteredPlants[index].name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
