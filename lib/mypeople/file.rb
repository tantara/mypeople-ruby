module Mypeople
  class File < Requirement
    def self.download(file_id)
      client.download_file(file_id)
    end
  end
end
