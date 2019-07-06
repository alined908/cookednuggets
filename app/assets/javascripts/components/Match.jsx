import React from "react"
const monthNames = ["January", "February", "March", "April", "May", "June",
  "July", "August", "September", "October", "November", "December"
];

class Match extends React.Component {

  constructor(props){
    super(props);
    var time = this.formatTime(this.props.match.start);
    var score = true;
    if (this.props.match.score.toString() === [0,0].toString()) {
      score = false
    }
    this.state = {
      date: this.checkTime(time[0]),
      hour: time[1],
      score: score
    };
  }

  checkTime(date){
    var n = document.body.innerText.split(date).length;
    var text = n > 1 ? "" : date;
    return text;
  }

  formatTime(datetime){
    var dt = new Date(datetime);
    var month = monthNames[dt.getMonth()];
    var day = dt.getDate();
    var options = {hour: 'numeric', minute: 'numeric', hour12: true};
    var timeString = dt.toLocaleString('en-US', options);

    return [month + " " + day, timeString]
  }

  setColor(team){
    var color = (team.id == this.props.match.winner_id) ? "green" : "red"
    return {color: color}
  }

  setWeight(team){
    var weight = (team.id == this.props.match.winner_id) ? "600" : "300"
    return {fontWeight: weight}
  }

  formatMatch(type){
    var type = (type == "regular") ? "Regular Season" : "Playoffs";
    return type;
  }

  time_ago(time) {
    time = +new Date(time);

    var time_formats = [
      [60, 'seconds', 1], // 60
      [120, '1 minute ago', '1 minute from now'], // 60*2
      [3600, 'minutes', 60], // 60*60, 60
      [7200, '1 hour ago', '1 hour from now'], // 60*60*2
      [86400, 'hours', 3600], // 60*60*24, 60*60
      [172800, 'Yesterday', 'Tomorrow'], // 60*60*24*2
      [604800, 'days', 86400], // 60*60*24*7, 60*60*24
      [1209600, 'Last week', 'Next week'], // 60*60*24*7*4*2
      [2419200, 'weeks', 604800], // 60*60*24*7*4, 60*60*24*7
      [4838400, 'Last month', 'Next month'], // 60*60*24*7*4*2
      [29030400, 'months', 2419200], // 60*60*24*7*4*12, 60*60*24*7*4
      [58060800, 'Last year', 'Next year'], // 60*60*24*7*4*12*2
      [2903040000, 'years', 29030400], // 60*60*24*7*4*12*100, 60*60*24*7*4*12
    ];
    var seconds = (+new Date() - time) / 1000,
      token = 'ago',
      list_choice = 1;

    if (seconds == 0) {
      return 'Just now'
    }
    if (seconds < 0) {
      seconds = Math.abs(seconds);
      token = 'Starts in ';
      list_choice = 2;
    }
    var i = 0,
      format;
    while (format = time_formats[i++])
      if (seconds < format[0]) {
        if (typeof format[2] == 'string')
          return format[list_choice];
        else if (token == "Starts in ")
          return token + Math.floor(seconds / format[2]) + ' ' + format[1];
        else
          return Math.floor(seconds / format[2]) + ' ' + format[1] + ' ' + token;
      }
    return time;
  }

  render () {
    return (
      <a href={"/matches/" + this.props.match.id} className="match-horz link">
        <div className="match-horz-time">
          <div className="match-horz-day">
            {this.state.date}
          </div>
          <div className="match-horz-hour">
            {this.state.hour}
          </div>
        </div>
        <div className="match-horz-vs">
          {this.props.teams.map((team, index) => {
            return (
              <div className="match-horz-vs-scores">
                <div style={this.setWeight(team)} className="match-horz-vs-team">
                  <img className="flag-logo" src={team.logo}/> {team.name}
                </div>
                {this.state.score ?
                  (<div style={this.setColor(team)}>
                    {this.props.match.score[index]}
                  </div>) :
                  (<div>-</div>)
                }
              </div>
            )
          })}
        </div>
        <div className="match-horz-rel-time">
          {this.time_ago(this.props.match.start)}
        </div>
        <div className="match-horz-type">
          {this.formatMatch(this.props.match.match_type)}
        </div>
      </a>
    )
  }
}

export default Match