= openvibe-launcher

A launcher for openvibe, in ruby

=== installation

`gem install openvibe-launcher`

=== usage

`ruby
openvibe = Openvibe::Launcher.new(DESIGNER_PATH,SCENARIO_PATH,MODE,OPTIONS)

openvibe.start
`
with MODE a string: 

* `--open`, by default
* `--play`
* `--play-fast`

and OPTIONS an Array containing:

* `--no-gui`
* `--no-session-management`

== Contributing to openvibe-launcher
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

== Copyright

Copyright (c) 2012 Alexandre Barachant. See LICENSE.txt for
further details.
