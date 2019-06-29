import React from "react"
import Player from "./Player"
import countries from "./countries"

class Team extends React.Component {
  render () {
    if (this.props.compact) {
      return (
        <tr className='team-table-row'>
          <td>
            <span><img className="team-logo" src={this.props.team.logo}/></span>
            <span className="team-name"><a href={"/teams/" +this.props.id}>{this.props.team.name}</a></span>
          </td>
          <td>
            <span><img className="flag-logo" src={"/assets/flags/" + this.props.team.country + '.svg'}/></span>
            <span>{countries[this.props.team.country]}</span>
          </td>
        </tr>
      )
    }
    else {
      return (
        <div>
          <div className="team-header shadow">
            <div>
              <img className="team-header-logo" src={this.props.team.logo}/>
            </div>
            <div className="team-header-name">
              <h2>
                <a target="_blank" href={this.props.team.website}>
                  {this.props.team.name}
                </a>
              </h2>
              <div className="team-socials">
                <span className="team-social">
                  <a target="_blank" href={this.props.team.socials['TWITTER']}>
                    <img className="social-logo" src="/assets/socials/twitter.svg"/>
                  </a>
                </span>
                <span className="team-social">
                  <a target="_blank" href={this.props.team.socials['INSTAGRAM']}>
                    <img className="social-logo" src="/assets/socials/instagram.svg"/>
                  </a>
                </span>
                {this.props.team.socials['FACEBOOK'] &&
                  <span className="team-social">
                    <a target="_blank" href={this.props.team.socials['FACEBOOK']}>
                      <img className="social-logo" src="/assets/socials/facebook.png"/>
                    </a>
                  </span>}
                {this.props.team.socials['YOUTUBE_CHANNEL'] &&
                  <span className="team-social">
                    <a target="_blank" href={this.props.team.socials['YOUTUBE_CHANNEL']}>
                      <img className="social-logo" src="/assets/socials/youtube.svg"/>
                    </a>
                  </span>}
                {this.props.team.socials['DISCORD'] &&
                  <span className="team-social">
                    <a target="_blank" href={this.props.team.socials['DISCORD']}>
                      <img className="social-logo" src="/assets/socials/discord.svg"/>
                    </a>
                  </span>}
              </div>
              <div className="country">
                <div className="country-flag"><img className="flag-logo" src={"/assets/flags/" + this.props.team.country + '.svg'}/></div>
                <div>{countries[this.props.team.country]}</div>
              </div>
            </div>
          </div>
          <div className="team-information">
            <div className="team-matches shadow">
              <div className="card-header">
                Matches
              </div>
              <div>
                1
              </div>
            </div>
            <div className="team-roster shadow">
              <div className="card-header">
                Roster
              </div>
              {this.props.players.map((player) => (
                <Player key={player.id} player={player}/>
              ))}
            </div>
          </div>
        </div>
      )
    }
  }
}

export default Team
