# Mypeople

Daum에서 제공하는 API를 루비 버전으로 묶은 gem입니다.

## Installation

Add this line to your application's Gemfile:

    gem 'mypeople'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mypeople

## Usage

### Setup

	# config/initialize/mypeople.rb
	
	require 'mypeople'
	
	Mypeople.configure do |config|
		config.host = "https://api.daum.net"
		config.key = "다음 API 콘솔에서 발급 받은 키"
	end
	
### 그룹의 멤버 구하기

	group_id = "GID_XXX"
	Mypeople::Group.members(group_id)
	
### 그룹에 메세지(텍스트) 보내기
	group_id = "GID_XXX"
	Mypeople::Group.send(group_id, "Hello World")
	
### 그룹에서 나가기
	group_id = "GID_XXX"
	Mypeople::Group.exit(group_id)
	
### 친구의 프로필 얻기
	buddy_id = "BU_XXX"
	Mypeople::Member.find(buddy_id)
	
### 친구(1:1)에게 메세지(텍스트) 보내기
	buddy_id = "BU_XXX"
	Mypeople::Member.send(buddy_id, "Hello World")
	
### 다른 예제
	test.rb 참고
	
## Rails Example

[https://github.com/tantara/mypeople-rails](https://github.com/tantara/mypeople-rails)
	
	
## Contributing

1. Fork it ( http://github.com/<my-github-username>/mypeople/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## Contact

	1. Taekmin Kim (tantara.tm@gmail.com)
