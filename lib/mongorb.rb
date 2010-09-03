lib_path = File.dirname __FILE__
$:.unshift File.expand_path(lib_path) unless [lib_path, File.expand_path(lib_path)].any? { |path| $:.include? path }

require 'activesupport'

module Mongorb
  extend ActiveSupport::Autoload

  autoload :Document
  autoload :Field
  autoload :FieldMethods
end
