import React from "react";
import { connect } from "react-redux";
import { authenticatingUser, clearError } from "../redux/actions";
import { Link } from "react-router-dom";
import { Segment, Button, Divider, Grid } from "semantic-ui-react";
import { isEmpty } from "lodash";

class Login extends React.Component {
  constructor() {
    super();
    this.state = {
      username: "",
      password: "",
    };
  }

  handleSubmit = (event) => {
    event.preventDefault();

    if (this.state.username === "") {
      console.log("Username must be filled out", { duration: null });
    } else if (this.state.password === "") {
      console.log("Password must be filled out", { duration: null });
    } else {
      this.props.authenticatingUser({ user: this.state });
      this.resetForm();
    }
  };

  handleChange = (event) => {
    this.setState({
      [event.target.name]: event.target.value,
    });
  };

  displayAlert = () => {
    if (!isEmpty(this.props.error)) {
      console.log(this.props.error, { duration: null });
      this.props.clearError();
    }
  };

  resetForm = () => {
    this.setState({
      username: "",
      password: "",
    });
  };

  render() {
    return (
      <div className="wrapper backImage">
        <Grid centered textAlign="left">
          <Grid.Row>
            <h1> </h1>
          </Grid.Row>
          <Grid.Row>
            <Segment id="login">
              <Grid columns={2} relaxed="very" stackable>
                <Grid.Column>
                  <form className="ui form" onSubmit={this.handleSubmit}>
                    <div className="required field">
                      <label htmlFor="username">Username: </label>
                      <input
                        type="text"
                        name="username"
                        onChange={this.handleChange}
                        value={this.state.username}
                      ></input>
                    </div>

                    <div className="required field">
                      <label htmlFor="password">Password: </label>
                      <input
                        type="password"
                        name="password"
                        onChange={this.handleChange}
                        value={this.state.password}
                      ></input>
                      <br />
                    </div>
                    <button className="ui button primary" type="submit">
                      Login
                    </button>
                  </form>
                </Grid.Column>
                <Grid.Column textAlign="center" verticalAlign="middle">
                  <Button content="Sign Up" as={Link} to="/signup" icon="signup" size="big" />
                </Grid.Column>
              </Grid>
              <Divider vertical>Or</Divider>
            </Segment>
          </Grid.Row>
        </Grid>
        {this.displayAlert()}
      </div>
    );
  }
}

const mapStateToProps = (state) => {
  return { error: state.error };
};

const mapDispatchToProps = (dispatch) => {
  return {
    authenticatingUser: (params) => dispatch(authenticatingUser(params)),
    clearError: () => dispatch(clearError()),
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(Login);
