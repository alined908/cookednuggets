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
  }

  async componentDidMount() {
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

  render () {
    return (
      <div>
        {this.state.streamers.map((stream) => (
          <Streamer
            key={stream.id} name={stream.user_name} lang={stream.language}
            link={stream.thumbnail_url.split("live_user_")[1].split("-")[0]}
            viewcount={stream.viewer_count} title={stream.title} />
        ))}
      </div>
    );
  }
}

export default LiveStreams
