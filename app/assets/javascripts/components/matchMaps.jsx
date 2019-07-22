import React from "react"

class MatchMaps extends React.Component {

  constructor(props){
    super(props);
    this.state = {
      status: [1].concat(new Array(this.props.maps_json.length - 1).fill(0)),
    }
    this.setActive = this.setActive.bind(this);
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

  render() {
    return (
      <div className="map-container shadow-sm">
        <div className="map-container-navbar shadow-sm">
          {this.props.maps_json.map((map, index) => (
            <div style={{backgroundColor: this.state.status[index] ? 'white' : "rgb(240,240,240)"}}
              onClick={this.setActive} className={"map-entry " + index.toString()}>
              <div className="map-entry-num">MAP {index + 1}</div>
              <div className="map-entry-name capitalize">{map.map}</div>
            </div>
          ))}
        </div>
        <div className="map-container-games">
          {this.props.maps_json.map((map, index) => (
            <div style={{display: this.state.status[index] ? "block" : "none"}} className={"map-info " + index.toString()}>
              <div className="map-game-wrapper">
                <div className="map-game-stats">
                  <div className="map-team">
                    {this.props.teams[0].name}
                  </div>
                  <div className="map-team">
                    {this.props.teams[1].name}
                  </div>
                </div>
                <div className="map-rosters">
                  <div className="map-roster">
                    {map.players.slice(0,6).map((player) => (
                      <div className="map-player">
                        {player.handle} {player.roles[0]}
                      </div>
                    ))}
                  </div>
                  <div className="map-roster">
                    {map.players.slice(6,12).map((player) => (
                      <div className="map-player">
                        {player.handle} {player.roles[0]}
                      </div>
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
