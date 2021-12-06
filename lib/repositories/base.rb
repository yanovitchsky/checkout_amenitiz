module Repositories
  class Base
    def all
      entity.all
    end

    # def first
    #   entity.first
    # end

    # def last
    #   entity_dataset.last
    # end

    def find(id)
      entity_dataset.find(id)
      # rescue ActiveRecord::RecordNotFound => e
      #   raise RecordNotFoundError, e
    end

    def create(attributes)
      entity.create!(**attributes)
    end

    def update(id:, attributes:)
      instance = find(id)
      instance.update(**attributes)
      instance
    end

    def destroy(id)
      instance = find(id)
      attributes = instance.attributes
      instance.destroy
      attributes
    end

    def filter_by(key, value)
      entity.where("lower(#{key}) LIKE ?", "%#{value.downcase}%").all
    end

    private

    def entity
      raise NotImplementedError
    end

    # def entity_dataset
    #   entity.all
    # end

    # def validator
    #   nil
    # end

    # def validate(attributes)
    #   return ::OpenStruct.new(success?: true) if validator.nil?

    #   validator.new.call(attributes)
    # end

    # def full_error_messages(validation)
    #   validation.errors.to_h.map do |key, values|
    #     values.map do |value|
    #       [key, value].join(' ')
    #     end
    #   end.flatten
    # end
  end
end
