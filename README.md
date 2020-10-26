# Fortnite Opponents Stats

This gem provides real time stats from opponents you are playing against at a Fortnite match. It's executed with a command line.

It follows the following logic:

1. Take a screenshot from the kill feed of your game.
2. Apply transformations to the image to make it easier to interpret by an OCR, and then apply tesseract OCR to read the text from the image.
3. Parse the player usernames from the interpreted texts.
4. Retrieves the usernames stats with [FortniteAPI.io](https://fortniteapi.io/) API.
5. Print the retrieved usernames on terminal.

All this is inside a kernel loop, so while the command is not interrupted, it will keep running.

# PLACE GIF

## Requirements

1. Must have ruby installed.
2. Must have python3 installed to run Python script to take the screenshots.

## Installation

1. Clone this repository.

2. Install Ruby dependencies:

    ```bash
    bundle install
    ```

3. Install Python dependencies:

    ```bash
    pip3 install -r requirements.txt
    ```

4. Build the gem:

    ```bash
    gem build fortnite-opponents-stats
    ```

5. Install the gem (remember to change the gem version):

    ```bash
    gem install fortnite-opponents-stats-#{GEM VERSION}.gem
    ```

## Usage

After installing the gem, you will be able to run the script with the command line.

```bash
fortnite_opponents_stats YOUR_FORTNITE_API_KEY MONITOR_NUMBER PIXELS_FROM_TOP PIXELS_FROM_LEFT PIXELS_WIDTH PIXELS_HEIGHT OUTPUT_FOLDER
```

- **YOUR_FORTNITE_API_KEY**: [FortniteAPI.io](https://fortniteapi.io/) API. You can register for free for the basic usage.
- **MONITOR_NUMBER**: Monitor number where you are going to display Fortnite gameplay. It's very convinient if you have two monitors so to run the game and on the other display the console with the results.
- **PIXELS_FROM_TOP**: Pixels from top so to grab the top of the kill feed.
- **PIXELS_FROM_LEFT**: Pixels from left so to grab the left of the kill feed (this generally is 0).
- **PIXELS_WIDTH**: Width in pixels to grab the kill feed.
- **PIXELS_HEIGHT**: Height in pixels to grab the kill feed.
- **OUTPUT_FOLDER**: Folder to store the screenshots (must be empty before starting the script).

## Specs
### Image Reader Specs

Image read is done with Tesseract OCR with a previous processing of the image with Minimagick. When 
doing test over the image reader flow, you can use the tag `files` to run only the ones involved 
with this flow. 

```bash
bundle expec rspec --tag files
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### To Do

1. Add logs.
2. Add more information about the match for each parsed username (kills, kills with different weapons, etc).
3. Move Python screenshot logic to Ruby (must be Windows compatible mainly).
4. Add a friendly Ruby CLI toolkit (instead of using `ARGV`).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/francoprud/fortnite-opponents-stats. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/fortnite-opponents-stats/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Fortnite::Opponents::Stats project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/fortnite-opponents-stats/blob/master/CODE_OF_CONDUCT.md).
