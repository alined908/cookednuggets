import React from "react"
import countries from "./countries"

class Player extends React.Component {
  render () {
    return (
      <a href={"/players/" + this.props.player.id}>
        <div className="team-player">
          <div className="team-player-inner">
            <div className="team-player-headshot"><img className="team-player-headshot-img" src={this.props.player.headshot}/></div>
            <div className="team-player-info">
              <div className="country">
                <div className="country-flag">
                  <img className="flag-logo" src={"/assets/flags/" + this.props.player.country.toLowerCase() + '.svg'}/>
                </div>
                <div className="team-player-handle">
                  {this.props.player.handle}
                </div>
              </div>
              <div className="team-player-name font-light">
                {this.props.player.eng_name}
              </div>
              <div className="team-player-roles">
                {this.props.player.roles}
              </div>
            </div>
          </div>
        </div>
      </a>
    )
  }
}

export default Player
