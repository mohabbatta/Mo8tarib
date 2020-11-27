import 'package:flutter/material.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListItemBuilder<T> extends StatelessWidget {
  const ListItemBuilder({
    Key key,
    @required this.snapshot,
    @required this.itemBuilder,
  }) : super(key: key);
  final AsyncSnapshot<List<T>> snapshot;
  final ItemWidgetBuilder<T> itemBuilder;

  @override
  Widget build(BuildContext context) {
    try {
      if (snapshot.hasData) {
        final List<T> items = snapshot.data;
        if (items.isNotEmpty) {
          return _buildList(items);
        } else {
          return Text('no data');
        }
      } else if (snapshot.hasError) {
        return Text("something wrong");
      }
    } catch (e) {
      print(e.toString());
    }
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildList(List<T> items) {
    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (context, index) => Divider(
        height: 0.5,
      ),
      itemBuilder: (context, index) => itemBuilder(context, items[index]),
    );
  }
}
