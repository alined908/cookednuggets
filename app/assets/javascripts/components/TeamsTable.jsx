import React from "react";
import Team from "./Team"

class TeamsTable extends React.Component {

  render () {
    return (
      <table className="table">
        <thead>
          <tr>
            <th>Team</th>
            <th>Country</th>
            <th>Social</th>
          </tr>
        </thead>
        <tbody>
          {this.props.teams.map((team, index) => (
            <Team id={team.id} team={team} compact={true}/>
          ))}
        </tbody>
      </table>
    )
  }
}

export default TeamsTable
