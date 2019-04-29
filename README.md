# myNetwork | Backend
myNetwork is a web application written with a React-Redux frontend and a Rails API backend. It authorizes the user and sends back a token using JWT, authenticates users through BCrypt, and sends user-specific database information through serialization and custom methods.

## Demo
[myNetwork](https://youtu.be/q1ODMvxXRG0)

## Installation
Please note, this application requires both the front and backend. Click [here](https://github.com/canikwe/mynetwork-frontend) for instructions on installing and setting up the frontend. **Please follow all backend instructions _before_ proceeding with frontend installation**

### Ruby Version
Please check your Ruby version by typing `ruby -v` in your terminal prior to installing the application:
* Ruby 2.3.3
* Rails 5.2.3

Click [here](https://www.ruby-lang.org/en/documentation/installation/) for more information on installing Ruby and [here](https://guides.rubyonrails.org/v5.0/getting_started.html#installing-rails) for more information on installing Rails.

### Gem Installation

myNetwork uses Ruby gems for data serialization, authorization, and authentication. Please use [Bundler](https://bundler.io/) to manage this application's gems.

To start, please clone or download the repository to your computer. If you are already in your computer's terminal, cd into the directory. If you are in your computer's Finder or Explorer, right-click and select an option to open the directory in your terminal.

**Make sure you are in the mynetwork-backend directory before proceeding to the next step.**

Type `bundle install` to install all Ruby gems and dependencies.

### Database Creation
Head over to [PostgresSQL](https://www.postgresql.org/) to download the database this application uses.

Next, run the following commands in the terminal to set up the local myNetwork database:
```bash
rails db:create
rails db:migrate
rails db:seed
```

### Database Initialization
Type `rails s` to start the server. You should be hosting the development server on **localhost:3000**.

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
[GPL-3.0](https://choosealicense.com/licenses/gpl-3.0/)

