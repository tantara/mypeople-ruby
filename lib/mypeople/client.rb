require 'net/http'
require 'forwardable'
require 'openssl'
require 'json'

module Mypeople
  class Configuration
    CONFIGURABLE_ATTRIBUTES = [
      :host,
      :key
    ]

    attr_accessor *CONFIGURABLE_ATTRIBUTES

    def self.configurable_attributes
      CONFIGURABLE_ATTRIBUTES
    end

    def initialize(attrs = {})
      self.attributes = attrs
    end

    def attributes=(attrs = {})
      attrs.each { |key, value| instance_variable_set("@#{key}", value)  }
    end

    def http
      uri = URI.parse(self.host)
      @http ||= Net::HTTP.new(uri.host, uri.port)
      @http.use_ssl = true
      @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      @http
    end

    def data
      @data = {"apikey" => @key}
    end
  end

  class Client
    extend Forwardable

    APIS = {
      :send_message_to_buddy => {:method => "POST", :path => "/mypeople/buddy/send.json"}, # 1:1 대화 메세지 보내기
      :buddy_profile => {:method => "GET", :path => "/mypeople/profile/buddy.json"}, # 친구 프로필 정보 보기
      :get_members => {:method => "GET", :path => "/mypeople/group/members.json"}, # 그룹 대화방 친구 목록 보기
      :send_message_to_group => {:method => "POST", :path => "/mypeople/group/send.json"}, # 그룹 대화방에 메세지 보내기
      :exit_from_group => {:method => "GET", :path => "/mypeople/group/exit.json"}, # 그룹 대화방 나가기
      :download_file => {:method => "GET", :path => "/mypeople/file/download.json"} # 파일 및 사진 받기
    }

    def_delegators :configuration, :credentials, *Configuration.configurable_attributes

    def initialize(attrs = {})
      self.configuration.attributes = attrs
    end

    def configure
      yield configuration if block_given?
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def request(method, path, data)
      http = configuration.http
      data = configuration.data.merge(data)

      case method
      when "GET"
        get(http, path, data)
      when "POST"
        post(http, path, data)
      end
    end

    def get(http, path, data)
      data = URI.encode_www_form(data)
      resp, body = http.send_request("GET", "#{path}?#{data}")

      JSON.parse(resp.body)
    end

    def post(http, path, data)
      data = URI.encode_www_form(data)
      resp, body = http.send_request("POST", path, data)

      JSON.parse(resp.body)
    end

    def send_message_to_buddy(buddy_id, content, attach = nil) 
      method = APIS[:send_message_to_buddy][:method]
      path = APIS[:send_message_to_buddy][:path]
      data = if content.empty?
               {
                 "buddyId" => buddy_id,
                 "attach" => attach
               }
             else
               {
                 "buddyId" => buddy_id,
                 "content" => content
               }
             end

      request(method, path, data)
    end

    def buddy_profile(buddy_id)
      method = APIS[:buddy_profile][:method]
      path = APIS[:buddy_profile][:path]
      data = {
        "buddyId" => buddy_id
      }

      request(method, path, data)
    end

    def get_members(group_id)
      method = APIS[:get_members][:method]
      path = APIS[:get_members][:path]
      data = {
        "groupId" => group_id
      }

      request(method, path, data)
    end

    def send_message_to_group(group_id, content, attach = nil) 
      method = APIS[:send_message_to_group][:method]
      path = APIS[:send_message_to_group][:path]
      data = {
        "groupId" => group_id,
        "content" => content
      }

      request(method, path, data)
    end

    def exit_from_group(group_id)
      method = APIS[:exit_from_group][:method]
      path = APIS[:exit_from_group][:path]
      data = {
        "groupId" => group_id
      }

      request(method, path, data)
    end

    def download_file(file_id, file_name)
      method = APIS[:download_file][:method]
      path = APIS[:download_file][:path]
      data = {
        "fileId" => file_id
      }

      request(method, path, data)
    end
  end
end
