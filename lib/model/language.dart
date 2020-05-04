class language{
final int id ;
final String name;
final String flage;
final String langCode;

language(this.id, this.name, this.flage, this.langCode);


static List<language>languageList(){

return<language>[
  language(1,  "English", "🇺🇸","en"),
  language(2,  "العربيه","🇪🇬", "ar"),
  language(3,  "France","🇫🇷", "fr"),

];

}


}