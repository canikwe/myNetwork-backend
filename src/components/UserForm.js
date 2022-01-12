import React, { useState, useEffect } from "react";
import { useSelector, useDispatch } from "react-redux";
import { addingUser, updatingUser } from "../redux/actions";
import { Segment, Grid, Button } from "semantic-ui-react";
import { isEmpty } from "lodash";

function UserForm(props) {
  const user = useSelector((state) => state.user);
  const dispatch = useDispatch();

  const [form, setFormState] = useState({
    id: "",
    avatar:
      "https://ayogo.com/wp-content/uploads/2015/06/jp-avatar-placeholder.png",
    bio: "",
    first_name: "",
    last_name: "",
    email: "",
    username: "",
    password: "",
    splash_image: "",
  });

  useEffect(() => {
    // Update the document title using the browser API
    if (!isEmpty(user)) {
      console.log("here");
      const {
        id,
        avatar,
        bio,
        first_name,
        last_name,
        email,
        username,
        splash_image,
      } = user;
      setFormState({
        id,
        avatar,
        bio,
        first_name,
        last_name,
        email,
        username,
        splash_image: splash_image || "",
      });
    }
  }, [user]);

  const handleChange = (e) => {
    if (e.target.name !== "photo") {
      setFormState({
        ...form,
        [e.target.name]: e.target.value,
      });
    } else {
      setFormState({
        ...form,
        [e.target.name]: e.target.files[0],
      });
    }
  };

  const handleSubmit = () => {
    const formObj = { ...form };

    if (user.id) {
      dispatch(updatingUser(formObj, user.id));
    } else {
      dispatch(addingUser(formObj));
    }

    props.history.push("/");
  };

  const {
    avatar,
    bio,
    first_name,
    last_name,
    email,
    username,
    password,
    splash_image,
  } = form;
  return (
    <div className="wrapper">
      <h2>{props.title}</h2>
      <form onChange={(e) => console.log(e.target)}>
        <Segment raised>
          <Grid columns={2}>
            <Grid.Column>
              <div className="ui form">
                <Segment compact>
                  <img
                    className="ui small image"
                    src={avatar}
                    alt="user_avatar"
                  />
                </Segment>
                <label htmlFor="avatar">Avatar: </label>
                <br />
                <input
                  type="text"
                  name="avatar"
                  value={avatar}
                  onChange={handleChange}
                ></input>
                <br />
                {splash_image !== "" ? (
                  <Segment>
                    <img
                      className="ui img-splash"
                      alt="user_splash_img"
                      src={splash_image}
                    />
                  </Segment>
                ) : null}

                <label htmlFor="splash_image">Splash Image: </label>
                <br />
                <input
                  type="text"
                  name="splash_image"
                  value={splash_image}
                  onChange={handleChange}
                ></input>
                <br />
              </div>
            </Grid.Column>

            <Grid.Column>
              <div className="ui form">
                <label htmlFor="first_name">First Name: </label>
                <input
                  type="text"
                  name="first_name"
                  value={first_name}
                  onChange={handleChange}
                ></input>
                <br />

                <label htmlFor="last_name">Last Name: </label>
                <input
                  type="text"
                  name="last_name"
                  value={last_name}
                  onChange={handleChange}
                ></input>
                <br />

                <label htmlFor="username">Username: </label>
                <input
                  type="text"
                  name="username"
                  value={username}
                  onChange={handleChange}
                ></input>
                <br />

                <label htmlFor="email">Email: </label>
                <input
                  type="text"
                  name="email"
                  value={email}
                  onChange={handleChange}
                ></input>
                <br />

                {isEmpty(user) && (
                  <>
                    <label htmlFor="password">Password: </label>
                    <input
                      type="password"
                      name="password"
                      value={password}
                      onChange={handleChange}
                    ></input>
                    <br />
                  </>
                )}

                <label htmlFor="bio">Bio:</label>
                <br />
                <textarea
                  name="bio"
                  rows="6"
                  value={bio}
                  onChange={handleChange}
                ></textarea>
                <p />
                {/* 
            <label htmlFor='photo'>Photo:</label><br />
            <input type='file' name='photo' onChange={this.handleChange}/>  */}

                <Button onClick={handleSubmit}>Submit</Button>
              </div>
            </Grid.Column>
          </Grid>
          {/* <img alt="user-profile-pic" src={`${BASE_URL()}/${user.photo}`} /> */}
        </Segment>
      </form>
    </div>
  );
}

export default UserForm;
