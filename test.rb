$LOAD_PATH.unshift 'lib'
require 'mypeople'

include Mypeople

Mypeople.configure do |config|
  config.host = "https://apis.daum.net"
  config.key = "API_KEY"
end

TEST_GROUP_ID = "GID_XXXX"
TEST_USER_ID = "BU_XXXXX"
TEST_CONTENT = "Mypeople ruby gem test #{Time.now}"
TEST_FILE_ID = "myp_pub:XXXXX"

# 그룹의 멤버들 얻기
#puts Mypeople::Group.members(TEST_GROUP_ID)

# 그룹에 메세지 보내기
#Mypeople::Group.send(TEST_GROUP_ID, TEST_CONTENT)

# 친구의 프로필 얻기
#puts Mypeople::Member.find(TEST_USER_ID)

# 파일
#puts Mypeople::File.download(TEST_FILE_ID, "profile.jpg")

# 친구(1:1)에게 메세지 보내기
#Mypeople::Member.send(TEST_USER_ID, TEST_CONTENT)

# 그룹에서 나가기
#Mypeople::Group.exit(TEST_GROUP_ID)
