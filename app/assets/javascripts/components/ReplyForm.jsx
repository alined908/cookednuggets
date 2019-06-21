import React from "react"

class ReplyForm extends React.Component {
  render (){
    return (
      <div className="post-reply">
        <div className="post-reply-topbar"></div>
        <form className="new_forum_post" action={"/forums/posts/" + this.props.id+"/posts"} acceptCharset="UTF-8" method='post' >
          <input type='hidden' name='authenticity_token' value={this.props.authenticity_token}/>
          <textarea rows="3" className="reply-form" name="forum_post[body]" id="forum_post[body]"></textarea>
          <input className="submit-post-button" type='submit' name='commit' value="Submit Post" data-disable-with="Submit"/>
        </form>
      </div>
    )
  }
}

export default ReplyForm
