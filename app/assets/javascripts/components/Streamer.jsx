import React from "react";
var countries = {'ru': 'ru', 'en': 'us', 'ko': 'kr', 'pt': 'pt', 'es': 'es',
 'de': 'de', 'it':'it', 'fr' :'fr'}

class Streamer extends React.Component {

  render (){
    return (
      <a href={`https://www.twitch.tv/${this.props.link}`} target="_blank" className="streamer-row" title={this.props.title}>
        <div className="streamer-info">
          <span className="streamer-flag">
            {(this.props.lang in countries) ? (<img className="flag-logo" src={"/assets/flags/" + countries[this.props.lang] + '.svg'}/>) : this.props.lang}
          </span>
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
