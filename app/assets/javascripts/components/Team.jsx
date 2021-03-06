import React from "react"
import Player from "./Player"
import Match from "./Match"
import countries from "./countries"

class Team extends React.Component {
  render () {
    if (this.props.compact) {
      return (
        <React.Fragment>
          <div className="teamstable-ttr">
            <span><img className="team-logo" src={this.props.team.logo}/></span>
            <span className="team-name"><a href={"/teams/" +this.props.id}>{this.props.team.name}</a></span>
          </div>
          <div>
            <span><img className="flag-logo" src={"/assets/flags/" + this.props.team.country + '.svg'}/></span>
            <span>{countries[this.props.team.country]}</span>
          </div>
        </React.Fragment>
      )
    }
    else {
      return (
        <div>
          <div className="team-header shadow-sm">
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
            <div className="descriptor">
              Matches
            </div>
            <div className="team-matches shadow-sm">
              {this.props.matches.map((match, index) => (
                <Match match={match} compact={false} event={this.props.events[index]} section={this.props.sections[index]}teams={[this.props.teams1[index], this.props.teams2[index]]}/>
              ))}
            </div>
          </div>
        </div>
      )
    }
  }
}

export default Team
