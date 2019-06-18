import React from "react";
import Thread from "./Thread"

class Forum extends React.Component {

  render () {
    return (
      <table className="table matches">
        <thead>
          <tr>
            <th>Topic</th>
            <th>Replies</th>
            <th>Author</th>
            <th>Activity</th>
            <th colSpan="4"></th>
          </tr>
        </thead>
        <tbody>
          {this.props.threads.map((thread, index) => (
            <Thread compact={true} id={thread.id} title={thread.subject} info={this.props.thread_info[index]} />
          ))}
        </tbody>
      </table>
    );
  }
}

export default Forum
