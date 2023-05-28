/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'TripProvidertest.dart';
import 'object_models.dart';

class PackingListTracker extends StatelessWidget {
  final int tripIndex;

  PackingListTracker({required this.tripIndex});

  @override
  Widget build(BuildContext context) {
    final tripProvider = Provider.of<TripProvider>(context);
    final selectedTrip = tripProvider.getTripByIndex(tripIndex);

    return Scaffold(
      appBar: AppBar(
        title: Text('Packing List'),
      ),
      body: ListView.builder(
        itemCount: selectedTrip?.packing_list?.length ?? 0,
        itemBuilder: (context, index) {
          final packingItem = selectedTrip!.packing_list![index];
          return ListTile(
            title: Text(packingItem.name),
            trailing: Checkbox(
              value: packingItem.isPacked,
              onChanged: (value) {
                tripProvider.updatePackingItem(selectedTrip, index, value ?? false);
              },
            ),
          );
        },
      ),
    );
  }
}

 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'TripProvidertest.dart';
import 'object_models.dart';
import 'add_item_form.dart';

class PackingListTracker extends StatelessWidget {
  final int tripIndex;

  PackingListTracker({required this.tripIndex});

  @override
  Widget build(BuildContext context) {
    final tripProvider = Provider.of<TripProvider>(context);
    final selectedTrip = tripProvider.getTripByIndex(tripIndex);

    return Scaffold(
      appBar: AppBar(
        title: Text('Packing List'),
      ),
      body: ListView.builder(
        itemCount: selectedTrip?.packing_list?.length ?? 0,
        itemBuilder: (context, index) {
          final packingItem = selectedTrip!.packing_list![index];
          return ListTile(
            title: Text(packingItem.name),
            trailing: Checkbox(
              value: packingItem.isPacked,
              onChanged: (value) {
                tripProvider.updatePackingItem(selectedTrip, index, value ?? false);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => AddItemForm(tripIndex: tripIndex),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
