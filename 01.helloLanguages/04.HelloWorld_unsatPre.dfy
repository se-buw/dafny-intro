method GetHelloWorld(langCode : string) returns (greeting: string)
  requires langCode in {"en", "es", "fr"}
{
    var greetings := map[
        "en" := "Hello World!",
        "es" := "Hola, Mundo!",
        "fr" := "Bonjour, le monde!"
    ];

    greeting := greetings[langCode];
}

method Main () {
    var text := GetHelloWorld("de");
    print text;
}