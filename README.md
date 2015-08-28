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

Or with a SASS import:

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

You will need to instantiate PageDown and pagedown-bootstrap-rails comes with `pagedown_init` for you to optionally include:

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

Just require it with Sprockets after `pagedown_bootstrap`:

``` javascript
//= require pagedown_bootstrap
//= require pagedown_init
```

## SimpleForm Integration
I like to then use a new [SimpleForm](https://github.com/plataformatec/simple_form) input:

``` ruby
class PagedownInput < SimpleForm::Inputs::TextInput
  def input
    out = "<div id=\"wmd-button-bar-#{attribute_name}\"></div>\n#{wmd_input}"

    if input_html_options[:preview]
      out << "\n<div id=\"wmd-preview-#{attribute_name}\" class=\"wmd-preview\"></div>"
    end

    out.html_safe
  end

  private

  def wmd_input
    @builder.text_area(
      attribute_name,
      input_html_options.merge(
        class: 'wmd-input form-control', id: "wmd-input-#{attribute_name}"
      )
    )
  end
end
```

Which you use in your form like so:

    = f.input :description, as: :pagedown, input_html: { preview: true, rows: 20 }

This is how it looks:

![Glorious](https://cldup.com/zCzX0kUgrW.png)
