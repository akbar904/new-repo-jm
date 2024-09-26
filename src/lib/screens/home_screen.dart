
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animalswitcher/cubits/animal_cubit.dart';
import 'package:animalswitcher/widgets/animal_text_widget.dart';

class HomeScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Animal Switcher'),
			),
			body: Center(
				child: BlocBuilder<AnimalCubit, Animal>(
					builder: (context, animal) {
						return GestureDetector(
							onTap: () => context.read<AnimalCubit>().toggleAnimal(),
							child: AnimalTextWidget(animal: animal),
						);
					},
				),
			),
		);
	}
}
