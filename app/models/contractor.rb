class Contractor < User
    def as_json(options={})
        super(options).merge({
            type: self.type
        })
    end
end
