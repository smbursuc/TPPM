void exercitiul1(List<String> arguments)
{
  String numar = "";
  for (int i=0;i<arguments.length;i++)
  {
    numar += arguments[i];
  }
  int nr = int.parse(numar);
  nr += 1;
  String nr_string = nr.toString();
  var l = List<int>.filled(arguments.length,0, growable: true);
  if(nr_string.length != arguments.length)
  {
    l.insert(0, 0);
  }
  for (int i=0;i<nr_string.length;i++)
  {
    l[i] = int.parse(nr_string[i]);
  }
  print(l);
}

void exercitiul2(List<String> arguments)
{
  String sequence = arguments[arguments.length-1];
  List<String> cost_list = arguments.sublist(0,arguments.length-1);
  var costs = Map<String,int>();
  for (int i=0;i<cost_list.length;i+=2)
  {
    costs.addEntries([MapEntry(cost_list[i],int.parse(cost_list[i+1]))]);
  }
  int sum = 0;
  for(int i=0;i<sequence.length;i++)
  {
    if(costs[sequence[i]] != null)
    {
      int cost = int.parse(costs[sequence[i]].toString());
      sum += cost;
    }
  }
  print(sum);
}

void exercitiul3()
{
  var list = [1,1,2,2,3,4,1,2,9,10];
  for(int i=0;i<list.length;i++)
  {
    for(int j=i+1;j<list.length;j++)
    {
      if(list[i] == list[j])
      {
        var s = Set<int>();
        s.add(i);
        s.add(j);
        print(s);
      }
    }
  }
}

int sum_of_digits(int n)
{
  int sum = 0;
  while(n>0)
  {
    sum += n%10;
    n = n~/10;
  }
  return sum;
}

void exercitiul4()
{
  int n = 13;
  var sums = Map<int,List<int>>();
  for (int i=0;i<=n;i++)
  {
    sums.update(sum_of_digits(i), (existingList) => [...existingList, i], ifAbsent: () => [i]);
  }
  int max = 0;
  for(List<int> l in sums.values)
  {
    if(l.length > max)
      max = l.length;
  }
  int res = 0;
  for(List<int> l in sums.values)
  {
    if(l.length == max)
      res+=1;
  }
  print(res);

}
void main(List<String> arguments)
{
  exercitiul4();
}