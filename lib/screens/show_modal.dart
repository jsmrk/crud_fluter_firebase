import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/concern_model.dart';

class ConcernBottomSheet extends StatelessWidget {
  final Concern concern;

  const ConcernBottomSheet(this.concern);

  String getFormattedDate(Concern concern) {
    final dateTime = concern.dateTime;
    final formatter = DateFormat('yyyy-MM-dd'); // Customize format as needed
    return formatter.format(dateTime);
  }

  String getFormattedTime(Concern concern) {
    final dateTime = concern.dateTime;
    final formatter = DateFormat('h:mm a'); // Customize format as needed
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          for (final imageUrl in concern.imageURLs!) Image.network(imageUrl),
          Text(concern.urgency, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 10),
          Text(concern.title, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          Text(concern.description),
          const SizedBox(height: 10),
          Text(concern.location),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(getFormattedDate(concern)),
              Text(getFormattedTime(concern)),
            ],
          ),
        ],
      ),
    );
  }
}
