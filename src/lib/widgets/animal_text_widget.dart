
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/animal_cubit.dart';
import '../models/animal.dart';

class AnimalTextWidget extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		final animalCubit = context.watch<AnimalCubit>();
		final animal = animalCubit.state;

		return GestureDetector(
			onTap: () => animalCubit.toggleAnimal(),
			child: Row(
				children: [
					Icon(animal.icon),
					SizedBox(width: 8),
					Text(animal.name),
				],
			),
		);
	}
}
