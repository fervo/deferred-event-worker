# Worker for FervoDeferredEventBundle
## Caveat
*This project is no longer actively developed by Fervo. We're still willing to merge PRs, but we're moving away from this internally. If you have a vested interest in this project and want to adopt it, contact us at magnus@fervo.se.*

## Usage
Install gems using bundler, ```bundle install```.

Configure the worker in config.yaml. I highly recommend using the FastCGI backend, since it's quite a bit faster.

Start sidekiq with ```bundle exec sidekiq -r ./workers/defer_event.rb```.

## Contributing
Please do. I'm not a Ruby coder, so I'm sure the code looks pretty horrible.
