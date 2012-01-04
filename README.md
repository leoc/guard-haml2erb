# Guard::Haml2Erb

Automatically convert HAML views to ERB via the Haml2Erb Gem.

Adapted from Guard-HAML at https://github.com/guard/guard-haml

## Install

As the gem name suggests this is a guard extension. Make sure you get [guard](https://github.com/guard/guard) first.

You will also need a copy of Haml2Erb, which can be obtained here: [https://github.com/elia/haml2erb](https://github.com/elia/haml2erb)
    
Simply add it to your Gemfile:

    gem 'haml2erb', :git=>'https://github.com/elia/haml2erb.git'

Now, Install the gem:

    gem install guard-haml2erb
  
Add it to your Gemfile if you're using bundler (you should)
  
    gem 'guard-haml2erb'
  
Add a basic guard setup:
  
    guard init haml2erb

## Options

If you want to change the output directory use the `output` option in your
Guardfile, e.g.:

    guard 'haml2erb', :output => 'public' do
      watch %r{^src/.+(\.html\.haml)}
    end

This output is relative to the Guardfile.

If you maintain your haml files in a directory that should not be part of the output path, you can set the `input` option, e.g.:

    guard 'haml2erb', :output => 'public', :input => 'src' do
      watch %r{^src/.+(\.html\.haml)}
    end

So when you edit a file `src/partials/_partial.html.haml`
it will be outputted in `public/partials/_partial.html` without the `src`.

## Development

* Source is hosted on [Github: guard-haml2erb](https://github.com/rubyjedi/guard-haml2erb)
* Report issues/questions/feature requests on the [Github Issue tracker for guard-haml2erb](https://github.com/rubyjedi/guard-haml2erb/issues)

Pull requests are welcome. 
Specs are very welcome, make sure you support both ruby 1.8.7 and  ruby 1.9.2.
