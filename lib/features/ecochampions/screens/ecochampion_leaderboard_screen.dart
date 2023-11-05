import 'package:econexus/common/drawer_file.dart';
import 'package:flutter/material.dart';

class EcoChampionLeaderboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Sample leaderboard data, replace this with your actual data
    final List<LeaderboardEntry> leaderboardEntries = [
      LeaderboardEntry(rank: 1, name: 'User 1', score: 1500),
      LeaderboardEntry(rank: 2, name: 'User 2', score: 1400),
      LeaderboardEntry(rank: 3, name: 'User 3', score: 1300),
      LeaderboardEntry(rank: 4, name: 'User 4', score: 1200),
      LeaderboardEntry(rank: 5, name: 'User 5', score: 1100),
      LeaderboardEntry(rank: 6, name: 'User 6', score: 1000),
      // Add more entries
    ];

    // Sort the leaderboardEntries based on the score in descending order
    leaderboardEntries.sort((a, b) => b.score.compareTo(a.score));

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('EcoChampion Leaderboard'),
      ),
      body: Column(
        children: [
          _buildPodium(leaderboardEntries.sublist(0, 3)),
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
