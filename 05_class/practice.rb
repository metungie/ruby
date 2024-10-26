class User
    attr_accessor :name, :email, :password
  
    def initialize(name, email, password)
      @name = name
      @email = email
      @password = password
      @rooms = []
    end
  
    def enter_room(room)
      @rooms << room unless @rooms.include?(room)
      room.add_user(self)
    end
  
    def send_message(room, content)
      if @rooms.include?(room)
        message = Message.new(self, room, content)
        room.broadcast(message)
      else
        puts "#{name} is not in the room '#{room.name}'."
      end
    end
  
    def acknowledge_message(room, message)
      puts "#{name} acknowledged message in '#{room.name}': #{message.content}"
    end
  end
  
  class Room
    attr_accessor :name, :description, :users
  
    def initialize(name, description)
      @name = name
      @description = description
      @users = []
    end
  
    def add_user(user)
      @users << user unless @users.include?(user)
    end
  
    def broadcast(message)
      @users.each do |user|
        user.acknowledge_message(self, message)
      end
    end
  end
  
  class Message
    attr_accessor :user, :room, :content
  
    def initialize(user, room, content)
      @user = user
      @room = room
      @content = content
    end
  end
  