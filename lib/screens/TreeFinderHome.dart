import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'TreeDetailScreen.dart';

class TreeFinderHome extends StatefulWidget {
  const TreeFinderHome({Key? key}) : super(key: key);

  @override
  _TreeFinderHomeState createState() => _TreeFinderHomeState();
}

class _TreeFinderHomeState extends State<TreeFinderHome> {
  List<Tree> trees = [];
  List<Tree> filteredTrees = [];
  TextEditingController searchController = TextEditingController();
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadTrees();
    searchController.addListener(_filterTrees);
  }

  Future<void> _loadTrees() async {
    try {
      final response = await http.get(Uri.parse(
          'https://9ce4-200-17-83-162.ngrok-free.app/getArvores'),
          headers: {
            "ngrok-skip-browser-warning": "69420",
            'Access-Control-Allow-Origin': "*"
          });

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        setState(() {
          trees = jsonData.map((json) => Tree.fromJson(json)).toList();
          filteredTrees = trees;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Falha ao carregar dados da API';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro de conexão: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  void _filterTrees() {
    setState(() {
      filteredTrees = trees
          .where((tree) => tree.name
          .toLowerCase()
          .contains(searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.green,
            padding: const EdgeInsets.only(top: 50, bottom: 10, left: 16, right: 16),
            child: Row(
              children: [
                Image.asset(
                  'assets/icon.png',
                  width: 30,
                  height: 30,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Find Tree',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Pesquisar árvore...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          if (_isLoading)
            const Expanded(
              child: Center(child: CircularProgressIndicator())
            )
          else if (_errorMessage.isNotEmpty)
            Expanded(
              child: Center(
                child: Text(
                  _errorMessage, 
                  style: TextStyle(color: Colors.red)
                )
              )
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: filteredTrees.length,
                itemBuilder: (context, index) {
                  return TreeCard(tree: filteredTrees[index]);
                },
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}

class TreeCard extends StatelessWidget {
  final Tree tree;

  const TreeCard({Key? key, required this.tree}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TreeDetailScreen(tree: tree),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  tree.imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tree.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tree.description,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Tree {
  final int id;
  final String name;
  final String description;
  final String imageUrl;

  Tree({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl = 'assets/icon.png', // Imagem padrão
  });

  factory Tree.fromJson(Map<String, dynamic> json) {
    return Tree(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      // Se a API fornecer uma URL de imagem, use-a, senão use a padrão
      imageUrl: json['imageUrl'] ?? 'assets/icon.png',
    );
  }

  factory Tree.fromMap(Map<String, dynamic> map) {
    return Tree(
      id: map['id'] as int,
      name: map['nome'] as String,
      description: map['descricao'] as String,
      imageUrl: map['imageUrl'] ?? 'assets/icon.png',
    );
  }
}