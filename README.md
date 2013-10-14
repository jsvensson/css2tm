# CSS to TextMate theme parser #

How long did it take you to get tired of writing a `.tmTheme` file by hand? If it was more than ten minutes then you are a stronger man than I.

Since the scope selector way of theming TextMate and Sublime Text 2 fits CSS like a glove, I decided to write a little something that lets me write a theme in CSS (actually, I write it in [LESS][less]) and then convert that to a `.tmTheme` file that I never have to look at again.

I'm not exactly stellar at Ruby, but I think I dare show this to the world without blushing too much.

## Installation ##

* `git clone FIXME-repo`
* `bundle install`

## Usage ##

I highly recommend using something like [LESS][less] or [SASS][sass] to actually write your theme, since that lets you use variables for your colors. Once you've got that turned into CSS, the rest is easy.

`css2tm your-theme.css > output.tmTheme`

## Theme format ##

Write plain old CSS! Text strings are parsed literally and do not need to be enclosed in citation marks.

A couple of id selectors are used for theme configuration: `#theme` and `#settings`.

`#theme` contains nothing but the property `name` with your theme name as its value.

``` css
#theme {
  name: Your Theme Name;
}
```


`#settings` contains the basic color attributes for your theme:

``` css
#settings {
  background: #2b2b2b;
  caret: #999999;
  foreground: #e6e1dc;
  invisibles: #404040;
  lineHighLight: #333435;
  selection: #5a647ee0;
}
```

Everything else is written like a standard CSS tag selector, with the scope for your theme being the selector:

``` css
comment {
  name: Comment;
  fontStyle: italic;
  foreground: #a0a0a0;
}

string {
  name: String;
  foreground: #a5c261;
}

punctuation.definition.string {
  name: String punctuation;
  foreground: #d0d0ff;
}

constant.character.escape {
  name: Escape character;
  foreground: #da4939;
}
```

## Case sensitivity ##

Be warned: the `.tmTheme` format likes to engage in random acts of camelCase. All properties are lowercase except the following:

* `fontStyle`
* `lineHighLight` (I don't even)

## Known bugs ##

* `fontStyle` or any other attribute with uppercase letters do not work, because whoever made the `.tmTheme` format thought camelCase was an awesome idea (it isn't) and the theme format (at least when parsed by ST2) is case-sensitive. The CSS parser gem for ruby, bless its infinite wisdom, chooses to mess with what I write and turn all attributes into downcase. May have to fork the gem and ship this with a tweaked version.

## To do ##

* Wrap it up into a gem

[less]: http://lesscss.org/
[sass]: http://sass-lang.com/
