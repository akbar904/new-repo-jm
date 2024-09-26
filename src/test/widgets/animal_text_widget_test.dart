
import 'package:flutter_test/flutter_test.dart';
import 'package:animalswitcher/widgets/animal_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animalswitcher/cubits/animal_cubit.dart';
import 'package:mocktail/mocktail.dart';

// Mocking AnimalCubit
class MockAnimalCubit extends MockCubit<Animal> implements AnimalCubit {}

void main() {
	group('AnimalTextWidget', () {
		late MockAnimalCubit mockAnimalCubit;

		setUp(() {
			mockAnimalCubit = MockAnimalCubit();
		});

		testWidgets('displays Cat text and icon initially', (WidgetTester tester) async {
			// Arrange
			when(() => mockAnimalCubit.state).thenReturn(Animal(name: 'Cat', icon: Icons.access_time));

			// Act
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AnimalCubit>.value(
						value: mockAnimalCubit,
						child: AnimalTextWidget(),
					),
				),
			);

			// Assert
			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('displays Dog text and icon when state is toggled', (WidgetTester tester) async {
			// Arrange
			whenListen(
				mockAnimalCubit,
				Stream.fromIterable([Animal(name: 'Dog', icon: Icons.person)]),
				initialState: Animal(name: 'Cat', icon: Icons.access_time),
			);

			// Act
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AnimalCubit>.value(
						value: mockAnimalCubit,
						child: AnimalTextWidget(),
					),
				),
			);
			await tester.pump(); // Pump to reflect the state change

			// Assert
			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});

		testWidgets('toggles animal when tapped', (WidgetTester tester) async {
			// Arrange
			when(() => mockAnimalCubit.state).thenReturn(Animal(name: 'Cat', icon: Icons.access_time));
			when(() => mockAnimalCubit.toggleAnimal()).thenAnswer((_) async {});

			// Act
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AnimalCubit>.value(
						value: mockAnimalCubit,
						child: AnimalTextWidget(),
					),
				),
			);
			await tester.tap(find.byType(GestureDetector));
			await tester.pumpAndSettle();

			// Assert
			verify(() => mockAnimalCubit.toggleAnimal()).called(1);
		});
	});
}
