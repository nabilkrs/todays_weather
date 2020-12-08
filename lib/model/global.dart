class Global{
double windkph;
int humidity;
int cloud;
String winddir;
int winddegree;
Global({this.windkph,this.humidity,this.cloud, this.winddir,this.winddegree});
factory Global.fromJSON(Map<String,dynamic> post){
return Global(windkph:post['current']['wind_kph'],
humidity:post['current']['humidity'],
cloud:post['current']['cloud'],
winddir:post['current']['wind_dir'],
winddegree:post['current']['wind_degree'],
);
}
}