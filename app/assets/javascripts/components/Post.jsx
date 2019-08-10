import React from "react";
import ReplyForm from './ReplyForm'
import EditForm from './EditForm'

class Post extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      replyForm: false,
      editForm: false
    };
    this.handleReplyClick = this.handleReplyClick.bind(this);
    this.handleEditClick = this.handleEditClick.bind(this);
  }

  handleReplyClick(){
    this.setState({replyForm: !this.state.replyForm});
  }

  handleEditClick(){
    this.setState({editForm: !this.state.editForm})
  }

  render() {
    return (
      <div className="forum-post-wrapper">
        <div className="forum-post">
          <div className="post-header">
            <div><img className="flag-logo" src={"/assets/flags/" + this.props.user.country + '.svg'}/> {this.props.user.username}</div>
          </div>
          <div className="post-body">
            {this.state.editForm && <EditForm post={this.props.post} authenticity_token={this.props.authenticity_token}/>}
            {!this.state.editForm && this.props.post.body}
          </div>
          <div className="post-footer">
            <div className="post-timestamp">posted {this.props.time} ago</div>
            <div className="post-footer-actions">
              {this.props.owner && <div className="post-edit" onClick={this.handleEditClick}>edit</div>}
              {this.props.signed_in && <div className="reply-button" onClick={this.handleReplyClick}>reply</div>}
            </div>
          </div>
        </div>
        {this.state.replyForm && <ReplyForm id={this.props.post.id} authenticity_token={this.props.authenticity_token}/>}
      </div>
    )
  }
}

export default Post
