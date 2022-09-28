import 'dart:convert';

import 'package:quiz_ui/src/features/home/data/questions.dart';

final questions = [
  {"Question": "Who created Ruby on Rails?", "a": "Paul Graham", "b": "DHH", "c": "Bill Gates", "d": "Tom Watson", "correct": "b"},
  {"Question": "What is Albania's capital?", "a": "Shvana", "b": "Dublin", "c": "Sokdre", "d": "Tirana", "correct": "d"},
  {"Question": "What company created Kotlin?", "a": "Github", "b": "JetBrains", "c": "Google", "d": "Facebook", "correct": "b"},
  {"Question": "Who founded HungerStation?", "a": "Ahmad Al-Ghamdi", "b": "Ghassab Al-Mandil", "c": "Ibrahim Al-Jassem", "d": "Ahmad Al-Zaini", "correct": "c"},
  {"Question": "What company created TypeScript?", "a": "Microsoft", "b": "JetBrains", "c": "Google", "d": "Facebook", "correct": "a"},
  {"Question": "What is the capital of Brazil?", "a": "Rio", "b": "Donka", "c": "Brasilia", "d": "Ornez", "correct": "c"},
  {"Question": "What company created React?", "a": "Microsoft", "b": "JetBrains", "c": "Google", "d": "Facebook", "correct": "d"},
  {"Question": "What company created AngularJS?", "a": "Microsoft", "b": "JetBrains", "c": "Google", "d": "Facebook", "correct": "c"},
  {"Question": "Who founded IBM?", "a": "Jeff Davis", "b": "Tom Watson", "c": "Niel Venet", "d": "Bill Gates", "correct": "b"},
  {"Question": "What famous browser went defunct in 2003?", "a": "Firefox", "b": "Internet Explorer", "c": "Opera", "d": "Netscape", "correct": "d"},
  {"Question": "Who founded Microsoft along with Bill Gates?", "a": "Steve Jobs", "b": "Paul Allen", "c": "Steve Wozniak", "d": "Paul Graham", "correct": "b"},
  {"Question": "Where is Google's HQ?", "a": "Seattle", "b": "Mountain View", "c": "New York", "d": "Chicago", "correct": "b"},
  {"Question": "Where is Microsoft's HQ?", "a": "Redmond", "b": "Mountain View", "c": "Chicago", "d": "Menlo Park", "correct": "a"},
  {"Question": "What's the capital of Germany?", "a": "Frankfurt", "b": "Berlin", "c": "Dona", "d": "Sonitch", "correct": "b"},
  {"Question": "Who is the CEO of Tesla?", "a": "Bill Gates", "b": "Elon Musk", "c": "Eric Ries", "d": "Don Johnson", "correct": "b"},
  {"Question": "Who is the founder of LinkedIn?", "a": "Reid Hoffman", "b": "Alexis Ohanian", "c": "John Wayne", "d": "Eric Ries", "correct": "a"},
  {"Question": "What university did Bill Gates drop out from?", "a": "MIT", "b": "Yale", "c": "Stanford", "d": "Harvard", "correct": "d"},
  {"Question": "Who is the founder of Amazon?", "a": "Jeff Bezos", "b": "John Edwards", "c": "Elon Musk", "d": "Eric Ries", "correct": "a"},
  {"Question": "Which company acquired MailChimp?", "a": "Google", "b": "Meta", "c": "Intuit", "d": "Amazon", "correct": "c"},
  {"Question": "What was Okoul's first challenge?", "a": "Swift", "b": "Node.js", "c": "UI/UX", "d": "Kotlin", "correct": "c"},
  {"Question": "What does \"okoul\" mean?", "a": "Minds", "b": "Employees", "c": "Managers", "d": "Developers", "correct": "a"},
  {"Question": "What company created BlackBerry mobiles?", "a": "Nokia", "b": "RIM", "c": "Google", "d": "Samsung", "correct": "b"},
  {"Question": "What company does IKEA come from?", "a": "UK", "b": "Italy", "c": "Sweden", "d": "Norway", "correct": "c"},
  {"Question": "What is the capital of Canada?", "a": "Toronto", "b": "Calgary", "c": "Montreal", "d": "Ottawa", "correct": "d"},
  {"Question": "What is Amazon's voice service name?", "a": "Alexa", "b": "Siri", "c": "Donna", "d": "Cortana", "correct": "a"},
  {"Question": "Who created Jahez app?", "a": "Ghassab Al-Mandil", "b": "Walid Ismail", "c": "Muhammad Dossary", "d": "Rashed Mutairi", "correct": "a"},
  {"Question": "Who is the CEO of Foodics?", "a": "Ahmad Al-Ghamdi", "b": "Ghassab Al-Mandil", "c": "Ibrahim Al-Jassem", "d": "Ahmad Al-Zaini", "correct": "d"},
  {"Question": "What is the capital of Tunis?", "a": "Tunis", "b": "Rabbat", "c": "Sosa", "d": "Casablanca", "correct": "a"},
  {"Question": "Which company acquired Sun Microsystems", "a": "Microsoft", "b": "Google", "c": "Oracle", "d": "Intuit", "correct": "c"},
  {"Question": "What is the capital of Morocco?", "a": "Casablanca", "b": "Sosa", "c": "Rabbat", "d": "Marakesh", "correct": "c"}
];
final questionsData = questionFromJson(json.encode(questions));
