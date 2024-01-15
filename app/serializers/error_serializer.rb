class ErrorSerializer
  def self.format_errors(error)
    {
      errors: [
        {
          detail: error
        }
      ]
    }
  end
end
