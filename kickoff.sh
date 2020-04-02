gitclonecd() {
  git clone -q "$1" && cd "$(basename "$1" .git)" 
}

echo -e "Welcome to the QA Automation kickoff!\n"
read -p "Please copy your Github repository: " github_repo_link
echo "Cloning repository..."
gitclonecd $github_repo_link
echo "Installing required gems..."
echo "source 'https://rubygems.org'" >> Gemfile
echo "gem 'rails'" >> Gemfile
echo "gem 'cucumber'" >> Gemfile
echo "gem 'selenium-cucumber'" >> Gemfile
echo "gem 'selenium-webdriver'" >> Gemfile
bundle install --quiet
echo "Initializing Cucumber..."
bundle exec cucumber --init > /dev/null
echo "Committing changes to Github..."
git checkout -q -b kickoff
git add .
git commit -q -m "Kickoff"
git push origin HEAD
echo -e "\nDone!"
