class Profile {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String pincode;
  final String country;
  final String gender;
  final String captcha;

  Profile({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.pincode,
    required this.country,
    required this.gender,
    required this.captcha,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'pincode': pincode,
      'country': country,
      'gender': gender,
      'captcha': captcha,
    };
  }
}
