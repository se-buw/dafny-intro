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
    "de" := "Bonjour, le Monde!" // copy paste
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