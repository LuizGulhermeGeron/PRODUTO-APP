class API{
  static const String dominio = "http://localhost:3000";
  static Uri URL(String inAcesso){
    return Uri.parse("$dominio/$inAcesso");
  } 
}