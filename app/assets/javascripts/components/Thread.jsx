import React from "react";

class Thread extends React.Component {

  render() {
    if (this.props.compact) {
      return (
        <a className="thread" href={"/forums/threads/" + this.props.id}>
          <div>Username: {this.props.info[1]}</div>
          <div>Title: {this.props.title}</div>
          <div>Date: {this.props.info[0]} ago</div>
        </a>
      )
    }
    else {
      return (
        <div>
          <div>Username: {this.props.info[0][1]}</div>
          <div>Title: {this.props.thread.subject}</div>
          <div>Topic: {this.props.thread.description}</div>
          <div>Created at: {this.props.thread.created_at}</div>
        </div>
      )
    }
  }
}

export default Thread
