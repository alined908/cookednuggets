import React from "react";
import ReplyForm from './ReplyForm'

class Post extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      replyForm: false
    };
    this.handleClick = this.handleClick.bind(this);
  }

  handleClick(){
    this.setState({replyForm: !this.state.replyForm});
  }

  render() {
    return (
      <div className="forum-post-wrapper">
        <div className="forum-post">
          <div className="post-header">
            {this.props.user}
          </div>
          <div className="post-body">
            {this.props.post.body}
          </div>
          <div className="post-footer">
            <div className="post-timestamp">posted {this.props.time} ago</div>
            <div className="reply-button" onClick={this.handleClick}>reply</div>
          </div>
        </div>
        {this.state.replyForm && <ReplyForm id={this.props.post.id} type={this.props.post.commentable_type} authenticity_token={this.props.authenticity_token}/>}
      </div>
    )
  }
}

export default Post
