import 'package:econexus/common/drawer_file.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EcoChampionLeaderboardScreen extends StatefulWidget {
  @override
  _EcoChampionLeaderboardScreenState createState() =>
      _EcoChampionLeaderboardScreenState();
}

class _EcoChampionLeaderboardScreenState
    extends State<EcoChampionLeaderboardScreen> {
  List<LeaderboardEntry> leaderboardEntries = [];

  @override
  void initState() {
    super.initState();
    // Initialize Firebase
    Firebase.initializeApp();

    // Fetch and populate leaderboard entries from Firestore
    fetchLeaderboardEntries();
  }

  Future<void> fetchLeaderboardEntries() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firestore.collection('users').get();

    // Clear the previous entries
    leaderboardEntries.clear();

    // Iterate through the documents
    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      final String name = document['name'];
      final String carbonEmissionsString = document['carbonEmissions'];

      // Parse carbonEmissions as an integer
      final int carbonEmissions = int.tryParse(carbonEmissionsString) ?? 0;

      leaderboardEntries.add(LeaderboardEntry(
        rank: leaderboardEntries.length + 1,
        name: name,
        score: carbonEmissions,
      ));
    }

    // Sort the leaderboardEntries based on the score in descending order
    leaderboardEntries.sort((a, b) => b.score.compareTo(a.score));

    // Update the UI
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('EcoChampion Leaderboard'),
      ),
      body: Column(
        children: [
          _buildPodium(leaderboardEntries.sublist(
              0, 3)), // Display the top 3 on the podium
          Expanded(
            child: ListView.builder(
              itemCount: leaderboardEntries.length - 3,
              itemBuilder: (context, index) {
                final entry = leaderboardEntries[index + 3];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Text(
                      '${entry.rank}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(entry.name),
                  subtitle: Text('${entry.score} points'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPodium(List<LeaderboardEntry> topEntries) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Image(
              image: NetworkImage(
                  'https://t4.ftcdn.net/jpg/04/97/80/59/360_F_497805961_J9lXyoKT0aTfHmfz1rCRo0pPzJweLJ1A.jpg'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: topEntries.map((entry) {
              return _buildPodiumItem(entry.rank, entry.name, entry.score);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPodiumItem(int rank, String name, int score) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.green,
          child: Text(
            '$rank',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '$score points',
          style: TextStyle(
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}

class LeaderboardEntry {
  final int rank;
  final String name;
  final int score;

  LeaderboardEntry({
    required this.rank,
    required this.name,
    required this.score,
  });
}
