/*
  We have removed one of the languages from our "approved list" (French, "fr"), but it is present in our dictionary.

  Dafny will detect an error when we try to call the method with "fr" as an argument, because it does not satisfy the requires clause. However, an execution of the program will work perfectly.
*/

method GetHelloWorld(langCode: string) returns (greeting: string)
  // THE RULE: The language code must be in our "approved list" (a set).
  requires langCode in {"en", "es"}
  
  // THE PROMISE: The machine will never give you an empty string.
  ensures |greeting| > 0
{
  // A 'map' links a Key (left) to a Value (right).
  var dictionary := map[
    "en" := "Hello, World!",
    "es" := "Hola, Mundo!",
    "fr" := "Bonjour, le Monde!"
  ];
  
  greeting := dictionary[langCode];
}

method Main() {
  // This works perfectly!
  var myGreeting := GetHelloWorld("es");
  print myGreeting;

  var badGreeting := GetHelloWorld("fr"); // This is highlighted to fail by Dafny! However, it executes perfectly fine.
  print badGreeting;

}