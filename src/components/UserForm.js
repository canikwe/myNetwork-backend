import React, { useState, useEffect } from "react";
import { useSelector, useDispatch } from "react-redux";
import { addingUser, updatingUser } from "../redux/actions";
import { Segment, Grid, Button } from "semantic-ui-react";
import { isEmpty, pick } from "lodash";

function UserForm({ title, history }) {
  /** State + Actions */
  const user = useSelector((state) => state.user);
  const dispatch = useDispatch();
  const [form, setFormState] = useState({});

  /** Lifecycle Hooks */
  useEffect(() => {
    if (!isEmpty(user)) {
      const userForForm = pick(user, ["id", "avatar", "bio", "first_name", "last_name", "emai", "username", "email"]);
      setFormState({ ...userForForm, splash_image: user.splash_image || "" });
    }
  }, [user]);

  /** Form Handlers */
  const handleChange = (e) => {
    const value = e.target.name !== "photo" ? e.target.value : e.target.files[0];
    setFormState({ ...form, [e.target.name]: value });
  };

  const handleSubmit = () => {
    user.id ? dispatch(updatingUser(form, user.id)) : dispatch(addingUser(form));
    history.push("/");
  };

  return (
    <div className="wrapper">
      <h2>{title}</h2>
      <form>
        <Segment raised>
          <Grid columns={2}>
            <Grid.Column>
              <div className="ui form">
                <Segment compact>
                  <img className="ui small image" src={form.avatar || ""} alt="user_avatar" />
                </Segment>
                <label htmlFor="avatar">Avatar: </label>
                <br />
                <input type="text" name="avatar" value={form.avatar || ""} onChange={handleChange}></input>
                <br />
                {form.splash_image && (
                  <Segment>
                    <img className="ui img-splash" alt="user_splash_img" src={form.splash_image || ""} />
                  </Segment>
                )}

                <label htmlFor="splash_image">Splash Image: </label>
                <br />
                <input type="text" name="splash_image" value={form.splash_image || ""} onChange={handleChange}></input>
                <br />
              </div>
            </Grid.Column>

            <Grid.Column>
              <div className="ui form">
                <label htmlFor="first_name">First Name: </label>
                <input type="text" name="first_name" value={form.first_name || ""} onChange={handleChange}></input>
                <br />

                <label htmlFor="last_name">Last Name: </label>
                <input type="text" name="last_name" value={form.last_name || ""} onChange={handleChange}></input>
                <br />

                <label htmlFor="username">Username: </label>
                <input type="text" name="username" value={form.username || ""} onChange={handleChange}></input>
                <br />

                <label htmlFor="email">Email: </label>
                <input type="text" name="email" value={form.email || ""} onChange={handleChange}></input>
                <br />

                {isEmpty(user) && (
                  <>
                    <label htmlFor="password">Password: </label>
                    <input type="password" name="password" value={form.password || ""} onChange={handleChange}></input>
                    <br />
                  </>
                )}

                <label htmlFor="bio">Bio:</label>
                <br />
                <textarea name="bio" rows="6" value={form.bio || ""} onChange={handleChange}></textarea>
                <p />

                <Button onClick={handleSubmit}>Submit</Button>
              </div>
            </Grid.Column>
          </Grid>
        </Segment>
      </form>
    </div>
  );
}

export default UserForm;
