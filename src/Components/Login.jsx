import React from "react";
import imageSrc from "./assets/logo_b.png"

const Login = (props) => {
    return (
        <div className="general-background">
            <div className="login-container" >
                <img src={imageSrc} alt="Text" className="login-logo"/>
                <h1 className="welcome-message">Welcome to your safe voting space</h1>
                <button className="login-button" onClick = {props.connectWallet}>Login Metamask</button>
            </div>
        </div>
    )
}

export default Login;