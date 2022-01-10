import React, { Component } from 'react';
import './App.scss';
import { connect } from 'react-redux'
import { testAction, fetchingUser, notifyReminders, clearLoading, clearError } from './redux/actions'
import { Route, Switch, Redirect } from 'react-router-dom'
import Homepage from './containers/Homepage'
import Login from './components/Login'
import ContactForm from './components/ContactForm'
import NavBar from './components/NavBar'
import Calendar from './components/Calendar'
import ContactCardContainer from './containers/ContactCardContainer'
import { isEmpty } from 'lodash'
import toast from 'toasted-notes'
import { Image, Icon } from 'semantic-ui-react'
import 'toasted-notes/src/styles.css'
import Home from './containers/Home'
import { formatReminderToast } from './helper/functions';
import Footer from './components/Footer';
import ContactShow from './components/ContactShow';
import UserForm from './components/UserForm';

class App extends Component {

  componentDidMount(){
    this.props.testAction()
    const token = localStorage.getItem('token')

    if (token) {
      this.props.fetchingUser()
    } else {
      this.props.clearLoading()
    }
    
  }

  componentDidUpdate(){
    this.props.reminders.forEach(r => {
      if (r.match && !r.notified && !r.snoozed) {
        this.alerts(r)
        this.props.notifyReminders(r)
      }
    })

    if (this.props.notifications.length >= 1 || !isEmpty(this.props.notifications)) {
      if (this.props.notifications.status !== 500) {
        console.log(isEmpty(this.props.notifications.message))
        this.props.notifications.message.forEach(e => toast.notify(e, { duration: 5000 }))
        this.props.clearError()
      } else {
        toast.notify(this.props.notifications.error, { duration: 5000 })
        this.props.clearError()
      }
    }
  }

  alerts = reminder => {
    return reminder.match ? toast.notify(formatReminderToast(reminder, this.props.contacts), {position: 'bottom-left', duration: null}) : null
  }

  render() {
    if (this.props.loading) {
      return (
        <div className="App">
          <NavBar />
          <div className='loading'>
            {/* <Image
              centered 
              src='./images/loading_screen.gif'
            /> */}
            <Icon
              name='spinner'
              loading
              size='massive'
            />
          </div>
        </div>
      )
    } else {
      return (
        <div className="App">
          <NavBar />
          <main className='main-content'>
            <Switch>

              <Route exact path='/' render={() => {
                return isEmpty(this.props.user) ? <Redirect to='/login' /> : <Homepage />
              }}
              />

              <Route exact path='/login' render={() => {
                return isEmpty(this.props.user) ? <Login /> : <Redirect to='/' />
              }}
              />

              <Route exact path='/contacts/new' render={() => {
                return !isEmpty(this.props.user) ? <ContactForm /> : <Redirect to='/login' />
              }}
              />

              <Route exact path='/signup' render={routeProps => {
                return isEmpty(this.props.user) ? <UserForm title='Sign Up Here' {...routeProps} /> : <Redirect to='/' />
              }}
              />

              <Route exact path='/profile/edit' render={routeProps => {
                return !isEmpty(this.props.user) ? <UserForm title='Account Settings' {...routeProps} /> : <Redirect to='/login' />
              }} 
              />

              <Route exact path='/calendar' render={() => {
                return !isEmpty(this.props.user) ? <Calendar /> : <Redirect to='/login' />
              }}
              />

              <Route exact path='/friends' render={() => {
                return !isEmpty(this.props.user) ? <ContactCardContainer /> : <Redirect to='/login' />
              }}
              />

              <Route exact path='/friends/:id' render={props => {
                const friendId = parseInt(props.match.params.id)
                const friend = this.props.contacts.find(c => c.id === friendId)
                const reminders = this.props.reminders.filter(r => r.contact_id === friendId)

                return !isEmpty(this.props.user) && friend ? (
                  <div className='contact-details'>
                    <ContactShow contact={friend} reminders={reminders}/> 
                  </div>
                ) : <Redirect to='/login' />
              }}
              />

              <Route exact path='/home' component={Home}/>

              <Redirect from='*' to='/' />

            </Switch>
          </main>
          <Footer />
          {/* {this.props.reminders.map(r => this.alerts(r))} */}

        </div>
      );
    }
  }
}

const mapStateToProps = state => {
  return {
    user: state.user,
    loading: state.loading,
    reminders: state.reminders,
    notifications: state.notifications,
    contacts: state.contacts
  }
}

const mapDispatchToProps = dispatch => {
  return {
    testAction: () => dispatch(testAction()),
    //Delete after auth implementation!!
    fetchingUser: (token) => dispatch(fetchingUser(token)),
    notifyReminders: (r) => dispatch(notifyReminders(r)),
    clearLoading: () => dispatch(clearLoading()),
    clearError: () => dispatch(clearError())

  }
}

export default connect(mapStateToProps, mapDispatchToProps)(App);
