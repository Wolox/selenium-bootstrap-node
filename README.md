## First steps

- Install ruby : `sudo apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev && gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB && curl -sSL https://get.rvm.io | bash -s stable source ~/.rvm/scripts/rvm rvm install 2.5.3 rvm use 2.5.3 --default`
- Add in config profile file ( .zshrc, .bashrc), `export PATH="$PATH:$HOME/.rvm/bin"` and `source ~/.rvm/scripts/rvm`.
- Move to project root and run `gem install bundler`.

To run the project, follow these steps:

- Clone this repository
- Move to project root and run `bundle install`
- Run `bundle exec cucumber`

## Generals

The automation projects use a feature -> step_definition -> views structure.
- Create `.feature` files in the `/features` folder to describe the scenario that is being tested with its steps.
- Create `.rb` files in the `/features/step_definition` folder to describe the process within each step.
- Create `.rb` files in the `views` folder to define modules and methods to provide the step_definition.

The `env.rb` file does the set up for the proyect.
- It loads all the files and modules.
- It creates the driver instance, which is needed to test the application.

In the `hooks.rb` file you can define actions to be executed after/before each feature/scenario/tag.

While the `views` files are meant to be specific for each feature, you can define more generic methods to use all across the apllication in the `helpers.rb` file.


## Documentation

- Cucumber: https://docs.cucumber.io/
- Ruby: https://ruby-doc.org/ - http://rubytutorial.wikidot.com/
- Rspec: http://rspec.info/documentation/

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
