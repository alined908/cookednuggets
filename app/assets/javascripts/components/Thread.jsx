import React from "react";

class Thread extends React.Component {

  render() {
    if (this.props.compact) {
      return (
        <tr>
          <td>
            <a href={"/forums/threads/" + this.props.id}>
              {this.props.title}
            </a>
          </td>
          <td>{this.props.info[2]}</td>
          <td>{this.props.info[1]}</td>
          <td>{this.props.info[0]} ago</td>
        </tr>
      )
    }
    else {
      return (
        <div className="thread-wrapper">
          <div className="forum-post-wrapper">
            <div className="forum-post">
              <div className="post-header">
                <div>
                  {this.props.info[0][1]}
                </div>
                <div className="post-title">
                  {this.props.thread.subject}
                </div>
              </div>
              <div className="post-body">
                {this.props.thread.description}
              </div>
              <div className="post-footer">
                <div className="post-footer-thread">
                  posted {this.props.timestamp} ago
                </div>
              </div>
            </div>
          </div>
        </div>
      )
    }
  }
}

export default Thread
