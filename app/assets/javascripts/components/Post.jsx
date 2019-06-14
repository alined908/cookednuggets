import React from "react";

class Post extends React.Component {
  render() {
    return (
      <div>
        {this.props.body}
      </div>
    )
  }
}

export default Post
