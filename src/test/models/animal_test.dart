
import 'package:flutter_test/flutter_test.dart';
import 'package:animalswitcher/models/animal.dart';

void main() {
	group('Animal Model Tests', () {
		test('Animal model should have name and icon properties', () {
			// Arrange
			const animal = Animal(name: 'Cat', icon: Icons.pets);

			// Assert
			expect(animal.name, 'Cat');
			expect(animal.icon, Icons.pets);
		});

		test('Animal model should support serialization and deserialization', () {
			// Arrange
			const animal = Animal(name: 'Dog', icon: Icons.person);
			final animalJson = {'name': 'Dog', 'icon': Icons.person.codePoint};

			// Act
			final serialized = animal.toJson();
			final deserialized = Animal.fromJson(animalJson);

			// Assert
			expect(serialized, animalJson);
			expect(deserialized.name, 'Dog');
			expect(deserialized.icon, Icons.person);
		});
	});
}
