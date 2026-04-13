/*
  We added a new language to our "approved list" (German, "de"), but we forgot to add it to our dictionary. 
  
  Dafny will catch this error. It cannot prove the ensures clause.
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
    "fr" := "Bonjour, le Monde!"
  ];
  
  greeting := dictionary[langCode];
}

method Main() {
  // This works perfectly!
  var myGreeting := GetHelloWorld("es");
  print myGreeting;

  var badGreeting := GetHelloWorld("de"); // This will fail! Dafny will show the error elsewhere as this call complied to the requires clause, but the ensures clause cannot be proven.
  print badGreeting;

}