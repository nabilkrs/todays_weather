class Location{
String name;
String region;
String country;
String localtime;
Location({this.name,this.region,this.country,this.localtime});
factory Location.fromJSON(Map<String,dynamic> post){
return Location(name:post['location']['name'],
region:post['location']['region'],
country:post['location']['country'],
localtime:post['location']['localtime']);
}
}