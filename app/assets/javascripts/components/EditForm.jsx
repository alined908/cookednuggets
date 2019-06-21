import React from "react"

class EditForm extends React.Component {
  render (){
    return (
      <form className="edit_forum_post" action={"/forums/posts/" + this.props.post.commentable_id+"/posts/"+this.props.post.id} acceptCharset="UTF-8" method='post'>
        <input type="hidden" name="_method" value="put" />
        <input type='hidden' name='authenticity_token' value={this.props.authenticity_token}/>
        <textarea rows="3" className="reply-form" name="forum_post[body]" id="forum_post[body]" defaultValue={this.props.post.body}></textarea>
        <input className="submit-post-button" type='submit' name='commit' value="Save Post" data-disable-with="Submit"/>
      </form>
    )
  }
}

export default EditForm
