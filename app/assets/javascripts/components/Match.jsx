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
      score: score,
      opacity: 0
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
    var weight = ""
    if (this.props.match.winner_id == null) {
      weight = "500"
    }
    else {
      weight = (team.id == this.props.match.winner_id) ? "600" : "300"
    }
    return {fontWeight: weight}

  }

  formatMatch(type){
    var type = (type == "regular") ? "Regular Season" : "Playoffs";
    return type;
  }

  checkLive(time){
    if (this.props.match.winner_id != null) {
      return this.time_ago(time);
    }else {
      var start = new Date(this.props.match.start);
      var current = new Date();
      var diff = (current - start);
      if (diff > 0 && diff < 10800000) {
        return "&#128308; Live"
      } else {
        return this.time_ago(time);
      }
    }

  }

  time_ago(time) {
    time = +new Date(time);

    var time_formats = [
      [60, 'secs', 1], // 60
      [120, '1 min ago', '1min'], // 60*2
      [3600, 'mins', 60], // 60*60, 60
      [7200, '1h ago', '1h'], // 60*60*2
      [86400, 'h', 3600], // 60*60*24, 60*60
      [172800, '1d ago', '1d'], // 60*60*24*2
      [604800, 'd', 86400], // 60*60*24*7, 60*60*24
      [1209600, '1w ago', '1w'], // 60*60*24*7*4*2
      [2419200, 'w', 604800], // 60*60*24*7*4, 60*60*24*7
      [4838400, '1mo ago', '1m'], // 60*60*24*7*4*2
      [29030400, 'mo', 2419200], // 60*60*24*7*4*12, 60*60*24*7*4
      [58060800, '1y ago', '1y'], // 60*60*24*7*4*12*2
      [2903040000, 'y', 29030400], // 60*60*24*7*4*12*100, 60*60*24*7*4*12
    ];
    var seconds = (+new Date() - time) / 1000,
      token = 'ago',
      list_choice = 1;

    if (seconds == 0) {
      return 'Just now'
    }
    if (seconds < 0) {
      seconds = Math.abs(seconds);
      token = 'from now';
      list_choice = 2;
    }
    var i = 0,
      format;
    while (format = time_formats[i++])
      if (seconds < format[0]) {
        if (typeof format[2] == 'string')
          return format[list_choice];
        else if (token == "from now")
          return Math.floor(seconds / format[2]) + '' + format[1];
        else
          return Math.floor(seconds / format[2]) + '' + format[1] + ' ' + token;
      }
    return time;
  }

  render () {
    if (!this.props.compact) {
      return (
        <a href={"/matches/" + this.props.match.id} style={{borderLeft: "2px solid " + (this.props.color || this.props.event.color)}} className="match-horz link">
          {this.props.event &&
            <div className="match-event">
              <div className='match-event-name'>
                {this.props.event.name}
              </div>
              <div className='match-event-info'>
                {this.props.section.name} - {this.formatMatch(this.props.match.match_type)}
              </div>
            </div>
          }
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

          {!this.props.event &&
            <div className="match-horz-type">
              {this.formatMatch(this.props.match.match_type)}
            </div>
          }
        </a>
      )
    }
    else {
      return (
        <a href={"/matches/" + this.props.match.id} className="match-compact link">
          <div className="hoverable" style={{opacity: this.state.opacity}}>
            <div>{this.props.time}</div>
            <div>{this.props.fullname}</div>
            <div>{this.props.teams[0].shortname}({this.props.teams[0].rating}) vs {this.props.teams[1].shortname}({this.props.teams[1].rating})</div>
          </div>
          <div style={{borderLeft: "2px solid " + this.props.color}}onMouseEnter={() => this.setState({opacity: 1})} onMouseLeave={() => this.setState({opacity: 0})} className="match-comp">
            <div className="match-comp-time">
              <div className="match-event">{this.props.event}</div>
              <div dangerouslySetInnerHTML={{__html: this.checkLive(this.props.match.start)}}></div>
            </div>
            <div className="match-comp-vs">
              {this.props.teams.map((team, index) => {
                return (
                  <div className="match-comp-scores">
                    <div style={this.setWeight(team)} className="match-comp-team">
                      <img className="flag-logo" src={team.logo}/> {team.name}
                    </div>
                    {this.state.score ?
                      (<div style={this.setColor(team)}>
                        {this.props.match.score[index]}
                      </div>) : (<div>-</div>)
                    }
                  </div>
                )
              })}
            </div>
          </div>
        </a>
      )
    }
  }
}

export default Match
