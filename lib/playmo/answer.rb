module Playmo
  class Answer
    attr_accessor :answer, :options
    @@counter = 0

    def initialize(answer, options, &block)
      @answer  = answer
      @options = options

      # &block - это то, что нужно сделать (choice или exec)
      #puts self.to_s
    end

    def default?
      options.try(:[], :default) == true
    end

    def render
      if @answer
        @@counter += 1
        result = "#{@@counter}. #{@answer}"
        result << " (default)" if default?
        result
      end
    end

    alias :to_s :render
  end
end


__END__
module Playmo
  class Answer < Thor::Shell::Basic
    attr_accessor :answer_text, :method_name, :num

    def initialize(answer_text, method_name, num)
      @answer_text  = answer_text
      @method_name  = method_name
      @num          = num
      @padding      = 0
    end

    def render
      "#{@num}. #{@answer_text}\n" if @answer_text
    end

    alias :to_s :render
  end
end