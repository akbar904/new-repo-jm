
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animalswitcher/screens/home_screen.dart';
import 'package:animalswitcher/cubits/animal_cubit.dart';
import 'package:animalswitcher/widgets/animal_text_widget.dart';

// Mock the AnimalCubit
class MockAnimalCubit extends MockCubit<Animal> implements AnimalCubit {}

void main() {
	group('HomeScreen Widget Tests', () {
		late MockAnimalCubit mockAnimalCubit;

		setUp(() {
			mockAnimalCubit = MockAnimalCubit();
		});

		testWidgets('displays Cat text with clock icon initially', (WidgetTester tester) async {
			when(() => mockAnimalCubit.state).thenReturn(Animal(name: 'Cat', icon: Icons.access_time));

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AnimalCubit>(
						create: (context) => mockAnimalCubit,
						child: HomeScreen(),
					),
				),
			);

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('displays Dog text with person icon when clicked', (WidgetTester tester) async {
			when(() => mockAnimalCubit.state).thenReturn(Animal(name: 'Cat', icon: Icons.access_time));

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AnimalCubit>(
						create: (context) => mockAnimalCubit,
						child: HomeScreen(),
					),
				),
			);

			// Tap on the AnimalTextWidget to trigger the state change
			await tester.tap(find.byType(AnimalTextWidget));
			await tester.pump();

			// Verify the state change to Dog
			when(() => mockAnimalCubit.state).thenReturn(Animal(name: 'Dog', icon: Icons.person));
			mockAnimalCubit.emit(Animal(name: 'Dog', icon: Icons.person));

			await tester.pump();

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});
	});
}
