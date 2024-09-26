
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:animalswitcher/main.dart';

// Mock dependencies if necessary
class MockAnimalCubit extends MockCubit<Animal> implements AnimalCubit {}

void main() {
	group('Main App Initialization', () {
		testWidgets('App initializes with HomeScreen', (WidgetTester tester) async {
			await tester.pumpWidget(MyApp());
			expect(find.byType(HomeScreen), findsOneWidget);
		});
	});

	group('AnimalCubit', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = AnimalCubit();
		});

		blocTest<AnimalCubit, Animal>(
			'emits Cat state initially',
			build: () => animalCubit,
			verify: (cubit) => expect(cubit.state.name, equals('Cat')),
		);

		blocTest<AnimalCubit, Animal>(
			'toggles state between Cat and Dog',
			build: () => animalCubit,
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [isA<Animal>().having((a) => a.name, 'name', 'Dog')],
		);
	});

	group('HomeScreen', () {
		testWidgets('Displays AnimalTextWidget', (WidgetTester tester) async {
			await tester.pumpWidget(MaterialApp(home: HomeScreen()));
			expect(find.byType(AnimalTextWidget), findsOneWidget);
		});
	});

	group('AnimalTextWidget', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = MockAnimalCubit();
			when(() => animalCubit.state).thenReturn(Animal('Cat', Icons.pets));
		});

		testWidgets('Displays initial animal state', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: animalCubit,
						child: AnimalTextWidget(),
					),
				),
			);
			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.pets), findsOneWidget);
		});

		testWidgets('Toggles animal state on tap', (WidgetTester tester) async {
			whenListen(
				animalCubit,
				Stream.fromIterable([Animal('Dog', Icons.person)]),
			);

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: animalCubit,
						child: AnimalTextWidget(),
					),
				),
			);

			await tester.tap(find.byType(AnimalTextWidget));
			await tester.pump();

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});
	});
}
