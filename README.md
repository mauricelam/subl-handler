SublimeText 2 and 3 URLHandler on OS X
================================
This application enables SublimeText to open `subl:` urls, as Textmate has as described [here](http://manual.macromates.com/en/using_textmate_from_terminal#url_scheme_html)

    subl://open/?url=file:///path/to/file.txt&line=10&column=2
    
As Sublime plugin
-----------------
I (Maurice) wrapped the URL Handler in Sublime Text plugin, which means you should not need to download this anymore unless you want to modify the source. The project can be found [here](https://github.com/mauricelam/subl-handler-plugin)

Installation
------------
Clone the repo and run the application via Xcode.

Select `SublHandler` -> `Preferences...`, then change the path for the subl binary if necessary.

Test it
-------
Open terminal and type:

    open 'subl://open/?url=file:///etc/paths&line=5'


Uninstalling
------------
Delete following:

    /Applications/SublHandler.app
    ~/Library/Preferences/com.asuth.sublhandler.plist

Author
------

* Daisuke Murase :@typester (github, twitter, CPAN, etc..)
* Scott Wadden (SublimeText 2 port)
* Andrew Sutherland (Mountain Lion fixes)

License
-------

BSD.

