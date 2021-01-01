class APIPath {
  static String users(String uid) => 'mohab_users/$uid';
  static String property(String pid) => 'mohab_properties/$pid';
  static String properties() => 'mohab_properties/';
  static String usersAll() => 'mohab_users/';
  static String post() => 'mohab_posts/';
  static String chatRoom() => 'mohab_messages/';
  static String setChatRoom(String id) => 'mohab_messages/$id';
  static String chat(String chatID) => 'mohab_messages/$chatID/chats';
}
