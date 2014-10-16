define [], ->
  class Util

    @timeFormat: (dateStr) ->
      date = new Date dateStr
      "#{date.getMonth() + 1}/#{date.getDate()} #{date.getHours()}:#{date.getMinutes()}"
      