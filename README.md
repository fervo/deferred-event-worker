# Worker for FervoDeferredEventBundle
## Usage
Install gems using bundler, ```bundle install```.

Configure the worker in config.yaml. I highly recommend using the FastCGI backend, since it's quite a bit faster.

Start sidekiq with ```bundle exec sidekiq -r ./workers/defer_event.rb```.

## Contributing
Please do. I'm not a Ruby coder, so I'm sure the code looks pretty horrible.
