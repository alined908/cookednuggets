import React from "react"
import PropTypes from "prop-types"
import clientId from "../secrets"
import Streamer from "./Streamer"

class LiveStreams extends React.Component {

  constructor(props){
    super(props);
    this.state = {
      streamers: []
    };
    this.updateStreamers = this.updateStreamers.bind(this);
  }

  fetchStreams(){
    fetch ("https://api.twitch.tv/helix/streams?game_id=488552", {
      headers: {
        'Client-Id': clientId,
      }
    })
    .then(response => {
      return response.json();
    })
    .then(json => {
      this.setState({
        streamers: json.data
      });
    })
    .catch(error => {
      error => console.error('Error:', error)
    });
  }

  async componentDidMount() {
    this.fetchStreams();
  }

  updateStreamers(){
    this.fetchStreams();
  }

  render () {
    return (
      <div>
        <div className="descriptor">Streams <span onClick={this.updateStreamers} className="refresh-stream">&#8635;</span></div>
        <div className="shadow-sm streamer-list">
          {this.state.streamers.map((stream) => (
            <Streamer
              key={stream.id} name={stream.user_name} lang={stream.language}
              link={stream.thumbnail_url.split("live_user_")[1].split("-")[0]}
              viewcount={stream.viewer_count} title={stream.title} />
          ))}
        </div>
      </div>
    );
  }
}

export default LiveStreams
