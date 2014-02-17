module Mypeople
  class File < Requirement
    def self.download(file_id, file_name)
      client.download_file(file_id, file_name)
    end
  end
end
