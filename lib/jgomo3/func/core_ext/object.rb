class Object

  # Returns a Proc which always return the given object
  #
  #   constantly_true = true.constantly
  #   constantly_true.call(1234) => true
  #   constantly_true.call(nil) => true
  #   constantly_true.call('HOLA') => true
  def constantly
    Proc.new { self }
  end

  # Returns a Proc which negates the result of calling the argumented
  # callable object.
  #
  #   :positive?.complement.call(1) => false
  #   :nil?.complement.call(nil) => false
  def complement
    callable = case
               when respond_to?(:call)
                 self
               else
                 self.to_proc
               end
    ->(*args, **kwargs, &blk) { !callable.call(*args, **kwargs, &blk) }
  rescue NoMethodError => error
    case error.name
    when :to_proc
      raise ArgumentError, "Object is not 'Callable' so it can't have a complement function", caller
    else
      raise
    end
  end

  # Applies the given block to the object if the condition applied on
  # it holds true.  If not, it defaults to the object as if `then_if`
  # was not called.
  #
  #   +1.then_if(:positive?) { _1 * 1000 } => 1_000
  #   -1.then_if(:positive?) { _1 * 1000 } => -1
  def then_if(condition)
    if condition.to_proc.call(self)
      yield self
    else
      self
    end
  end

  # Applies the given block to the object if the condition applied on
  # it doesn't hold true.  If not, it defaults to the object as if
  # `then_unless` was not called.
  #
  #   +1.then_if(:positive?) { _1 * 1000 } => 1_000
  #   -1.then_if(:positive?) { _1 * 1000 } => -1
  def then_unless(condition, &block)
    then_if(condition.complement, &block)
  end
end
