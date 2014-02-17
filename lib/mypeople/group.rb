module Mypeople
  class Group < Requirement
    class << self
      def members(group_id)
        client.get_members(group_id)
      end

      def send(group_id, content)
        if content.is_a?(String) # string msg
          client.send_message_to_group(group_id, content)
        else # file msg
          client.send_message_to_group(group_id, "", content)
        end
      end

      def exit(group_id)
        client.exit_from_group(group_id)
      end
    end
  end
end
