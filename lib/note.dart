// To create the logic for weather app:
// 1. Get data from API from the web to get real time data
// (to do this we need htttp package, so we install the http plugin)
// 2. Get proper loading indicators, error indicators
// 3.
//  @override
//   State<WeatherScreen> createState() => _WeatherScreenState();
// }

// class _WeatherScreenState extends State<WeatherScreen> {
//   // 'late' is used to assign sth before the build function is called, you also have to use temp within this build function
//   // late double temp;
//   double temp = 0;

//   @override
//   void initState() {
//     super.initState();
//     // print('initState');
//     getCurrentWeather();
//   }

//   // 1.create a function

//   Future getCurrentWeather() async {
//     // print('fn called');
//     try {
//       String cityName = 'London';
//       final res = await http.get(
//         Uri.parse(
//             'https://api.openweathermap.org/data/2.5/forecast?q=$cityName,uk&APPID=$openWeatherAPIKey'),
//       );

//       // print('api ended');
//       final data = jsonDecode(res.body);

//       if (data['cod'] != '200') {
//         throw 'An unexpected error occured Yemi';
//       }
//       setState(() {
//         temp = data['list'][0]['main']['temp'];
//       });
//     } catch (e) {
//       throw e.toString();
//     }
//   }