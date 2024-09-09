class StatDateModel {
  final List<dynamic> time; //시간별 평균량(고정)
  final List<dynamic> days; //한달 기준 각 날의 평균(고정)
  final List<dynamic> weeks; //한달 기준 각 주의 평균(이번 주가 4번째에 존재, 3주전이 1번째에)
  final List<dynamic> months; //1년 기준 각 월의 퍙균(고정)
  final List<dynamic> dayWeek; //요일 기준 일주일의 평균

  StatDateModel(this.time, this.days, this.weeks,
      this.months, this.dayWeek);
  
  StatDateModel.fromJson(Map<String, dynamic> json)
      : time = json['hourlyStatisticsResponse']['time'],
        days = json['dailyStatisticsResponse']['days'],
        weeks = json['weeklyStatisticsResponse']['weeks'],
        months = json['monthlyStatisticsResponse']['months'],
        dayWeek = json['dayOfWeekStatisticsResponse']['dayWeek'];
        
  @override
  String toString() {
    return '$time, $days, $weeks, $months, $dayWeek';
  }
}
