
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:animalswitcher/models/animal.dart';

class AnimalCubit extends Cubit<Animal> {
	AnimalCubit() : super(Animal(name: 'Cat', icon: Icons.pets));

	void toggleAnimal() {
		if (state.name == 'Cat') {
			emit(Animal(name: 'Dog', icon: Icons.person));
		} else {
			emit(Animal(name: 'Cat', icon: Icons.pets));
		}
	}
}
