import React from "react";

class Streamer extends React.Component {
  render (){
    return (
      <a href={`https://www.twitch.tv/${this.props.link}`} target="_blank" className="streamer-row" title={this.props.title}>
        <div className="streamer-info">
          <span>{this.props.lang} </span>
          <span>{this.props.name}</span>
          <span className="streamer-title"> {this.props.title}</span>
        </div>
        <div className="streamer-viewcount">
          {this.props.viewcount}
        </div>
      </a>
    )
  }
}

export default Streamer
