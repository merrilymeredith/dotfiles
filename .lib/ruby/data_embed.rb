module DataEmbed
  module_function

  # Returns a hash of filename => content read from the DATA section of a given
  # source, or the caller.  Does not cache for you.  If given a handle, it is
  # read; a string, used as a file path to read; a module or class, its file is
  # guessed using +const_source_location+.
  #
  # Note: This isn't careful with encoding.  A battle-tested version of this
  # that should be okay with encodings can be found in Sinatra.
  #
  # @example Read my own data section
  #   files = DataEmbed.data_section(__FILE__)
  #
  # @example A specific module
  #   files = DataEmbed.data_section(Some::Class)
  #
  # @example The DATA global (only opened for $0 unlike perl)
  #   files = DataEmbed.data_section(DATA)
  #
  # @param source [Module, String, #read]
  # @return [{String => String}]
  def data_section(source)
    data =
      case source
      when Module
        File.read(Object.const_source_location(source.name)[0])
      when String
        File.read(source)
      else
        source.read
      end

    data
      .split(/^__END__$/, 2)
      .last
      .split(/^@@\s*(.+?)\s*\r?\n/m)
      .tap { _1.shift if _1.length.odd? }
      .each_slice(2)
      .to_h
      .transform_values { _1.gsub(/\n+\z/, "\n") }
  end

  # Process the given tmpl using ERB, with % trim enabled.  Either a binding or
  # a hash may be given.  Only locals are available to the template if a hash
  # is used.
  #
  # @param tmpl [String]
  # @param vars [Binding, Hash]
  # @return [String]
  def process_template(tmpl, vars)
    require "erb"

    ERB
      .new(tmpl, trim_mode: "%")
      .public_send(vars.is_a?(Binding) ? :result : :result_with_hash, vars)
  end

  # Process templates in both keys and values of the given hash
  # 
  # @param data [{String => String}]
  # @param vars [Binding, Hash]
  # @return [{String => String}]
  def process_templates(data, vars)
    data
      .transform_keys { process_template(_1, vars) }
      .transform_values! { process_template(_1, vars) }
  end
end
