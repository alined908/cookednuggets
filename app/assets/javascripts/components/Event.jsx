import React from "react"

var months = ["January", "February", "March", "April", "May", "June", "July", "August",
"September", "October", "November", "December"]

class Event extends React.Component {

  getImage(str){
    var words = str.split(" ").slice(0, 2);
    console.log(words.join("-"));
    return words.join("-") + ".png";
  }

  getDate(str){
    var formatted = str.split("-")
    return months[parseInt(formatted[1]) - 1] + " " + formatted[2]
  }

  render (){
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
                  <div className="event-date-start"><span className="light-text">Start</span> {this.getDate(this.props.event.start_date)}</div>
                  <div className="event-date-end"><span className="light-text">End</span> {this.getDate(this.props.event.end_date)}</div>
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
}

export default Event
