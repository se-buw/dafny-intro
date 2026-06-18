/*
  We have added German ("de") to our "approved list" of languages, but the dictionary entry for German is an empty string.

  Dafny cannot prove the ensures clause, but it cannot detect that the dictionary entry for German is an empty string. The program will execute, but it will not produce a German greeting.
*/

method GetHelloWorld(langCode: string) returns (greeting: string)
  // THE RULE: The language code must be in our "approved list" (a set).
  requires langCode in {"en", "es", "fr", "de"}
  
  // THE PROMISE: The machine will never give you an empty string.
  ensures |greeting| > 0
{
  // A 'map' links a Key (left) to a Value (right).
  var dictionary := map[
    "en" := "Hello, World!",
    "es" := "Hola, Mundo!",
    "fr" := "Bonjour, le Monde!",
    "de" := ""
  ];
  
  greeting := dictionary[langCode];
}

method Main() {
  // This works perfectly!
  var myGreeting := GetHelloWorld("es");
  print myGreeting;

  var badGreeting := GetHelloWorld("de"); // This will fail to produce a German greeting! Nothing is detected by Dafny.
  print badGreeting;

}