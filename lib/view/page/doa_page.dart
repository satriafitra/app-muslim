import 'package:flutter/material.dart';
import 'package:muslim_app/viewmodel/doa_viewmodel.dart';
import 'package:provider/provider.dart';

class DoaPage extends StatefulWidget {
  const DoaPage({super.key});

  @override
  State<DoaPage> createState() => _DoaPageState();
}

class _DoaPageState extends State<DoaPage> {
  String id = '7';

  @override
  void initState() {
    super.initState();
    // Memanggil fetchDoa ketika widget pertama kali dibangun
    Future.microtask(() {
      context.read<DoaViewModel>().fetchDoa(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Sholat'),
      ),
      body: Consumer<DoaViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewModel.errorMessage != null) {
            return Center(child: Text(viewModel.errorMessage!));
          } else if (viewModel.doa == null) {
            return const Center(child: Text('No schedule available.'));
          } else {
            final doa = viewModel.doa!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Doa: ${doa.doa}'),
                  Text('Ayat: ${doa.ayat}'),
                  Text('Latin: ${doa.latin}'),
                  Text('Artinya: ${doa.artinya}'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
