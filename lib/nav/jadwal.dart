// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';

class Jadwal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CollapsibleCard(
          title: 'Kelas : C2.3',
          child: JadwalTable(
            data: [
              ['Kode 1', 'Mata Kuliah 1', 'Dosen 1', 'Hari 1', 'Jam 1'],
              ['Kode 2', 'Mata Kuliah 2', 'Dosen 2', 'Hari 2', 'Jam 2'],
              ['Kode 2', 'Mata Kuliah 2', 'Dosen 2', 'Hari 2', 'Jam 2'],
              ['Kode 2', 'Mata Kuliah 2', 'Dosen 2', 'Hari 2', 'Jam 2'],
              ['Kode 2', 'Mata Kuliah 2', 'Dosen 2', 'Hari 2', 'Jam 2'],
              ['Kode 2', 'Mata Kuliah 2', 'Dosen 2', 'Hari 2', 'Jam 2'],
              // Tambahkan data tabel lainnya sesuai kebutuhan
            ],
          ),
        ),
        CollapsibleCard(
          title: 'Kelas : C2.2',
          child: JadwalTable(
            data: [
              // Data tabel untuk kelas C2.2
            ],
          ),
        ),
        CollapsibleCard(
          title: 'Kelas : C2.4',
          child: JadwalTable(
            data: [
              // Data tabel untuk kelas C2.4
            ],
          ),
        ),
      ],
    );
  }
}

class CollapsibleCard extends StatefulWidget {
  final String title;
  final Widget child;

  const CollapsibleCard({
    required this.title,
    required this.child,
  });

  @override
  _CollapsibleCardState createState() => _CollapsibleCardState();
}

class _CollapsibleCardState extends State<CollapsibleCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
      if (_expanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(widget.title),
            trailing: AnimatedIcon(
              icon: AnimatedIcons.arrow_menu,
              progress: _animation,
            ),
            onTap: _toggleExpanded,
          ),
          SizeTransition(
            sizeFactor: _animation,
            child: widget.child,
          ),
        ],
      ),
    );
  }
}

class JadwalTable extends StatelessWidget {
  final List<List<String>> data;

  const JadwalTable({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Table(
        columnWidths: {
          0: FractionColumnWidth(.15),
          1: FractionColumnWidth(.25),
          2: FractionColumnWidth(.2),
          3: FractionColumnWidth(.15),
          4: FractionColumnWidth(.15),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
            ),
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Kode'),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Mata Kuliah'),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Dosen'),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Hari'),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Jam'),
                ),
              ),
            ],
          ),
          for (final rowData in data)
            TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(rowData[0]),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(rowData[1]),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(rowData[2]),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(rowData[3]),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(rowData[4]),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
