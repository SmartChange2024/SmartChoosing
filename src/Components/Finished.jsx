import React from "react";
import imageSrc from "./assets/logo_t_b.png"

const Finished = (props) => {
    return (
        <div className="general-background">
            <img src={imageSrc} alt="Text" className="login-logo"/>
            <div className="login-container">
                <h1 className="welcome-message">Voting is Finished</h1>
                <p className="connected-account">See the results:</p>

                <table id="resultsTable" className="candidates-table">
                    <thead>
                    <tr>
                        <th>Index</th>
                        <th>Candidate name</th>
                        <th>Candidate votes</th>
                    </tr>
                    </thead>
                    <tbody>
                    {props.candidates.map((candidate, index) => (
                        <tr key={index}>
                        <td>{candidate.index}</td>
                        <td>{candidate.name}</td>
                        <td>{candidate.voteCount}</td>
                        </tr>
                    ))}
                    </tbody>
                </table>
            </div>
        </div>
    )
}

export default Finished;