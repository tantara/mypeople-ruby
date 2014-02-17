module Mypeople
  class Member < Requirement
    class << self
      def find(buddy_id)
        client.buddy_profile(buddy_id)
      end

      def send(buddy_id, content)
        if content.is_a?(String) # string msg
          client.send_message_to_buddy(buddy_id, content)
        else # file msg
          client.send_message_to_buddy(buddy_id, "", content)
        end
      end
    end
  end
end
