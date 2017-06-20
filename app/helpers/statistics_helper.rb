module StatisticsHelper
  def rates_by_amount(movie)
    line_chart rate_by_amount_movie_path(movie), width: '50%', library: {
      title: {text: 'Rates by Stars', x: -20},
      yAxis: {
        allowDecimals: false,
        title: {
          text: "# of Rates"
        }
      },
      xAxis: {
        title: {
          text: 'Stars'
        }   
      }
    }
  end
end
