module Mypeople
  class Bot < Requirement
    class << self
      def exit(group_id)
        client.exit_from_group(buddy_id)
      end
    end
  end
end
