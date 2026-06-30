method GetHelloWorld(langCode : string) returns (greeting: string)
  requires langCode in {"en", "es", "fr", "de"}
  ensures |greeting| > 0
  ensures '!' == greeting[|greeting| - 1]
{
    var greetings := map[
        "en" := "Hello World!",
        "es" := "Hola, Mundo!",
        "fr" := "Bonjour, le monde!",
        "de" := "Hallo Welt!",
        "de-ch" := "Grützi"
    ];

    greeting := greetings[langCode];
}

method Main () {
    var text := GetHelloWorld("de");
    print text;
}