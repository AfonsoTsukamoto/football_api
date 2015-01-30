##
# Borrowed from rails
# https://github.com/rails/rails/blob/5e51bdda59c9ba8e5faf86294e3e431bd45f1830/activesupport/lib/active_support/core_ext/object/blank.rb#L15
class Object
  def blank?
    respond_to?(:empty?) ? !!empty? : !self
  end
end