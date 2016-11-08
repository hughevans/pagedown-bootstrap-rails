# PageDown Bootstrap Rails

A Ruby gem version of [https://github.com/tchapi/pagedown-bootstrap](https://github.com/tchapi/pagedown-bootstrap) for the Rails asset pipeline.

## Installation

Add to your `Gemfile`:

``` ruby
gem 'pagedown-bootstrap-rails'
```

You’ll also need Bootstrap 3 (Sass version) and Font Awesome.

## Usage

Require the CSS with Sprockets:

``` css
/*= require pagedown_bootstrap */
```

Or with an SCSS import:

``` scss
@import "pagedown_bootstrap";
```

Sprockets require the JS too:

``` javascript
//= require pagedown_bootstrap
```

Or individually as you please:

``` javascript
  //= require markdown.converter
  //= require markdown.editor
  //= require markdown.sanitizer
  //= require markdown.extra
```

You will need to initialize PageDown in your form, so PageDown Bootstrap Rails comes with `pagedown_init` for you to optionally include:

``` coffee
  $ ->
    $('textarea.wmd-input').each (i, input) ->
      attr = $(input).attr('id').split('wmd-input')[1]
      converter = new Markdown.Converter()
      Markdown.Extra.init(converter)
      help =
        handler: () ->
          window.open('http://daringfireball.net/projects/markdown/syntax')
          return false
        title: "<%= I18n.t('components.markdown_editor.help', default: 'Markdown Editing Help') %>"
      editor = new Markdown.Editor(converter, attr, help)
      editor.run()
```

Just require it after `pagedown_bootstrap`:

``` javascript
//= require pagedown_bootstrap
//= require pagedown_init
```

This obviously requires CoffeeScript and jQuery, so if you’re not using these then feel free to write your own initializer. Additionally, if you’re using Turbolinks then I suggest either using [jQuery Turbolinks](https://github.com/kossnocorp/jquery.turbolinks) or writing
your own initializer that does not rely on `jQuery.ready()` like the one above.

## SimpleForm

Here’s a [SimpleForm](https://github.com/plataformatec/simple_form) input that creates the correct HTML for the initializer above.

``` ruby
class PagedownInput < SimpleForm::Inputs::TextInput
  def input
    out = "<div id=\"wmd-button-bar-#{attribute_name}\"></div>#{wmd_input}"

    if input_html_options[:preview]
      out << "<div id=\"wmd-preview-#{attribute_name}\" class=\"wmd-preview\"></div>"
    end

    out.html_safe
  end

  private

  def wmd_input
    classes = input_html_options[:class] || []
    classes << 'wmd-input form-control'
    @builder.text_area(
      attribute_name,
      input_html_options.merge(
        class: classes, id: "wmd-input-#{attribute_name}"
      )
    )
  end
end
```

Which you use in your form like so:

``` ruby
= f.input :description, as: :pagedown, input_html: { preview: true, rows: 10 }
```

This is how it looks:

![Glorious](https://cldup.com/zCzX0kUgrW.png)
