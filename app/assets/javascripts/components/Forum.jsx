import React from "react";
import Thread from "./Thread"

class Forum extends React.Component {

  constructor(props){
    super(props);
  }

  render () {
    return (
      <div>
        {this.props.threads.map((thread, index) => (
          <Thread compact={true} id={thread.id} title={thread.subject} info={this.props.thread_info[index]} />
        ))}
      </div>
    );
  }
}

export default Forum
