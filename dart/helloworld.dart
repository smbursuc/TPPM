bool isPrime(int x)
{
  if (x==1 || x == 0)
    return false;
  else
    for (int i=2;i<=x/2;i++)
    {
      if (x%i == 0)
        return false;
    }
  return true;
}

void exercitiul1()
{
  int found = 0;
  int nr = 0;
  while(found<100)
  {
    if(isPrime(nr))
    {
      found++;
      print(nr);
    }
    nr++;
  }
}

void exercitiul2()
{
  String phrase = "Iubesc foarte/extrem de mult, materia Dart. Da.";
  final regexp = RegExp(r'\b\w+\b');
  final matches = regexp.allMatches(phrase);
  for (var match in matches) {
    print(phrase.substring(match.start, match.end));
  }
}

void exercitiul3()
{
  String phrase = "I love numbers. 0.44 and 44.";
  final regexp = RegExp(r'\b\d+(\.\d+)?\b');
  final matches = regexp.allMatches(phrase);
  for (var match in matches) {
    print(phrase.substring(match.start, match.end));
  }
}

void exercitiul4()
{
  String UCC = "UpperCamelCase";
  String result = "";
  for (int i=0;i<UCC.length;i++)
  {
    if (UCC[i].toUpperCase() == UCC[i])
    {
      result += "_";
      result += UCC[i].toLowerCase();
    }
    else
      result += UCC[i];
  }
  result = result.substring(1,result.length);
  print(result);

}
void main() {
  //exercitiul1();
  //exercitiul2();
  //exercitiul3();
  exercitiul4();
}
