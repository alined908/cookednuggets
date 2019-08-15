import React from "react"
import countries from "./countries"

var shortmonths = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug",
"Sep", "Oct", "Nov", "Dec"]

var months = ["January", "February", "March", "April", "May", "June", "July", "August",
"September", "October", "November", "December"]

class Event extends React.Component {

  getImage(str){
    var words = str.split(" ").slice(0, 2);
    return words.join("-") + ".png";
  }

  getShortDate(str){
    var formatted = str.split("-");
    return shortmonths[parseInt(formatted[1]) - 1] + " " + formatted[2]
  }

  getDate(str){
    var formatted = str.split("-");
    return months[parseInt(formatted[1]) - 1] + " " + formatted[2] + ", " + formatted[0]
  }

  render () {
    if (this.props.compact) {
      return (
        <div className="event-card">
          <a href={"/events/" + this.props.event.id}>
            <div className="event-card-wrapper shadow-sm">
              <div className="event-picture">
                <img src={"/assets/events/" + this.getImage(this.props.event.name)}/>
              </div>
              <div className="event-information">
                <div className="event-info-top">
                  <div className="event-name">
                    {this.props.event.name}
                  </div>
                  <div className="event-place">
                    <div className="event-country">
                      <img className="flag-logo" src={"/assets/flags/" + this.props.event.country}/>
                    </div>
                    <div className="event-location">
                      {this.props.event.location}
                    </div>
                  </div>
                </div>
                <div className="event-info-bottom">
                  <div className="event-date">
                    <div className="event-date-start"><span className="light-text">Start</span> {this.getShortDate(this.props.event.start_date)}</div>
                    <div className="event-date-end"><span className="light-text">End</span> {this.getShortDate(this.props.event.end_date)}</div>
                  </div>
                  <div className="event-prize">
                    <div className="event-prize-desc light-text">Prize</div>
                    <div>${this.props.event.prize}</div>
                  </div>
                </div>
              </div>
            </div>
          </a>
        </div>
      )
    }
    else {
      return (
        <div>
          <div className="team-header shadow-sm">
            <div className="header-img">
              <img src={"/assets/events/" + this.getImage(this.props.event.name)}/>
            </div>
            <div className="team-header-name">
              <h3>
                <a target="_blank" href={this.props.event.website}>
                  {this.props.event.name}
                </a>
              </h3>
              <div className="country">
                <span className="light-text">Location:</span>
                <div className="country-flag"><img className="flag-logo" src={"/assets/flags/" + this.props.event.country + '.svg'}/></div>
                {this.props.event.location}
              </div>
              <div className="event-overview-prize">
                <span className="light-text">Prize:</span> ${this.props.event.prize}
              </div>
              <div>
              <div className="event-date-start"><span className="light-text">Start:</span> {this.getDate(this.props.event.start_date)}</div>
              <div className="event-date-end"><span className="light-text">End: </span>{this.getDate(this.props.event.end_date)}</div>
              </div>
            </div>
          </div>
        </div>
      )
    }

  }
}

export default Event
