class UserModel{
  late int id;
  late String userName;
  late String email;
  late String firstName;
  late String lastName;
  late String gender;
  late String image;
  late String token;
  late String refreshToken;

  UserModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userName = json['username'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    gender = json['gender'];
    image = json['image'];
    token = json['token'];
    refreshToken = json['refreshToken'];
  }
}