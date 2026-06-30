method GetHelloWorld(langCode : string) returns (greeting: string)
  requires langCode in {"en", "es", "fr", "de"}
{
    var greetings := map[
        "en" := "Hello World!",
        "es" := "Hola, Mundo!",
        "fr" := "Bonjour, le monde!",
        "de" := "Hallo, Welt!"
    ];

    greeting := greetings[langCode];
}

method Main () {
    var text := GetHelloWorld("de");
    print text;
}