import React from "react"

class MatchMaps extends React.Component {

  constructor(props){
    super(props);
    if (this.props.maps_json.length == 0) {
      var length = 5
    }else {
      var length = this.props.maps_json.length
    }

    this.state = {
      status: [1].concat(new Array(length - 1).fill(0)),
    }
    this.setActive = this.setActive.bind(this);
    this.mapscore;
  }

  setActive(e){
    var map = e.currentTarget;
    var num = parseInt(map.className.split(" ")[1]);
    var newStatus = new Array(this.state.status.length).fill(0);
    newStatus[num] = 1;

    this.setState({
      status: newStatus
    })
  }

  mapWinner(score, state){
    console.log(score)
    console.log(state)
    if (state == "unfinished") {
      this.mapscore = ["", ""]
      return
    }
    var mapscore = []
    if (score[0] > score[1]){
      mapscore = ["winner", ""]
    } else if (score[1] > score[0]){
      mapscore = ["", "winner"]
    } else {
      mapscore = ["draw", "draw"]
    }
    this.mapscore = mapscore;
  }

  sanitizeMap(map){
    if (map != null && map != ""){
      map = map.replace("-", " ")
    }else {
      map = "TBD"
    }
    return map
  }

  render() {
    return (
      <div className="map-container shadow-sm">
        <div className="map-container-navbar shadow-sm">
          {this.props.maps_json.map((map, index) => (
            <div style={{backgroundColor: this.state.status[index] ? '#fafafa' : "rgb(240,240,240)"}}
              onClick={this.setActive} className={"map-entry " + index.toString()}>
              <div className="map-entry-num">Map {index + 1}</div>
              <div style={{fontWeight: this.state.status[index] ? 'bold' : "normal"}} className="map-entry-name capitalize">{this.sanitizeMap(map.name)}</div>
            </div>
          ))}
        </div>
        <div className="map-container-games">
          {this.props.maps_json.map((map, index) => (
            <div style={{display: this.state.status[index] ? "block" : "none"}} className={"map-info " + index.toString()}>
              {this.mapWinner(map.score, map.state)}
              <div className="map-game-wrapper">
                <div className="map-game-stats">
                  <div className="map-team">
                    <span style={{marginRight: "5px"}}>{this.props.teams[0].name}</span>
                      <span className={"map-team-status " + this.mapscore[0]}>{this.mapscore[0]}</span>
                  </div>
                  <div className="map-team">
                    <span className={"map-team-status " + this.mapscore[1]}>{this.mapscore[1]}</span>
                    <span style={{marginLeft: "5px"}}>{this.props.teams[1].name}</span>
                  </div>
                </div>
                <div className="map-rosters">
                  <div className="map-roster">
                    {map.players[0].map((player) => (
                      <a className="link-nodec color" href={"/players/" + player.id}>
                        <div className="map-player">
                          <div style={{marginRight: "10px"}} className="map-player-logo">
                            <img className="team-logo" src={this.props.teams[0].logo}/>
                          </div>
                          <div className="map-player-info">
                            <div className="map-player-info-top">
                              {player.handle} <img className="flag-logo" src={"/assets/flags/" + player.country.toLowerCase() + '.svg'}/>
                            </div>
                            <div className="map-player-info-bot">
                              {player.roles}
                            </div>
                          </div>
                        </div>
                      </a>
                    ))}
                  </div>
                  <div className="map-scoreboard">
                    {map.state == "finished" &&
                      <div>
                        <span className={this.mapscore[0]}>{map.score[0]} </span>
                        <span>-</span>
                        <span className={this.mapscore[1]}> {map.score[1]}</span>
                      </div>
                    }
                  </div>
                  <div className="map-roster-right">
                  {map.players[1].map((player) => (
                    <a className="link-nodec color" href={"/players/" + player.id}>
                      <div className="map-player">
                        <div className="map-player-info">
                          <div className="map-player-info-top">
                            <img className="flag-logo" src={"/assets/flags/" + player.country.toLowerCase() + '.svg'}/> {player.handle}
                          </div>
                          <div style={{textAlign: "right"}} className="map-player-info-bot">
                            {player.roles}
                          </div>
                        </div>
                        <div style={{marginLeft: "10px"}} className="map-player-logo">
                          <img className="team-logo" src={this.props.teams[1].logo}/>
                        </div>
                      </div>
                    </a>
                  ))}
                  </div>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
    )
  }
}

export default MatchMaps
