import React from "react";

class Thread extends React.Component {

  time_ago(time) {
    time = +new Date(time);

    var time_formats = [
      [60, 'seconds', 1], // 60
      [120, '1 min ago', '1 min'], // 60*2
      [3600, 'minutes', 60], // 60*60, 60
      [7200, '1 hour ago', '1 hour'], // 60*60*2
      [86400, 'hours', 3600], // 60*60*24, 60*60
      [172800, '1 day ago', '1 day'], // 60*60*24*2
      [604800, 'days', 86400], // 60*60*24*7, 60*60*24
      [1209600, '1 week ago', '1 week'], // 60*60*24*7*4*2
      [2419200, 'weeks', 604800], // 60*60*24*7*4, 60*60*24*7
      [4838400, '1 month ago', '1 month'], // 60*60*24*7*4*2
      [29030400, 'months', 2419200], // 60*60*24*7*4*12, 60*60*24*7*4
      [58060800, '1 year ago', '1 year'], // 60*60*24*7*4*12*2
      [2903040000, 'years', 29030400], // 60*60*24*7*4*12*100, 60*60*24*7*4*12
    ];
    var seconds = (+new Date() - time) / 1000,
      token = 'ago',
      list_choice = 1;

    if (seconds == 0) {
      return 'Just now'
    }
    if (seconds < 0) {
      seconds = Math.abs(seconds);
      token = 'from now';
      list_choice = 2;
    }
    var i = 0,
      format;
    while (format = time_formats[i++])
      if (seconds < format[0]) {
        if (typeof format[2] == 'string')
          return format[list_choice];
        else if (token == "from now")
          return Math.floor(seconds / format[2]) + ' ' + format[1];
        else
          return Math.floor(seconds / format[2]) + ' ' + format[1] + ' ' + token;
      }
    return time;
  }

  render() {
    if (this.props.compact) {
      return (
        <a className="link-nodec" href={this.props.path[0]}>
          <div className={"thread-comp " + this.props.path[1]}>
            <div className="thread-comp-sub">{this.props.thread.subject}</div>
            <div className="thread-comp-author">{this.props.author}</div>
            <div className="thread-comp-recent">{this.time_ago(this.props.thread.updated_at)}</div>
            <div className="thread-comp-cc">{this.props.thread.comments_count}</div>
          </div>
        </a>
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
