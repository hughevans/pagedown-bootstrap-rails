# PageDown Bootstrap Rails

A Ruby gem version of [https://github.com/tchapi/pagedown-bootstrap](https://github.com/tchapi/pagedown-bootstrap) for the Rails asset pipeline.

## Installation

Add to your `Gemfile`:

    gem 'pagedown-bootstrap-rails'
    gem 'bootstrap-sass' # check version
    gem 'sass-rails', # check version
    gem 'font-awesome-rails'

In Rails 3.1 or Rails 3.2 this goes in the `:asset` group, but in Rails 4 it goes with the top level gems.

You will also need Bootstrap and FontAwesome for PageDown Bootstrap Rails to work.

## Usage

Require the CSS with Sprockets:

    /*= require pagedown_bootstrap */

Or with a SASS import:

    @import "pagedown_bootstrap";

Sprockets require the JS too:

    //= require pagedown_bootstrap

Or individually as you please:

    //= require markdown.converter
    //= require markdown.editor
    //= require markdown.sanitizer
    //= require markdown.extra

You will need to instantiate PageDown and pagedown-bootstrap-rails comes with `pagedown_init` for you to optionally include:

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

Just require it with Sprockets after `pagedown_bootstrap`:

    //= require pagedown_bootstrap
    //= require pagedown_init

## [SimpleForm](https://github.com/plataformatec/simple_form) Integration
I like to then use a new [SimpleForm](https://github.com/plataformatec/simple_form) input:

    class PagedownInput < SimpleForm::Inputs::TextInput
      def input(wrapper_options)
        out = "<div id=\"wmd-button-bar-#{attribute_name}\"></div>\n"
        html_options = input_html_options.merge(class: 'wmd-input', id: "wmd-input-#{attribute_name}")
        out << "#{@builder.text_area(attribute_name, merge_options(html_options, wrapper_options)) }"
        if input_html_options[:preview]
          out << "<div id=\"wmd-preview-#{attribute_name}\" class=\"wmd-preview\"></div>"
        end
        out.html_safe
      end

      private

      def merge_options(html_opts, wrapper_opts)
        html_opts.merge(wrapper_opts) { |_key, first, second| first + ' ' + second }
      end
    end

Which you use in your form like so:

    = f.input :description, as: :pagedown, input_html: { preview: true, rows: 20 }

This is how it looks:

![Glorious](http://f.cl.ly/items/1f2H1x1F1D0o0n2r1p02/pagedown-bootstrap.png)

## [Formtastic](https://github.com/plataformatec/simple_form) Integration

    class PagedownInput < Formtastic::Inputs::StringInput
    
      def input_html_options
        super.merge(:class => "wmd-input", :id => "1")
      end
    
      def to_html
        id = input_html_options[:id]
        options = input_html_options.merge(id: "wmd-input-#{id}")
    
        input_wrapping do
          label_html <<
              template.content_tag(:div, "", :class => 'wmd-panel') do
                template.content_tag(:div, "", :class => 'wmd-button-bar', id: "wmd-button-bar-#{id}") <<
                    builder.text_area(method, options)
              end <<
    
              template.content_tag(:div, "", :style=> 'margin-top:20px' ) do
                template.content_tag(:label, "Preview" ) <<
                    template.content_tag(:div, "", :class => "wmd-panel wmd-preview", id: "wmd-preview-#{id}")
    
    
              end
        end.html_safe
      end
    end
