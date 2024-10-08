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

  # If the receiver object is callabale, returns a Proc which negates
  # the result of calling the argumented callable object.
  #
  # If it is not a callable, it returns it's negated value
  #
  #   :positive?.complement.call(1) => false
  #   :nil?.complement.call(nil) => false
  #   false.complement => true
  def complement
    callable = case
               when respond_to?(:call)
                 self
               when respond_to?(:to_proc)
                 self.to_proc
               end
    if callable
      ->(*args, **kwargs, &blk) { !callable.call(*args, **kwargs, &blk) }
    else
      !self
    end
  end

  def callable_for(criteria)
    case
    when criteria.respond_to?(:call)
      criteria
    when criteria.respond_to?(:to_proc)
      criteria.to_proc
    end
  end

  # Applies the given block to the object if the criteria applied on
  # it holds true.  If not, it defaults to the object as if `then_if`
  # was not called.
  #
  # The criteria can be a callable predicate, in which case the
  # criteria is evaluated with the object as argument. It not, then
  # the criteria will be interpreted by it's truth value.
  #
  # If no criteria is given, then the receiver truth value will be
  # considered the criteria.
  #
  #   +1.then_if(:positive?) { _1 * 1000 } => 1_000
  #   -1.then_if(:positive?) { _1 * 1000 } => -1
  #   +1.then_if(true)       { _1 * 1000 } => 1_000
  #   +1.then_if(false)      { _1 * 1000 } => 1
  #   true.then_if           { :effect }   => :effect
  #   false.then_if          { :effect }   => false
  def then_if(*args)
    condition = if args.empty?
                  self
                elsif args.size == 1
                  criteria = args.first
                  callable_for(criteria)
                    .then{|callable| !!(callable ? callable.call(self) : criteria) }
                else
                  raise ArgumentError, "Wrong number of arguments (given #{args.size}, expected 0 or 1)"
               end

    if condition
      yield self
    else
      self
    end
  end

  # Applies the given block to the object if the criteria applied on
  # it doesn't hold true.  If not, it defaults to the object as if
  # `then_unless` was not called.
  #
  # The criteria can be a callable predicate, in which case the
  # criteria is evaluated with the object as argument. It not, then
  # the criteria will be interpreted by it's truth value.
  #
  #   +1.then_unless(:positive?) { _1 * 1000 } => 1
  #   -1.then_unless(:positive?) { _1 * 1000 } => -1_000
  #   +1.then_unless(false)      { _1 * 1000 } => 1_000
  #   +1.then_unless(true)       { _1 * 1000 } => 1
  def then_unless(criteria, &block)
    then_if(criteria.complement, &block)
  end
end
